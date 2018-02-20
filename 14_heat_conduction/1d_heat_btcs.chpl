/**
* @file 1d_heat_btcs.chpl
*
* @desription 1D heat conduction. Backward Time, Centered Space
*
* @usage chpl -o 1d_heat_btcs 1d_heat_btcs.chpl --fast
*        ./1d_heat_btcs <<arguments>>
*
* @arguments --nX
*            --nSteps
*            --lenghtX
*            --alpha
*            --tMax
*            --outputFile
*/

use Math;
use Time;

config const nX	        = 20;
config const nSteps     = 10;
config const lenghtX    = 1.0;
config const alpha      = 0.1;
config const tMax       = 2.0;
config const outputFile = "1d_heat_temps_btcs.csv";

/**
* Write temperatures in file
*
* @param array temps
*
* @return void
*/
proc writeToFile(temps) : void {
    var handler = open(outputFile, iomode.cw);
    var writer  = handler.writer();

    for step in temps.domain.dim(1) do
    writer.writef("t%i ", step);
    writer.writeln();

    for x in temps.domain.dim(2) {
        for step in temps.domain.dim(1) do {
            writer.writef("%dr ", temps[step, x]);
        }
        writer.writeln();
    }

    writer.close();
    handler.close();
}

/*
* main procedure
*/
proc main() {
    var timer : Timer;
    const pDomain1D  = {1..nX};
    const pDomain    = {0..nSteps, 1..nX};
    const interior   = pDomain.dim(2).expand(-1);
    const interior2  = pDomain1D.expand(-1);

    const dx = lenghtX / (nX-1);
    const dt = tMax / (nSteps-1);
    const r  = alpha / (dx**2);
    const r2 = 1 - 2*r;

    var temp : [pDomain] real = 0.0;
    var B, C, A, E, F, D, Y : [pDomain1D] real = 0.0;

    timer.start();

    forall i in interior do {
        temp[0,i] = sin(pi * (i-1)*dx);
    }

    B = -r;
    C = B;
    A = 1.0/dx + 2*r;

    A[1]  = 1; B[1] = 0;
    A[nX] = 1; C[nX] = 0;

    F[1] = A[1];

    for i in 2..nX do {
        E[i] = C[i] / F[i-1];
        F[i] = A[i] - E[i]*B[i-1];
    }

    for step in 1..nSteps do {
        forall i in interior {
            D[i] = temp[step-1,i] / dt;
        }

        Y[1] = D[1];
        for i in 2..nX do {
            Y[i] = D[i] - E[i]*Y[i-1];
        }

        temp[step, nX] = Y[nX]/F[nX];
        forall i in 1..nX-1 by -1 {
            temp[step, i] = (Y[i] - B[i]*Y[i+1])/F[i];
        }
    }

    var wallTime = timer.elapsed();

    writeln("Writing results to " , outputFile, " file");
    writef("Wall clock time is = %.6dr\n", wallTime);

    writeToFile(temp);
}
