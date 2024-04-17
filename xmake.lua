set_project( "MinExample" )

set_version( "0.5.0", { build = "%Y%m%d", soname = true } )

set_warnings( "allextra" )

add_rules( "mode.debug", "mode.release", "mode.releasedbg", "mode.minsizerel" )
add_rules( "plugin.compile_commands.autoupdate", { outputdir = ".vscode" } )

if is_plat( "windows" ) then
    -- technically 11, but abseil (dep of protobuf-cpp) needs >=14, but uses >=17 types
    set_languages( "cxx17" )

    add_cxflags( "/Zc:__cplusplus" )
    add_cxflags( "/Zc:preprocessor" )

    add_cxflags( "/permissive-" )
else
    -- technically 11, but abseil (dep of protobuf-cpp) needs >=14, but uses >=17 types
    set_languages( "c++17" )
end

add_requireconfs( "*", { configs = { shared = get_config( "kind" ) == "shared" } } )

add_requires( "protobuf-cpp", { configs = { shared = get_config( "kind" ) == "shared" } } )
-- protobuf-* needs it and somehow just doesn't publicizes the linkage
--add_requires( "abseil" )
add_requires( "utf8_range" )

target( "MinExample" )
    set_kind( "binary" )
    set_default( true )
    set_group( "EXES" )

    add_packages( "protobuf-cpp", { public = true } )
    -- protobuf-* needs it and somehow just doesn't publicizes the linkage
    --add_packages( "abseil", { public = true } )
    add_packages( "utf8_range", { public = true } )

    add_rules( "protobuf.cpp" )

    add_files( "proto/*.proto", { proto_public = false } )
    add_files( "src/*.cpp" )

    before_run(function (target)
        import("private.action.run.runenvs")
        local addenvs, setenvs = runenvs.make(target)
        print("addenvs", addenvs)
        print("setenvs", setenvs)

        print("dump pkgs")
        for _, pkg in ipairs(target:orderpkgs()) do
            print(pkg:name())
            pkg:dump()
        end
    end)
