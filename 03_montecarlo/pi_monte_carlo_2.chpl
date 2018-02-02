/**
* @file  pi_monte_carlo_2.chpl
*
* @desription Calculation of number PI using Monte carlo method with task
*             parallelism model. Updating RNG sequence in per task
*
* @usage chpl -o pi_monte_carlo_2 pi_monte_carlo_2.chpl --fast
*        ./pi_monte_carlo_2 <<arguments>>
*
* @arguments --numOfTasks  - number of parallel tasks
*            --numOfPoints - max number of points
*/

use Random;
use Math;

config const numOfTasks  : int = here.maxTaskPar;
config const numOfPoints : int = 1000000000;

const seed        = 3113511351351531;
const PI25DT      = 3.141592653589793238462643;
const nPerTask    = numOfPoints / numOfTasks;
const extraPoints = numOfPoints % numOfTasks;

/*
* main procedure
*/
proc main() {
    var partialCounts : [{0..numOfTasks-1}] int;

    coforall taskid in 0..numOfTasks-1 do {
        var rs = new RandomStream(eltType = real, parSafe = false, seed);
        var count = 0;
        var extraPointsForTask = 0 + (taskid < extraPoints); // true => 1, false => 0

        // unique sequence of random numbers per task
        var jumpSequence = 2 * (taskid * nPerTask + (if taskid < extraPoints then taskid else extraPoints)) + 1;
        rs.skipToNth(jumpSequence);

        for i in 1..nPerTask + extraPointsForTask do {
            count += ((rs.getNext()**2 + rs.getNext()**2) <= 1); // evaluate to 1 or 0
        }

        partialCounts[taskid] = count;
        delete rs;
    }

    var globalCount = + reduce partialCounts;
    var pi = 4.0 * globalCount / numOfPoints;

    writef("PI = %.22dr\n", pi);
    writef("Error is = %.16dr\n", abs(pi - PI25DT));
}
