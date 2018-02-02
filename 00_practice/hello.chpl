config const n = 4;

coforall task in 1..n {
    writeln("Hello from task ", task," size ", n);
}
