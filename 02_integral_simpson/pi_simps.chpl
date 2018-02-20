/**
 * @file  pi_simps.chpl
 *
 * @desription Calculation of number PI using Simpson's rule
 *
 * @usage chpl -o pi_simps pi_simps.chpl --fast
 *        ./pi_simps <<arguments>>
 *
 * @arguments --numOfTasks     - number of parallel tasks
 *            --numOfIntervals - number of intervals
 */

use Math;
use Time;

config const numOfTasks     : int = here.maxTaskPar;
config const numOfIntervals : int = 10000000;

const PI25DT = 3.141592653589793238462643;
const A  = 0.0;
const B  = 1.0;
const dx = B * 1.0 / numOfIntervals;
const d  = dx / 2;

/**
 * Curve function in x
 *
 * @param real x - x point
 *
 * @return real - y point
 */
proc fun(x:real) : real {
    return 4.0 / (1.0 + x*x);
}

/*
* main procedure
*/
proc main() {
    var timer : Timer;
    var partialSums : [{1..numOfTasks}] real;

    timer.start();
    coforall taskid in 1..numOfTasks do {
        var i = taskid;
        var partialSum = 0.0;

        while(i <= numOfIntervals/2) {
            partialSum += 4 * fun((2 * i - 1) * dx) + 2 * fun((2 * i) * dx);
            i += numOfTasks;
        }

        partialSums[taskid] = partialSum;
    }

    // sum all partial sums collected in tasks
    var globalSum = + reduce partialSums;
    // calculate pi number
    var pi = (fun(A) - fun(B) + globalSum) / (3.0 * numOfIntervals);
    var wallTime = timer.elapsed();

    writef("PI = %.22dr\n", pi);
    writef("Error is = %.16dr\n", abs(pi - PI25DT));
    writef("Wall clock time is = %.6dr\n", wallTime);
}
