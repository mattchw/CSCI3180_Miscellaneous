       IDENTIFICATION DIVISION.
       PROGRAM-ID. ASG1.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
               SELECT TEAMS ASSIGN TO 'teams.txt'
               ORGANIZATION IS LINE SEQUENTIAL.

               SELECT SUBMIT ASSIGN TO 'submission-records.txt'
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
           FILE SECTION.
           FD TEAMS.
           01 TEAMS-FILE.
              05 NAME PIC A(15).
           
           FD SUBMIT.
           01 SUBMIT-FILE.
              05 SUBMIT-NAME PIC A(15).
              05 PROB-ID PIC 9(1).
              05 OUTCOME PIC A(19).
              05 SCORE PIC 9(3).

           WORKING-STORAGE SECTION.
           01 WS-TEAMS.
              05 WS-TEAMS-NAME PIC A(15).
           01 WS-TEAMS-EOF PIC A(1) VALUE 'N'.

           01 WS-SUBMIT.
              05 WS-SUBMIT-NAME PIC A(15).
              05 WS-PROB-ID PIC 9(1).
              05 WS-OUTCOME PIC A(19).
              05 WS-SCORE PIC 9(3) VALUE 0.
           01 WS-SUBMIT-EOF PIC A(1) VALUE 'N'.
           01 WS-STATUS PIC A(2).

           01 WS-TOTALSCORE PIC 9(3) VALUE 0.
           01 WS-TIMES PIC 9(2).
           01 WS-MAXSCORE PIC 9(3) VALUE 0.
           01 WS-MINSCORE PIC 9(3) VALUE 0.
           01 WS-AVGSCORE PIC 9(3) VALUE 0.

       PROCEDURE DIVISION.

       MAIN.
           OPEN INPUT TEAMS.
           OPEN INPUT SUBMIT.
               PERFORM READING-TEAMS.
           CLOSE TEAMS.
           CLOSE SUBMIT.
       STOP RUN.

       READING-TEAMS.
           IF WS-TEAMS-EOF='N'
               READ TEAMS INTO WS-TEAMS
                   AT END MOVE 'Y' TO WS-TEAMS-EOF
                   NOT AT END 
                       IF WS-TEAMS-NAME EQUAL WS-SUBMIT-NAME
                           MOVE 1 TO WS-TIMES
                           PERFORM COMPUTING
                       END-IF
      *                DISPLAY "NAME FROM TEAMS.TXT: " WS-TEAMS
                       PERFORM READING-SUBMIT
               END-READ
               GO TO READING-TEAMS
           END-IF.

       READING-SUBMIT.
           IF WS-SUBMIT-EOF='N'
               READ SUBMIT INTO WS-SUBMIT
                   AT END MOVE 'Y' TO WS-SUBMIT-EOF
                   NOT AT END 
                       DISPLAY WS-SUBMIT
                       PERFORM COMPARE-TWO-NAMES
               END-READ
               GO TO READING-SUBMIT
           END-IF.

       COMPARE-TWO-NAMES.
           IF WS-TEAMS-NAME EQUAL WS-SUBMIT-NAME
               DISPLAY "---SAME---"
               MOVE 1 TO WS-TIMES
               PERFORM COMPUTING
           END-IF.
           IF WS-TEAMS-NAME NOT EQUAL WS-SUBMIT-NAME
               DISPLAY "---NOT SAME---"
               PERFORM READING-TEAMS
           END-IF.

       COMPUTING.
           DISPLAY WS-TEAMS-NAME "---REFER TO---" WS-SUBMIT-NAME.
           DISPLAY "ID: " WS-PROB-ID " SCORE: " WS-SCORE.
           DISPLAY "CALCULATING...........".
      *    COMPUTE WS-AVGSCORE = WS-AVGSCORE * WS-TIMES.
      *    COMPUTE WS-TOTALSCORE = WS-TOTALSCORE + WS-SCORE.
           MULTIPLY 1 BY WS-SCORE GIVING WS-TOTALSCORE.
           DISPLAY "SCORE IS: " WS-TOTALSCORE.




