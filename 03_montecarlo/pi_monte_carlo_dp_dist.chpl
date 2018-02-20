/**
* @file  pi_monte_carlo_dp_dist.chpl
*
* @desription Calculation of number PI using Monte carlo method with
*             data parallelism model on multiple nodes on cluster using
*             block distribution of data.
*
* @usage chpl -o pi_monte_carlo_dp pi_monte_carlo_dp.chpl --fast
*        ./pi_monte_carlo_dp <<arguments>>
*
* @arguments --numLocales  - number of hosts
*            --numOfPoints - max number of points
*/

use Random;
use Math;
use BlockDist;
use Time;

config const numOfTasks  : int = here.maxTaskPar;
config const numOfPoints : int = 1000000000;

const PI25DT = 3.141592653589793238462643;

/*
* main procedure
*/
proc main() {
    var timer : Timer;
    var D = {1..numOfPoints} dmapped Block(boundingBox={1..numOfPoints});

    var rs = new RandomStream(eltType = real, parSafe = false);

    timer.start();
    /* Run the Monte Carlo method using data parallel reduction to compute count.
     * The reduction is over parallel loop iterating in zippered manner over
     * a tuple x,y generated randomly by RandomStream object.
     */
    var globalCount = + reduce [(x,y) in zip(rs.iterate(D, real), rs.iterate(D, real))] ((x**2 + y**2) <= 1.0);

    var pi = 4.0 * globalCount / numOfPoints;
    var wallTime = timer.elapsed();

    delete rs;

    writef("PI = %.22dr\n", pi);
    writef("Error is = %.16dr\n", abs(pi - PI25DT));
    writef("Wall clock time is = %.6dr\n", wallTime);
}
