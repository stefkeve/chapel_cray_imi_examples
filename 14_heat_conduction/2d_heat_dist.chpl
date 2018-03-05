/**
* @file 2d_heat_dist.chpl
*
* @desription 2D heat conduction. Distributed (block distribution)
*
* @usage chpl -o 2d_heat_dist 2d_heat_dist.chpl --fast
*        ./2d_heat_dist -nl <<numberLocales>> <<arguments>>
*/

use Time;
use BlockDist;

config var ncellsX = 10,
           ncellsY = 10,
           nsteps  = 20,
           lengthX = 10,
           lengthY = 10,
           ao      = 1.0,
           coeff   = .375,
           sigma   = 3.0;

/*
* main procedure
*/
proc main() {
    var timer : Timer;
    const pDomain  = {1..ncellsX, 1..ncellsY} dmapped Block(boundingBox={1..ncellsX, 1..ncellsY});
    const interior = pDomain.expand(-1);
    const dx       = lengthX / ncellsX;
    const dy       = lengthY / ncellsY;

    var temp, tempNew : [pDomain] real = 0.0;

    timer.start();

    forall (i,j) in pDomain do {
        var x = (i-1)*dx;
        var y = (j-1)*dy;
        temp[i,j] = ao*exp(-x*x/(2.0*sigma*sigma)) + ao*exp(-y*y/(2.0*sigma*sigma));
    }

    for step in [1..nsteps] do {
        forall (i,j) in interior do {
            tempNew[i,j] = temp[i,j] + coeff*(temp[i-1, j] + temp[i+1,j] - 4.0*temp[i,j] +
                           	                  temp[i, j-1] + temp[i,j+1]);
        }

        temp[interior] = tempNew[interior];
    }

    var wallTime = timer.elapsed();

    writeln("Temps ", temp);
    writef("Wall clock time is = %.6dr\n", wallTime);
}
