/**
* @file gap_prime.chpl
*
* @desription This program searchs for the largest gap between a pair of
*             of consecutive prime numbers
*
* @usage chpl -o gap_prime gap_prime.chpl --fast
*        ./gap_prime <<arguments>>
*
* @arguments --numOfTasks   - number of parallel tasks
*            --totalNumbers - check for all numbers less than this number
*/

use Sort;

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

/**
 * main procedure
 */
proc main() {
    var globalPrimesDomain = {1..0};
    // empty array global primes
    var globalPrimes  : [globalPrimesDomain] int;
    var partialPrimes : [0..numOfTasks-1, 1..totalNumbers/(2*numOfTasks)] int;

    coforall taskId in 0..numOfTasks-1 do {
        var i = 2*taskId + 1;
        var k = 1;

        while(i <= totalNumbers/2) {
            if(isPrime(i)) {
                partialPrimes[taskId,k] = i;
                k+=1;
            }
            i += numOfTasks*2;
        }
    }

    for taskId in 0..numOfTasks-1 do {
        for p in partialPrimes do {
            if(p != 0) then globalPrimes.push_back(p);
        }
    }

    sort(globalPrimes);

    var maxGap = max reduce [i in 1..globalPrimesDomain.high-1] (globalPrimes[i + 1] - globalPrimes[i]);

    writef("Max gap between consecutive prime numbers is %i\n", maxGap);
}
