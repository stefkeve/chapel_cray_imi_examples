/**
* @file 1d_heat_ftcs_dist.chpl
*
* @desription 1D heat conduction. Forward Time, Centered Space, distributed.
*
* @usage chpl -o 1d_heat_ftcs_dist 1d_heat_ftcs_dist.chpl --fast
*        ./1d_heat_ftcs_dist -nl <<numberLocales>> <<arguments>>
*
* @arguments --nX
*            --nSteps
*            --lenghtX
*            --alpha
*            --tMax
*            --outputFile
*
*/

use Math;
use Time;
use DimensionalDist2D;
use ReplicatedDim;
use BlockDim;

config const nX         = 20;
config const nSteps     = 10;
config const lenghtX    = 1.0;
config const alpha      = 0.1;
config const tMax       = 0.5;
config const outputFile = "1d_heat_temps_ftcs.csv";

/**
* Write temperatures in file
*
* @param array temps
*
* @return void
*/
proc writeToFile(temps) : void {
    var handler = open(outputFile, iomode.cw);
    var writer  = handler.writer();

    for step in temps.domain.dim(1) do
    writer.writef("t%i ", step);
    writer.writeln();

    for x in temps.domain.dim(2) {
        for step in temps.domain.dim(1) do {
            writer.writef("%dr ", temps[step, x]);
        }
        writer.writeln();
    }
    writer.close();
    handler.close();
}

/**
* main procedure
*/
proc main() {
    var timer : Timer;

    // switch Locales array to 2D because using DimensionalDist2D distribution
    var MyLocales = reshape(Locales[0..numLocales-1], {0..0, 0..numLocales-1});
    // domain
    const pDomain  = {0..nSteps, 1..nX};

    /* ReplicateDim specifier for first dimension, BlockDim specifier for second
       dimension. For each step we have the same distribution. i.e for n_steps = 3,
       nX = 8 and numLocales = 4, distribution will be:
       0 0 1 1 2 2 3 3
       0 0 1 1 2 2 3 3
       0 0 1 1 2 2 3 3
       where number in matrix presents locale (host) id.
    */
    const D = pDomain dmapped DimensionalDist2D(MyLocales,
               		                            new ReplicatedDim(numLocales = 1),
                                                new BlockDim(numLocales      = numLocales,
                                                             boundingBoxLow  = 1,
                                                             boundingBoxHigh = pDomain.dim(2).high));
    const interior = D.dim(2).expand(-1);
    const dx = lenghtX / (nX-1);
    const dt = tMax / (nSteps-1);
    const r  = alpha * dt/(dx**2);
    const r2 = 1 - 2*r;

    var temp : [D] real = 0.0;

    timer.start();

    // init temps
    forall i in interior do {
        temp[0,i] = sin(pi * (i-1)*dx);
    }

    for step in 1..nSteps do {
        forall i in interior do {
            temp[step, i] = r*temp[step-1, i-1] - r2*temp[step-1, i] + r*temp[step-1, i+1];
        }
    }

    var wallTime = timer.elapsed();

    writeln("Writing results to " , outputFile, " file");
    writef("Wall clock time is = %.6dr\n", wallTime);

    writeToFile(temp);
}
