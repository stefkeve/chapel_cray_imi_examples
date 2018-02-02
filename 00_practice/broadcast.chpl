config const n = 4;

var aarray : [{1..n}] int;
//var release$ : single bool;

sync {
    begin {
         for i in 1..n {
            aarray(i) = 22;
        }
    }
}

begin {
    var sum = + reduce aarray;
    writeln("Sum is = ", sum);
}

/*coforall t in 1..n {
	if(t == 2) {
         for i in 1..n {
            aarray(i) = 22;
        }
        release$ = true;
	} else {
		release$;

		if(t == 1) {
			var sum = + reduce aarray;
			writeln("Sum is = ", sum);
		}
	}
}*/





