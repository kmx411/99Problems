//given a nxm matrix filled with 1s and 0s,
//find the number of paths from the top left to
//the bottom right, without crossing through a 0.
//you may only move down, and right.


//1 1 0
//1 0 1
//--> 0

//1 1 1
//0 0 1
//--> 1


// in order to reach the bottom right, we will
// always need to travel down n times, and right m times
// recursive solution, try moving right, then move down for each right

var count = 0;

var countPaths = function (grid,i,j) {

  if ((grid.length == i) && (grid[0].length == j) && (grid[i - 1][j - 1] != 0)){
    count = count + 1;
    return;
  }

  if ((i < grid.length) && (grid[i - 1][j - 1] != 0)) {
    countPaths( grid, i + 1, j );
  }

  if ((j < grid[0].length) && (grid[i - 1][j - 1] != 0)) {
    countPaths( grid, i, j + 1 );
  }

}

var pathCounter = function(grid) {

  count = 0;
  countPaths(grid, 1, 1);
  console.log(count);

}

//TESTS
//------------

pathCounter( [ [1,1,1], [1,1,1], [0,0,1] ] );
// 1 1 1
// 1 1 1
// 0 0 1
// --> 3

pathCounter( [ [1,1,1], [1,1,1], [1,1,0] ] );
// 1 1 1
// 1 1 1
// 1 1 0
// --> 0

pathCounter( [ [0,1,1], [1,1,1], [1,1,1] ] );
// 0 1 1
// 1 1 1
// 1 1 1
// --> 0
