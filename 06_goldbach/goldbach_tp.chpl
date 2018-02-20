/**
* @file goldbach_tp.chpl
*
* @desription Goldbach's conjecture is one of the oldest and best-known unsolved
*             problems in number theory and all of mathematics. It states:
*             Every even integer greater than 2 can be expressed as the sum of
*             two primes. This program shows that the statement is correct until
*             specific number. Task parallelism model.
*
* @usage chpl -o goldbach_tp goldbach_tp.chpl --fast
*        ./goldbach_tp <<arguments>>
*
* @arguments --numOfTasks     - number of parallel tasks
*            --numOfIntervals - number of intervals
*/

use DynamicIters;
use Time;

config const numOfTasks   : int = here.maxTaskPar;
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

/**
 * main procedure
 */
proc main() {
    var timer : Timer;
    var primes : [{1..totalNumbers}] bool;
    var oddNumbersRange = {1..totalNumbers-1} by 2;
    var solutions : [{0..numOfTasks-1}] int;

    timer.start();
    // set primes
    forall i in dynamic(oddNumbersRange, chunkSize = 50) do {
        if(isPrime(i)) then primes[i] = true;
    }

    // 2 is prime as well
    primes[2] = true;

    coforall taskId in 0..numOfTasks-1 do {
        //Note: numOfTasks have to be even number
        // start index
        var i = 2*taskId + numOfTasks;
        var theorem = 0;

        while(i <= totalNumbers) {
            var j = 1;
            var found = true;

            while(found && j < i/2) {
                if(primes[j] && primes[i-j]) then found = false;
                j += 1;
            }

            if(found) then theorem = 1;

            i += numOfTasks*2;
        }

        solutions[taskId] = theorem;
    }

    var globalSolutions = + reduce solutions;
    var wallTime = timer.elapsed();

    if(globalSolutions > 0) {
        writeln("Theorem has not been proven");
    } else {
        writeln("Theorem has been proven");
    }

    writef("Wall clock time is = %.6dr\n", wallTime);
}
