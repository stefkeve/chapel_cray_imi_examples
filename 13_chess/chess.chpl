/**
* @file chess.chpl
*
* @desription This program is simulation of quasi chess using task parallelism model.
*             There are three types of chess pieces : rook, bishop and pawn.
*             Rook moves as in real chess game, bishop moves only one place
*             diagonally and pawn moves one place vertically and horizontally.
*             When two pieces are at the same field there stays stronger piece.
*             Rook is stronger than bishop, bishop is stronger than pawn and pawn
*             is stronger than rook.
*
* @usage chpl -o chess chess.chpl --fast
*        ./chess <<arguments>>
*
* @arguments --numOfTasks   - number of parallel tasks
*            --m            - table size
*            --numOfPieces  - number of chess pieces
*/

use Random;
use Math;
use Barrier;

config const numOfTasks   : int = here.maxTaskPar;
config const m            : int = 8;
config const numOfPieces  : int = 8;

var rs = new RandomStream(eltType = int, parSafe = false);
var b  = new Barrier(numOfTasks);

record Square {
    var id    : int = -1;
    var pType : int = -1;
}

record ChessPiece {
    var id  : int = -1;
    var pType : int = -1;
    var x : int;
    var y : int;
    var numOfCaptured : int = 0;
    var numOfMoves	  : int = 0;
    var m : int = 0;

    proc move() {
        select this.pType {
            when 0 do moveRook();
            when 1 do moveBishop();
            when 2 do movePawn();
        }
    };

    proc moveRook() {
        var d = rs.getNext(0, 1);

        select d {
            when 0 do this.x = rs.getNext(0, this.m - 1);
            when 1 do this.y = rs.getNext(0, this.m - 1);
        }
        this.numOfMoves += 1;
    }

    proc moveBishop() {
        var d = rs.getNext(0, 3);

        select d {
            when 0 {
                if(x > 0 && y > 0) {
                    this.x -= 1;
                    this.y -= 1;
                    this.numOfMoves += 1;
                }
            }
            when 1 {
                if(x > 0 && y < this.m-1) {
                    this.x -= 1;
                    this.y += 1;
                    this.numOfMoves += 1;
                }
            }
            when 2 {
                if(x < m-1 && y < this.m-1) {
                    this.x += 1;
                    this.y += 1;
                    this.numOfMoves += 1;
                }
            }
            when 3 {
                if(x < this.m-1 && y > 0) {
                    this.x += 1;
                    this.y -= 1;
                    this.numOfMoves += 1;
                }
            }
        }
    }

    proc movePawn() {
        var d = rs.getNext(0, 3);

        select d {
            when 0 do if(this.x > 0) {
                this.x -= 1;
                this.numOfMoves += 1;
            }
            when 1 do if(this.y < this.m-1) {
                this.y += 1;
                this.numOfMoves += 1;
            }
            when 2 do if(this.x < this.m-1) {
                this.x += 1;
                this.numOfMoves += 1;
            }
            when 3 do if(this.y > 0) {
                this.y -= 1;
                this.numOfMoves += 1;
            }
        }
    }

    proc checkWin(pieceType : int) : bool {
        select pieceType {
            when 0 {
                select this.pType {
                    when 0 do return false;
                    when 1 do return false;
                    when 2 do return true;
                }
            }
            when 1 {
                select this.pType {
                    when 2 do return false;
                    when 1 do return false;
                    when 0 do return true;
                }
            }
            when 2 {
                select this.pType {
                    when 0 do return false;
                    when 2 do return false;
                    when 1 do return true;
                }
            }
        }

        return false;
    }
}

