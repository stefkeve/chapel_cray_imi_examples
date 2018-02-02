/**
* @file green.chpl
*
* @desription This program searchs for green numbers.
*             Green number is number if it is prime and if its digit's sum is
*             prime number as well.
*
* @usage chpl -o green green.chpl --fast
*        ./green <<arguments>>
*
* @arguments --totalNumbers - total numbers for checking whether are green numbers
*            --fileName     - output filename for result
*/

use IO;
use DynamicIters;

config const totalNumbers : int = 1000000;
config const fileName = "GreensOut.dat";


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
 * Sum number's digits values
 *
 * @param int (in) n - number
 *
 * @return int - sum of all number's digits
 */
proc digitsSum(in n : int) : int {
    var s = 0;

    while(n > 0) {
        s += n % 10;
        n = n / 10;
    }

    return s;
}

/**
 * main procedure
 */
proc main() {
    var primes : [{1..totalNumbers}] bool;
    var greens : [{1..totalNumbers}] bool;
    var oddNumbersRange = {1..totalNumbers-1} by 2;

    /* check in parallel on all cores whether number is prime in chunk size of
       50 numbers and store it in primes array */
    forall i in dynamic(oddNumbersRange, chunkSize = 50) do {
        primes[i] = isPrime(i);
    }

    primes[2] = true;

    // iterate parallel in chunks of 50 elements and check whether number is green
    forall i in dynamic(oddNumbersRange, chunkSize = 50) do {
        if(primes[i] && primes[digitsSum(i)]) then greens[i] = true;
    }
    // number 2 is green number as well
    greens[2] = true;

    // save found green numbers in file
    var greenFile 	    = open(fileName, iomode.cw);
    var greenFileWriter = greenFile.writer();

    for i in greens.domain do {
        if(greens[i]) then greenFileWriter.writeln(i);
    }

    greenFileWriter.close();
    greenFile.close();
}
