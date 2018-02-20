/**
* @file goldbach_dp.chpl
*
* @desription Goldbach's conjecture is one of the oldest and best-known unsolved
*             problems in number theory and all of mathematics. It states:
*             Every even integer greater than 2 can be expressed as the sum of
*             two primes. This program shows that the statement is correct until
*             specific number. Data parallelism model.
*
* @usage chpl -o goldbach_dp goldbach_dp.chpl --fast
*        ./goldbach_dp <<arguments>>
*
* @arguments --totalNumbers - upper bound for checking
*/

use DynamicIters;
use Time;

config const totalNumbers : int = 1000000;

// global primes array
var primes : [{0..totalNumbers}] bool;

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

/**
 * Check theorem for given number
 *
 * @param int n - number for check
 *
 * @return int - 1 if there are two primes numbers which sum gives n, 0 otherwise
 */
proc checkTheorem(n) : int {
    var i = 0;
    var upperBound = n/2;

    while(i < upperBound) {
        if(primes[i] && primes[n-i]) then return 1;
        i += 1;
    }

    return 0;
}

/**
 * main procedure
 */
proc main() {
    var timer : Timer;
    var oddNumbersRange  = {1..totalNumbers-1} by 2;
    var evenNumbersRange = {2..totalNumbers} by 2;

    timer.start();
    
    forall i in dynamic(1..totalNumbers, chunkSize=100) do {
        if(isPrime(i)) then primes[i] = true;
    }

    var globalSolutions = + reduce [n in dynamic(evenNumbersRange, chunkSize=100)] (checkTheorem(n));
    var wallTime = timer.elapsed();

    if(globalSolutions > 0) {
        writeln("Theorem has not been proven");
    } else {
        writeln("Theorem has been proven");
    }

    writef("Wall clock time is = %.6dr\n", wallTime);
}
