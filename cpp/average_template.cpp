//Write a template function that returns the average of all the elements of an array. The
//arguments to the function should be the array name and the size of the array (type int).
//In main(), exercise the function with arrays of type int, long, double, and char.

#include <iostream>

using namespace std;

template <class T>
T average(T* arr, int size){
  T av = 0;
  for( int i = 0; i < size; i++ ){
    av += arr[i];
  }
  av /= size;
  return av;
}

int main(){
  int intArray[3] = {1,2,3};
  cout << average( intArray, 3 ) << endl;

  double doubleArray[3] = {1.00,2,3.99};
  cout << average( doubleArray, 3 ) << endl;

  char charArray[3] = {'a','b','c'};
  cout << average( charArray, 3 ) << endl;
}
