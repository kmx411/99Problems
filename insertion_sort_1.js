// given an array with the last element out of place. Use insertion sort to place it in the correct location.
// output the array whenever it is mutated

function processData(size, array){
  var misplaced = array[size - 1];
  
  for( var i = size - 2; array[i] > misplaced; i-- ){
   array[i+1] = array[i]; 
   console.log(array);
  }

  array[i+1] = misplaced;
  console.log(array);
}
