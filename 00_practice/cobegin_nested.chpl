writeln("3: ### The cobegin statement with nested begin statements ###");

cobegin {
  writeln("3: output from spawned task 1");
  writeln("3: output from spawned task 2");
}

writeln("3: output from main task");
