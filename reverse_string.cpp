#include <iostream>
#include <string>
using namespace std;

void reverse(string input){
  int start = 0;
  int end = input.length() - 1;

  while( start < end ){
    char temp = input[start];
    input[start] = input[end];
    input[end] = temp;
    start++;
    end--;
  }
}

int main(){
  reverse("test");
  return 0;
}
