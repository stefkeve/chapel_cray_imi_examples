/**
* @file 1d_heat_ftcs_wsr_dist.chpl
*
* @desription 1D heat conduction. Forward Time, Centered Space without step results,
*             distributed
*
* @usage chpl -o 1d_heat_ftcs_wsr_dist 1d_heat_ftcs_wsr_dist.chpl --fast
*        ./1d_heat_ftcs_wsr_dist -nl <<numLocales>> <<arguments>>
*
* @arguments --nX
*            --nSteps
*            --lenghtX
*            --alpha
*            --tMax
*/

use Math;
use Time;
use BlockDist;

config const nX         = 20;
config const nSteps     = 10;
config const lenghtX    = 1.0;
config const alpha      = 0.1;
config const tMax       = 0.5;

/**
* main procedure
*/
proc main() {
    var timer : Timer;
    const pDomain  = {1..nX} dmapped Block(boundingBox={1..nX});
    const interior = pDomain.expand(-1);
    const dx = lenghtX / (nX-1);
    const dt = tMax / (nSteps-1);
    const r  = alpha * dt/(dx**2);
    const r2 = 1 - 2*r;

    var temp, tempNew : [pDomain] real = 0.0;

    timer.start();

    // init temps
    forall i in interior do {
        temp[i] = sin(pi * (i-1)*dx);
    }

    for step in 1..nSteps do {
        forall i in interior do {
            tempNew[i] = r*temp[i-1] - r2*temp[i] + r*temp[i+1];
        }

        forall i in interior do {
            temp[i] = tempNew[i];
        }

        //slower copy
        //temp[interior] = tempNew[interior];
    }

    var wallTime = timer.elapsed();

    writeln("Results : " , temp);
    writef("Wall clock time is = %.6dr\n", wallTime);
}
