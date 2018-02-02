/*const dnsDom = {1..5};

const newDom : domain(1) = {1..0};

var array1 : [1..8] int = [10,12,13,14,15,16,17,18];
var array2 : [1..8] int = [10,11,19,20,21,22,23,24];


var newArr : [newDom] int;

var spsDom: sparse subdomain(dnsDom);
var spsArr: [spsDom] int;

writeln("Initially, spsDom is: ", spsDom);
writeln("Initially, spsArr is: ", spsArr);


//spsDom += (1);
spsDom += {1..8};



//spsDom += {9..18};
//spsArr += array;
//spsDom += (1);

newArr.push_back(1);

writeln("Initially, dnsDom is: ", dnsDom);
writeln("Initially, spsDom is: ", spsDom.member(1));
writeln("Initially, spsArr is: ", spsArr);

writeln("Initially, newDom is: ", newDom);
writeln("Initially, newArr is: ", newArr);*/

//
config const numTasks = here.maxTaskPar;
if (numTasks < 1) then
  halt("numTasks must be a positive integer");

//
// If compiled with ``verbose`` set to ``true``, the leader and follower will
// print out some messages indicating what they're doing under the
// covers.
//
config param verbose = false;

//
// Declare a problem size for this test.  By default we use a small
// problem size to make the output readable.  Of course, to use the
// parallelism effectively you'd want to use a much larger problem
// size (override on the execution command-line using the
// ``--probSize=<n>`` option).
//
config const probSize = 15;
var A: [1..probSize] real;

// compiled with ``-sverbose=true``.
//
iter count(param tag: iterKind, n: int, low: int = 1)
       where tag == iterKind.standalone {
  if (verbose) then
    writeln("In count() standalone, creating ", numTasks, " tasks");
  coforall tid in 0..#numTasks {
    const myIters = computeChunk(low..#n, tid, numTasks);
    if (verbose) then
      writeln("task ", tid, " owns ", myIters);
    for i in myIters do
      yield i;
  }
}

/*
.. primers-parIters-usage
count: usage
------------
*/

// Now that we've defined leader-follower and standalone iterators, we can
// execute the same loops we did before, only this time using forall loops
// to make the execution parallel.  We start with some simple invocations
// as before.  In these invocations, the ``count()`` standalone parallel
// iterator is used since it is the only thing being iterated over (``A`` is
// being randomly accessed within the loop.)
//
forall i in count(iterKind.standalone, probSize) do
  A[i] = i:real;

writeln("After parallel initialization, A is:");
writeln(A);
writeln();

proc computeChunk(r: range, myChunk, numChunks) where r.stridable == false {
  const numElems = r.length;
  const elemsPerChunk = numElems/numChunks;
  const mylow = r.low + elemsPerChunk*myChunk;
  if (myChunk != numChunks - 1) {
    return mylow..#elemsPerChunk;
  } else {
    return mylow..r.high;
  }
}
