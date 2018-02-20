/**
* @file gol.chpl
*
* @desription Game of life simulation
*
* @usage chpl -o gol gol.chpl --fast
*        ./gol <<arguments>>
*
* @arguments --gridSize     - grid size
*            --steps        - number of steps
*            --printingGrid - printing grid flag
*/

use Random;
use Time;

config const gridSize     : int  = 1000;
config const steps 	      : int  = 5000;
config const printingGrid : bool = false;

const BigD = {0..gridSize+1, 0..gridSize+1};
const D    = {1..gridSize, 1..gridSize};
var grid     : [BigD] bool;
var nextGrid : [D] bool;

/**
* Print grid
*/
proc printGrid() {
    write("+"); for i in 1..gridSize do write("-"); writeln("+");
    for i in D.dim(1) {
        write("|");
        for j in D.dim(2) {
            write(if grid(i,j) then "o" else " ");
        }
        writeln("|");
    }
    write("+"); for i in 1..gridSize do write("-"); writeln("+");
}

/*
* main procedure
*/
proc main() {
    var timer : Timer;
    var numberOfLivedCells : int;
    var rs = new RandomStream(eltType = real, parSafe = false);

    timer.start();

    forall (i,j) in D do {
        grid(i,j) = if rs.getNext() <= 0.5 then true else false;
    }

    for step in 1..steps {
        forall (i,j) in D {
            const neighbours =
            grid(i-1,j-1) + grid(i-1,j) + grid(i-1,j+1) +
            grid(i, j-1) +                grid(i,j+1)   +
            grid(i+1,j-1) + grid(i+1,j) + grid(i+1,j+1);

            if(neighbours == 3 || (neighbours == 2 && grid(i,j))) {
                nextGrid(i,j) = true;
            }
        }

        grid(D) = nextGrid;
        if(printingGrid) then printGrid();
    }

    numberOfLivedCells = + reduce grid(D);
    var wallTime = timer.elapsed();

    writef("Number of live cells = %i\n", numberOfLivedCells);
    writef("Wall clock time is = %.6dr\n", wallTime);

    delete rs;
}
