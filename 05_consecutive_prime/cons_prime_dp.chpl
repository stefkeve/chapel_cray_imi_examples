/**
* @file cons_prime_dp.chpl
*
* @desription This program searchs for two consecutive odd numbers which are
*             prime and counts how many times that two numbers occurs.
*             Data parallelism model.
*
* @usage chpl -o cons_prime_dp cons_prime_dp.chpl --fast
*        ./cons_prime_dp <<arguments>>
*
* @arguments --totalNumbers - check for all integers less than this number
*/

use DynamicIters;
use Time;

config const totalNumbers : int = 1000000;

/**
* Check whether number is prime
*
* @param int n - number for check
*
* @return bool - true if number is prime, false otherwise
*/
proc isPrime(n : int) : bool {
    if((n == 0) || (n == 1)) then return false;
    if(n == 2) then return true;
    for i in 2..n/2 do if((n % i) == 0) then return false;

    return true;
}

proc main() {
    var timer : Timer;
    // odds number domain
    var oddNumbersRange = {1..totalNumbers-1} by 2;

    timer.start();

    //slower
    //var globalSolutions = + reduce [n in oddNumbersRange] (prime(n) && prime(n+2));

    //faster
    var globalSolutions = + reduce [n in dynamic(oddNumbersRange, chunkSize=100)] (isPrime(n) && isPrime(n+2));
    var wallTime = timer.elapsed();

    writef("Total consecutive odd numbers which are prime less than %i is %i\n", totalNumbers, globalSolutions);
    writef("Wall clock time is = %.6dr\n", wallTime);
}
