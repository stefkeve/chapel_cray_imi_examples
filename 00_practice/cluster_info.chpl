/**
* @file  cluster_info.chpl
*
* @desription Printing cluster's nodes info
*
* @usage chpl -o cluster_info cluster_info.chpl
*        ./cluster_info <<arguments>>
*
* @arguments --numLocales  - number of nodes
*/

use Memory;

proc main() {
   writeln("========= IMI cluster info ==========\n");

   writeln("Program started with  ", numLocales, " requested nodes (numLocales)\n");

   for loc in Locales do {
      on loc {
         writeln("Node #", here.id, " info : ");
         writeln("  name : ", here.name);
         writeln("  processor cores : ", here.numPUs());
         writeln("  max parallelism : ", here.maxTaskPar);
         writeln("  memory : ", here.physicalMemory(unit=MemUnits.GB, retType=real), " GB");
         writeln("===============================\n");
      }
   }
}
