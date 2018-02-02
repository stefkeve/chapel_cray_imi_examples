/*var r : [1..4] real = [0.25, 0.25, 0.25, 0.25];

var rr = + scan r;
var rra = rr - 0.25;


writeln(rra);
writeln(rr);

record A {
	var test1;
	var test2 = 10;
}

record B : A {
}

proc create(tip) : B {
	return new B(test1 = "1");
}


var a : A = nil;



a = new B(test1 = "1");
writeln(a);
*/



/*use Random;

var rs = new RandomStream(eltType = uint, parSafe = false);


writeln(rs.getNext(1,100));
writeln(rs.getNext(1,100));
writeln(rs.getNext(1,100));
writeln(rs.getNext(1,100));
writeln(rs.getNext(1,100));
writeln(rs.getNext(1,100));
writeln(rs.getNext(1,100));
*/




/*var listaind : domain(1);
var lista : [listaind] int;


lista.push_back(1);
lista.push_back(2);
lista.push_back(331);
lista.push_back(331);
lista.push_back(1121);


writeln(lista);*/



var listadom = {1..0};
var listadomsparse : sparse subdomain(listadom);
var lista : [listadom] int;
var listaR : [{1..0}] int;

lista.push_back(1);
lista.push_back(2);
lista.push_back(331);
lista.push_back(331);
lista.push_back(1121);

var i = 1;

while(i <= lista.numElements) {
	if(lista[i] == 2 || lista[i] == 331) {
		writeln("num of elem: " , lista.numElements);
		lista.remove(i);
		writeln("after num of elem: " , lista.numElements);
		i -= 1;
	} //else {
		
	//}
	
	i += 1;
}

writeln(lista);

//var dix = listadomsparse.dsiLast();

//writeln(dix);

//riteln(listaTmp.domain);