proc main() {
    var numOfPiecesPerTask   : [{0..numOfTasks-1}] int = numOfPieces;
    var exchangePiecesBuffer : [{1..0}] ChessPiece;

    coforall taskid in 0..numOfTasks-1 do {
        var mm = m;
        var nn = m / numOfTasks;
        var x : int;
        var y : int;
        var pType : int;
        var id  : int;

        var squareDomain = {0..mm-1, 0..nn-1};
        var squares : [squareDomain] Square;
        var pieceDomain = {1..0};
        var piecesLocal : [pieceDomain] ChessPiece;

        var totalPiecesLocal = + reduce numOfPiecesPerTask;
        var pidx = 1;

        // initalisation, creating pieces and putting them on the table
        for i in 1..numOfPieces {
            do {
                x = rs.getNext(0, mm-1);
                y = rs.getNext(0, nn-1);
            } while(squares[x,y].id != -1);

            pType = rs.getNext(0, 2);
            id    = taskid * numOfPieces + i;

            squares[x,y].id    = id;
            squares[x,y].pType = pType;

            piecesLocal.push_back(new ChessPiece(id = id , x = x, y = taskid*nn+y, m = m, pType = pType));
        }

        // Init barrier. Sync all tasks here, waiting for initialastion
        b.barrier();

        while(totalPiecesLocal > 1) {
            pidx = 1;
            while(pidx <= piecesLocal.numElements) {
                squares[piecesLocal[pidx].x, piecesLocal[pidx].y % nn].id = -1;

                piecesLocal[pidx].move();

                if(piecesLocal[pidx].y < taskid*nn || piecesLocal[pidx].y >= (taskid+1)*nn) {
                    exchangePiecesBuffer.push_back(piecesLocal[pidx]);
                    piecesLocal.remove(pidx);
                    pidx -= 1;
                }
                pidx += 1;
            }

            // wait for all tasks, exchange figure barrier.
            b.barrier();

            // get task's piece
            for piece in exchangePiecesBuffer {
                if(piece.y >= taskid * nn && piece.y < (taskid+1)*nn) {
                    piecesLocal.push_back(piece);
                }
            }

            pidx = 1;
            while(pidx <= piecesLocal.numElements) {
                var xx = piecesLocal[pidx].x;
                var yy = piecesLocal[pidx].y % nn;

                if(squares[xx,yy].id == -1) {
                    squares[xx,yy].id    = piecesLocal[pidx].id;
                    squares[xx,yy].pType = piecesLocal[pidx].pType;
                } else {
                    if(piecesLocal[pidx].checkWin(squares[xx,yy].pType)) {
                        squares[xx,yy].id    = piecesLocal[pidx].id;
                        squares[xx,yy].pType = piecesLocal[pidx].pType;
                        piecesLocal[pidx].numOfCaptured += 1;

                        for pidx2 in piecesLocal.domain {
                            if(piecesLocal[pidx2].id == squares[xx,yy].id) {
                                piecesLocal.remove(pidx2);
                                pidx -= 1;
                                break;
                            }
                        }
                    } else {
                        // update numOfCaptured
                        for pidx2 in piecesLocal.domain {
                            if(piecesLocal[pidx2].id == squares[xx,yy].id) {
                                piecesLocal[pidx2].numOfCaptured += 1;
                                break;
                            }
                        }
                        piecesLocal.remove(pidx);
                        pidx -= 1;
                    }
                }
                pidx += 1;

            }

            numOfPiecesPerTask[taskid] = piecesLocal.numElements;

            // iteration barrier. Wait for all tasks to get here
            b.barrier();

            totalPiecesLocal = + reduce numOfPiecesPerTask;
            // only first task clears global exchange buffer
            if(taskid == 0) then exchangePiecesBuffer.clear();

            // wait for first task to finish
            b.barrier();
        }

        writeln("I'm task ", taskid, " and I have ", numOfPiecesPerTask[taskid], " chess pieces");

        if(numOfPiecesPerTask[taskid] > 0) {
            select piecesLocal[1].pType {
                when 0 do writeln("I'm task ", taskid,". Winner is rook! I captured ", piecesLocal[1].numOfCaptured, " pieces!");
                when 1 do writeln("I'm task ", taskid,". Winner is bishop! I captured ", piecesLocal[1].numOfCaptured, " pieces!");
                when 2 do writeln("I'm task ", taskid,". Winner is pawn!  I captured ", piecesLocal[1].numOfCaptured, " pieces!");
            }
        }
    }
    //delete rs;
}
