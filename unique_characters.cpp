//determine if a string has all unique characters. Assuming 127 ascii characters.

#include <iostream>
#include <string>
using namespace std;

bool check_characters( string input ){
  int characters[127] = {0};

  for( int i = 0; i < input.length(); i++ ){
    char character = input[i];
    int ascii_val = static_cast<int>(character);

    if( characters[ascii_val] > 1 ) return false;
    else characters[ascii_val]++;
  }

  return true;
}

int main(){
  cout << check_characters("this_is_false");
  cout << check_characters("true");
}
