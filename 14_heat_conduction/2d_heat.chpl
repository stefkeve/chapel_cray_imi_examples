/**
* @file 2d_heat.chpl
*
* @desription 2D heat conduction.
*
* @usage chpl -o 2d_heat 2d_heat.chpl --fast
*        ./2d_heat <<arguments>>
*/

config var ncellsX = 10,
           ncellsY = 10,
           nsteps  = 20,
           leftX   = 0,
           rightX  = 10,
           downY   = 0,
           upY     = 10,
           ao      = 1.0,
           coeff   = .375,
           sigma   = 3.0;

/*
* main procedure
*/
proc main() {
    var timer : Timer;
    const pDomain  = {1..ncellsX, 1..ncellsY};
    const interior = pDomain.expand(-1);
    const dx       = (rightX - leftX) / (ncellsX - 1);
    const dy       = (upY - downY) / (ncellsY - 1);

    var temp, tempNew : [pDomain] real = 0.0;

    timer.start();
    
    forall (i,j) in pDomain do {
        var x = leftX + (i-1)*dx;
        var y = downY + (j-1)*dy;
        temp[i,j] = ao*exp(-x*x/(2.0*sigma*sigma)) + ao*exp(-y*y/(2.0*sigma*sigma));
    }

    for step in [1..nsteps] do {
        forall (i,j) in interior do {
            tempNew(i,j) = temp[i,j] + coeff*(temp[i-1, j] - 2.0*temp[i,j] + temp[i+1,j]) +
                           coeff*(temp[i, j-1] - 2.0*temp[i,j] + temp[i,j+1]);
        }

        temp[interior] = tempNew[interior];
    }

    var wallTime = timer.elapsed();

    writeln("Temps ", temp);
    writef("Wall clock time is = %.6dr\n", wallTime);
}
