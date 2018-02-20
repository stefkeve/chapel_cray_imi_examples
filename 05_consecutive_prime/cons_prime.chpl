/**
* @file cons_prime.chpl
*
* @desription This program searchs for two consecutive odd numbers which are
*             prime and counts how many times that two numbers occurs.
*             Task parallelism model.
*
* @usage chpl -o cons_prime cons_prime.chpl --fast
*        ./cons_prime <<arguments>>
*
* @arguments --numOfTasks   - number of parallel tasks
*            --totalNumbers - check for all integers less than this number
*/
use Time;

config const numOfTasks   : int = here.maxTaskPar;;
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

/*
* main procedure
*/
proc main() {
    var timer : Timer;
    var solutions : [{0..numOfTasks-1}] int;

    timer.start();
    coforall taskId in 0..numOfTasks-1 do {
        var localSolutions = 0;
        var i = 2*taskId + 1;

        while(i < totalNumbers) {
            if(isPrime(i) && isPrime(i + 2)) {
                localSolutions += 1;
            }
            i += numOfTasks * 2;
        }

        solutions[taskId] = localSolutions;
    }

    var globalSolutions = + reduce solutions;
    var wallTime = timer.elapsed();

    writef("Total consecutive odd numbers which are prime less than %i is %i\n", totalNumbers, globalSolutions);
    writef("Wall clock time is = %.6dr\n", wallTime);
}
