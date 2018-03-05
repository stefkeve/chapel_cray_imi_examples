/**
* @file 2d_heat_dist_rowwise.chpl
*
* @desription 2D heat conduction. Distributed (rowwise distribution) using
*             DimensionalDist2D with combinations of BlockDim and ReplicatedDim
*             specifiers per each dimension.
*
* @usage chpl -o 2d_heat_dist_rowwise 2d_heat_dist_rowwise.chpl --fast
*        ./2d_heat_dist_rowwise -nl <<numberLocales>> <<arguments>>
*/

use Time;
use DimensionalDist2D;
use ReplicatedDim;
use BlockDim;

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

    const pDomain  = {1..ncellsX, 1..ncellsY};

    // rowwise distribution
    var MyLocales = reshape(Locales[0..numLocales-1], {0..numLocales-1, 0..0});

    /* BlockDim specifier for first dimension, ReplicatedDim specifier for second
       dimension. We have the same distribution per column. i.e for ncellsX = 4,
       ncellsY = 8 and numLocales = 2, distribution will be:
       0 0 0 0 0 0 0 0
       0 0 0 0 0 0 0 0
       1 1 1 1 1 1 1 1
       1 1 1 1 1 1 1 1
       where number in matrix presents locale (host) id.
    */
    const D = pDomain dmapped DimensionalDist2D(MyLocales,
                           		                new BlockDim(numLocales = numLocales,
                                                             boundingBoxLow  = 1,
                                                             boundingBoxHigh = pDomain.dim(1).high),
		                                        new ReplicatedDim(numLocales = 1));

    const interior = D.expand(-1);
    const dx       = lengthX / ncellsX;
    const dy       = lengthY / ncellsY;

    var temp, tempNew : [D] real = 0.0;

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
