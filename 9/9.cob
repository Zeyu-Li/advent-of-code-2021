       >>SOURCE FORMAT FREE
*> To run do `cobc -x 9.cob && ./9`
IDENTIFICATION DIVISION.
program-id. main8.
author. Andrew.
date-written. Dec 9, 2021.

ENVIRONMENT DIVISION.
input-output section.
file-control. 
       select FP assign to "9.dat"
           organization is line sequential 
           access is sequential.

DATA DIVISION.
FILE SECTION.
FD FP.
01 dataLayout.
       02  currLine       PIC X(100).

WORKING-STORAGE SECTION.
01 State.
       02 WS-A occurs 102 times INDEXED BY J.
           03 WS-B PIC X(11) value 10 OCCURS 102 TIMES INDEXED BY I.

01 MaxBoarder PIC 99 value 10.
01 lineCounter PIC 999 value 0.
01 charCounter PIC 999 value 0.
01 fakeCounter1 PIC 999 value 0.
01 fakeCounter2 PIC 999 value 0.
01 fakeCounter3 PIC 999 value 0.
01 fakeCounter4 PIC 999 value 0.
01 temp PIC 99 value 0.
01 temp1 PIC 99 value 0.
01 temp2 PIC 99 value 0.
01 temp3 PIC 99 value 0.
01 temp4 PIC 99 value 0.
01 Total PIC 99999999 value 0.
01 END-OF-FILE PIC Z(1).

PROCEDURE DIVISION.
*> open file and read
OPEN INPUT FP
READ FP
       AT END MOVE 1 TO END-OF-FILE
END-READ

IF END-OF-FILE = 1
       CLOSE FP
END-IF

MOVE 0 TO END-OF-FILE.

*> debug
*> DISPLAY State.
*> for line in file
MOVE 2 to lineCounter
PERFORM UNTIL END-OF-FILE = 1
       SET charCounter to 2
       PERFORM UNTIL charCounter = 102
           COMPUTE fakeCounter1 = charCounter - 1
           *> display currLine(fakeCounter1:1) with no advancing
           *> SET WS-B(lineCounter, charCounter) to 1
           MOVE currLine(fakeCounter1:1) to WS-B(lineCounter, charCounter)
           MOVE WS-B(lineCounter, charCounter) to temp
           MOVE temp to WS-B(lineCounter, charCounter)
           COMPUTE charCounter = charCounter + 1
       END-PERFORM

       COMPUTE lineCounter = lineCounter + 1
       READ FP
           AT END MOVE 1 TO END-OF-FILE
       END-READ
END-PERFORM
*> DISPLAY State.

*> calculate

MOVE 2 to lineCounter
PERFORM UNTIL lineCounter = 102
       SET charCounter to 2
       PERFORM UNTIL charCounter = 102
           COMPUTE fakeCounter1 = charCounter - 1
           COMPUTE fakeCounter2 = lineCounter - 1
           COMPUTE fakeCounter3 = charCounter + 1
           COMPUTE fakeCounter4 = lineCounter + 1
           IF WS-B(lineCounter, fakeCounter1) > WS-B(lineCounter, charCounter) and 
           WS-B(lineCounter, fakeCounter3) > WS-B(lineCounter, charCounter) and 
           WS-B(fakeCounter2, charCounter) > WS-B(lineCounter, charCounter) and 
           WS-B(fakeCounter4, charCounter) > WS-B(lineCounter, charCounter) THEN
               MOVE WS-B(lineCounter, charCounter) to temp
               *> display temp space with no advancing
               COMPUTE Total = Total + temp + 1
           END-IF
           COMPUTE charCounter = charCounter + 1
       END-PERFORM
       *> display ""
       *> display "-----"

       COMPUTE lineCounter = lineCounter + 1
END-PERFORM

DISPLAY "Count:" SPACE Total

STOP RUN.
