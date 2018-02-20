/**
* @file circuit.chpl
*
* @desription Check whether circuit is satisfable. For which combination
*             of input values will circuit give output with value 1 and return
*             how many combinations of input values satisfy circuit.
*
* @usage chpl -o circuit circuit.chpl --fast
*        ./circuit <<arguments>>
*
* @arguments --numOfTasks - number of parallel tasks
*/
use Time;

config const numOfTasks : int = here.maxTaskPar;

/* Total number of input combinations
 * Input value can be 1 or 0 and circuit has 16 inputs so total number is 2^16
 */
const numOfCombinations : int = 65536;

/**
 * Extract bits for specific number and for specific bit position
 *
 * @param int n - number
 * @param int i - bit position
 *
 * @return bool - true if bit is 1, false otherwise
 */
proc extractBits(n, i) : bool {
    return if(n&(1<<i)) then true else false;
}

/**
 * Check circuit whether is satisfable for given input value
 *
 * @param int taskid - task id
 * @param int z      - input value
 *
 * @return int - 1 if circuit gives output 1, 0 otherwise
 */
proc checkCircuit(taskid : int, z : int) : int {
    var v : [{0..15}] bool;

    for i in v.domain do {
        v[i] = extractBits(z, i);
    }

    // check circuit logic for input bits combiantation
    if((v[0] || v[1]) && (!v[1] || !v[3]) && (v[2] || v[3])
    && (!v[3] || !v[4])  && (v[4] || !v[5])
    && (v[5] || !v[6])   && (v[5] || v[6])
    && (v[6] || !v[15])  && (v[7] || !v[8])
    && (!v[7] || !v[13]) && (v[8] || v[9])
    && (v[8] || !v[9])   && (!v[9] || !v[10])
    && (v[9] || v[11])   && (v[10] || v[11])
    && (v[12] || v[13])  && (v[13] || !v[14])
    && (v[14] || v[15]))
    {
        writef("%i) %i%i%i%i%i%i%i%i%i%i%i%i%i%i%i%i\n",taskid, v[0], v[1], v[2], v[3], v[4], v[5],
                                                                v[6], v[7], v[8], v[9], v[10], v[11],
                                                                v[12], v[13], v[14], v[15]);
        return 1;
    }

    return 0;
}

/*
* main procedure
*/
proc main() {
    var timer : Timer;
    var localSolutions : [{1..numOfTasks}] int;

    timer.start();
    coforall taskId in 1..numOfTasks do {
        var i = taskId;
        var localSolution : int = 0;

        while(i <= numOfCombinations) {
            localSolution += checkCircuit(taskId, i);
            i += numOfTasks;
        }

        localSolutions[taskId] = localSolution;
    }

    // sum all solution found by tasks
    var solutions = + reduce localSolutions;
    var wallTime  = timer.elapsed();

    writef("There are %i different solutions\n", solutions);
    writef("Wall clock time is = %.6dr\n", wallTime);
}
