/**
* @file 1d_heat_ftcs.chpl
*
* @desription 1D heat conduction. Forward Time, Centered Space
*
* @usage chpl -o 1d_heat_ftcs 1d_heat_ftcs.chpl --fast
*        ./1d_heat_ftcs <<arguments>>
*
* @arguments --nX
*            --nSteps
*            --lenghtX
*            --alpha
*            --tMax
*            --outputFile
*/

use Math;

config const nX         = 20;
config const nSteps     = 10;
config const lenghtX    = 1.0;
config const alpha      = 0.1;
config const tMax       = 0.5;
config const outputFile = "1d_heat_temps_ftcs.csv";

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

/**
* main procedure
*/
proc main() {
    const pDomain  = {0..nSteps, 1..nX};
    const interior = pDomain.dim(2).expand(-1);
    const dx = lenghtX / (nX-1);
    const dt = tMax / (nSteps-1);
    const r  = alpha * dt/(dx**2);
    const r2 = 1 - 2*r;

    var temp, tempNew : [pDomain] real = 0.0;

    forall i in interior do {
        temp[0,i] = sin(pi * (i-1)*dx);
    }

    for step in 1..nSteps do {
        forall i in interior do {
            temp(step, i) = r*temp(step-1, i-1) - r2*temp(step-1, i) + r*temp(step-1, i+1);
        }
    }

    writeln("Writing results to " , outputFile, " file");
    writeToFile(temp);
}
