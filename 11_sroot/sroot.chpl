/**
* @file sroot.chpl
*
* @desription Root of function for
*             f(x) = -2 + sin(x) + sin(x^2) + sin(x^3) + ... + sin(x^1000)
*
* @usage chpl -o sroot sroot.chpl --fast
*        ./sroot <<arguments>>
*
* @arguments --numOfTasks - number of parallel tasks
*/

use Math;

config const numOfTasks : int = here.maxTaskPar;
const limit = 1.0e-11;

/**
 * Compute function for given x
 * f(x) = -2 + sin(x) + sin(x^2) + sin(x^3) + ... + sin(x^1000)
 *
 * @param real x
 *
 * @return real
 */
proc f(x : real) : real {
    var s = -2.0;
    var p = 1.0;

    for i in 1..999 {
        p *= x;
        s += sin(p);
    }

    return s;
}

/*
* main procedure
*/
proc main() {
    var D : {0..numOfTasks-1};
    var globalL : real = 0.0;
    var globalR : real = 1.0;
    var flags   : [D] int;
    var lefts   : [D] real;
    var rights  : [D] real;

    var part = globalR - globalL;

    while(part > limit) {
        part = part / numOfTasks;

        for i in D {
            lefts[i]  = globalL + i * part;
            rights[i] = lefts[i] + part;
        }

        coforall taskId in D do {
            if((f(lefts[taskId]) * f(rights[taskId])) < 0) {
                flags[taskId] = 1;
            }
        }

        /*forall i in lefts.domain do {
            if((f(lefts[i]) * f(rights[i])) < 0) {
                flags[i] = 1;
            }
        }*/

        var k = 0;

        while(flags[k] == 0) do k+=1;

        globalL += k * part;
        globalR = globalL + part;

        flags = 0;
    }

    writef("Smallest positive root of equation f is %10.9dr, f(x) = %13.12dr\n", globalL, f(globalL));
}
