#include <iostream>

#include "test.pb.h"

int main( int argc, char** argv ) {
  Test::Proto::Message* myMessage = new Test::Proto::Message();
  myMessage->set_name( "myMessage->set_name" );
  myMessage->set_string( "myMessage->set_string" );

  std::cout << "Message at " << myMessage << std::endl;
  std::cout << "- Name: " << myMessage->name() << std::endl;
  std::cout << "- String: " << myMessage->string() << std::endl;

  delete myMessage;
  return 0;
}
