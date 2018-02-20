/**
 * @file  pi_monte_carlo.chpl
 *
 * @desription Calculation of number PI using Monte carlo method with task
 *             parallelism model.
 *
 * @usage chpl -o pi_monte_carlo pi_monte_carlo.chpl --fast
 *        ./pi_monte_carlo <<arguments>>
 *
 * @arguments --numOfTasks     - number of parallel tasks
 *            --numOfPoints    - max number of points
 */

use Random;
use Random.RandomSupport;
use Math;
use Time;

config const numOfTasks  : int = here.maxTaskPar;
config const numOfPoints : int = 1000000000;

const PI25DT      = 3.141592653589793238462643;
const nPerTask    = numOfPoints / numOfTasks;
const extraPoints = numOfPoints % numOfTasks;

/*
* main procedure
*/
proc main() {
    var timer : Timer;
    var partialCounts : [{0..numOfTasks-1}] int;

    timer.start();
    
    coforall taskid in 0..numOfTasks-1 do {
        var seed = RandomSupport.SeedGenerator.currentTime + taskid;
        var rs = new RandomStream(eltType = real, parSafe = false, seed);
        var count = 0;
        var extraPointsForTask = 0 + (taskid < extraPoints); // true => 1, false => 0

        for i in 1..nPerTask + extraPointsForTask do {
    		count += ((rs.getNext()**2 + rs.getNext()**2) <= 1);
        }

        partialCounts[taskid] = count;
        delete rs;
    }

    var globalCount = + reduce partialCounts;
    var pi = 4.0 * globalCount / numOfPoints;
    var wallTime = timer.elapsed();

    writef("PI = %.22dr\n", pi);
    writef("Error is = %.16dr\n", abs(pi - PI25DT));
    writef("Wall clock time is = %.6dr\n", wallTime);
}
