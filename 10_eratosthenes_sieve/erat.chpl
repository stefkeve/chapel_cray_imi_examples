/**
* @file erat.chpl
*
* @desription This program searchs for prime numbers using the sieve of
*             Erathosthenes way.
*
* @usage chpl -o erat erat.chpl --fast
*        ./erat <<arguments>>
*
* @arguments --totalNumbers - check for all integers less than this number
*/

use Math;
use Time;

config const totalNumbers : int = 100000000;

/*
* main procedure
*/
proc main() {
    var timer : Timer;
    var sqrtN = sqrt(totalNumbers):int;
    var primes : [{1..totalNumbers}] int;

    timer.start();
    primes[1] = true;

    for c in 2..sqrtN {
        if(primes[c] == false) {
            forall m in c*c..totalNumbers by c {
                if(primes[m] == false) then primes[m] = true;
            }
        }
    }

    var totalPrimes = + reduce [x in primes] (x == false);
    var wallTime = timer.elapsed();

    writef('Total number of primes is = %i\n', totalPrimes);
    writef("Wall clock time is = %.6dr\n", wallTime);
}
