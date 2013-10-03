// given an array with the last element out of place. Use insertion sort to place it in the correct location.
// output the array whenever it is mutated

function insertionSort(ar) {
    var misplacedi = ar.length - 1;
    var misplaced = ar[misplacedi];
    for(var i = misplacedi - 1; ar[i] > misplaced; i--){
        ar[i+1] = ar[i];
    }
    
    ar[i+1] = misplaced;
    return ar;
}

function processData(input) {
    var lines = input.split("\n");
    var ar = lines[1].split(" ");
    ar = ar.map(function(i){return parseInt(i);});
    
    for(var i = 2; i <= ar.length; i++){
        var start = ar.slice(0,i);
        var end = ar.slice(i,ar.length);
        ar = insertionSort(start).concat(end);
        ar.forEach(arrayPrint);
        process.stdout.write("\n");

    }
} 

function arrayPrint(element){
    process.stdout.write(element + " ");
}


process.stdin.resume();
process.stdin.setEncoding("ascii");
_input = "";
process.stdin.on("data", function (input) {
    _input += input;
});

process.stdin.on("end", function () {
   processData(_input);
});

