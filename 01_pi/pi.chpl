/**
* @file pi.chpl
*
* @desription Calculation of PI number using numeral integration. (rectangle rule)
*
* @usage chpl -o pi pi.chpl --fast
*        ./pi <<arguments>>
*
* @arguments --numOfTasks     - number of parallel tasks
*            --numOfIntervals - number of intervals
*/

config const numOfTasks     : int = here.maxTaskPar;
config const numOfIntervals : int = 10000000;

const PI25DT = 3.141592653589793238462643;
const dx = 1.0 / numOfIntervals;
const d = dx / 2;

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
    var partialSums : [{1..numOfTasks}] real;

    coforall taskid in 1..numOfTasks do {
        var i = taskid - 1;
        var partialSum = 0.0;

        while(i < numOfIntervals) {
            partialSum += fun(dx * i + d);
            i += numOfTasks;
        }

        partialSums[taskid] = partialSum * dx;
    }

    // sum all partial sums found by tasks
    var pi = + reduce partialSums;

    writef("Pi = %.22dr\n", pi);
    writef("Error is = %.16dr\n", abs(pi - PI25DT));
}
