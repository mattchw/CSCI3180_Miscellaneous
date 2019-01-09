       IDENTIFICATION DIVISION.
       PROGRAM-ID. ASG1.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION.
               FILE-CONTROL.
               SELECT TEAMS ASSIGN TO 'teams.txt'
               ORGANIZATION IS LINE SEQUENTIAL.

               SELECT SUBMIT ASSIGN TO 'submission-records.txt'
               ORGANIZATION IS LINE SEQUENTIAL.
      
               SELECT OUTPUT-REPORT ASSIGN TO 'reportcob.txt'
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
           FD OUTPUT-REPORT.
           01 OUTPUT-HEADER.
              05 OUTPUT-LINE PIC A(104).
           01 OUTPUT-NEWLINE PIC A.
              
           01 OUTPUT-DATA.
              05 OUTPUT-NAME PIC A(15).
              05 OUTPUT-PROB-1 PIC A(3).
              05 OUTPUT-SCORE-1 PIC ZZ9.
              05 FILL PIC A.
              05 OUTPUT-PROB-2 PIC A(3).
              05 OUTPUT-SCORE-2 PIC ZZ9.
              05 FILL PIC A.
              05 OUTPUT-PROB-3 PIC A(3).
              05 OUTPUT-SCORE-3 PIC ZZ9.
              05 FILL PIC A.
              05 OUTPUT-PROB-4 PIC A(3).
              05 OUTPUT-SCORE-4 PIC ZZ9.
              05 FILL PIC A.
              05 OUTPUT-PROB-5 PIC A(3).
              05 OUTPUT-SCORE-5 PIC ZZ9.
              05 FILL PIC A.
              05 OUTPUT-PROB-6 PIC A(3).
              05 OUTPUT-SCORE-6 PIC ZZ9.
              05 FILL PIC A.
              05 OUTPUT-PROB-7 PIC A(3).
              05 OUTPUT-SCORE-7 PIC ZZ9.
              05 FILL PIC A.
              05 OUTPUT-PROB-8 PIC A(3).
              05 OUTPUT-SCORE-8 PIC ZZ9.
              05 FILL PIC A.
              05 OUTPUT-PROB-9 PIC A(3).
              05 OUTPUT-SCORE-9 PIC ZZ9.
              05 FILL PIC A. 
              05 OUTPUT-PROB-10 PIC A(3).
              05 OUTPUT-SCORE-10 PIC ZZ9.
              05 FILL PIC A.
              05 OUTPUT-TOTAL PIC A(2).
              05 OUTPUT-TOTALSCORE PIC ZZZ9. 

           WORKING-STORAGE SECTION.
           01 HEADER-ONE.
              05 HEADER-TEXT PIC X(50) VALUE "2018 CUHK CSE Programming 
      -"Contest".
              05 FILL PIC X(50) VALUE SPACES.
      *       05 END-ONE PIC X(4) VALUE "\r\n".
           01 HEADER-TWO.
              05 HEADER-TEXT PIC X(50) VALUE "Team Score Report".
              05 FILL PIC X(50) VALUE SPACES.
      *       05 END-TWO PIC X(4) VALUE "\r\n".
           01 TEAM.
              05 TEAM-NAME PIC A(15).
              05 PROB-1 PIC A(3) VALUE "(0)".
              05 SCORE-1 PIC ZZ9 VALUE ZEROS.
              05 FILL PIC A VALUE SPACES.
              05 PROB-2 PIC A(3) VALUE "(1)".
              05 SCORE-2 PIC ZZ9 VALUE ZEROS.
              05 FILL PIC A VALUE SPACES.
              05 PROB-3 PIC A(3) VALUE "(2)".
              05 SCORE-3 PIC ZZ9 VALUE ZEROS.
              05 FILL PIC A VALUE SPACES.
              05 PROB-4 PIC A(3) VALUE "(3)".
              05 SCORE-4 PIC ZZ9 VALUE ZEROS.
              05 FILL PIC A VALUE SPACES.
              05 PROB-5 PIC A(3) VALUE "(4)".
              05 SCORE-5 PIC ZZ9 VALUE ZEROS.
              05 FILL PIC A VALUE SPACES.
              05 PROB-6 PIC A(3) VALUE "(5)".
              05 SCORE-6 PIC ZZ9 VALUE ZEROS.
              05 FILL PIC A VALUE SPACES.
              05 PROB-7 PIC A(3) VALUE "(6)".
              05 SCORE-7 PIC ZZ9 VALUE ZEROS.
              05 FILL PIC A VALUE SPACES.
              05 PROB-8 PIC A(3) VALUE "(7)".
              05 SCORE-8 PIC ZZ9 VALUE ZEROS.
              05 FILL PIC A VALUE SPACES.
              05 PROB-9 PIC A(3) VALUE "(8)".
              05 SCORE-9 PIC ZZ9 VALUE ZEROS.
              05 FILL PIC A VALUE SPACES.
              05 PROB-10 PIC A(3) VALUE "(9)".
              05 SCORE-10 PIC ZZ9 VALUE ZEROS.
              05 FILL PIC A VALUE SPACES.
              05 TOTAL PIC A(2) VALUE "T:".
              05 TOTALSCORE PIC ZZZ9 VALUE ZEROS.
           
           01 BLANK-LINE PIC A VALUE SPACES.

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

           01 WS-LAST-PROB-ID PIC 9(2) VALUE 99.

           01 WS-FINALSCORE PIC 999V99999 VALUE ZERO.
           01 WS-TOTALSCORE PIC 9999 VALUE ZERO.
           01 WS-TIMES PIC 9(2).
           01 WS-MAXSCORE PIC 9(3) VALUE 0.
           01 WS-MINSCORE PIC 9(3) VALUE 0.
           01 WS-AVGSCORE PIC 9999V99999 VALUE ZERO.
           01 WS-ROBUST PIC 9(3) VALUE ZERO.
           01 WS-DECAY PIC 9V9999999999 VALUE ZERO.

           01 WS-OUTPUT-TABLE.
              05 WS-OUTPUT PIC 9(3) OCCURS 10 TIMES.
           01 WS-OUTPUT-INDEX PIC 99 VALUE ZERO.
           01 WS-CHECK PIC 9(3) VALUE ZERO.
           01 WS-CHECK-TWO PIC 9(3) VALUE ZERO.

       PROCEDURE DIVISION.

       MAIN.
           OPEN INPUT TEAMS.
           OPEN INPUT SUBMIT.
           OPEN OUTPUT OUTPUT-REPORT.
           WRITE OUTPUT-HEADER FROM HEADER-ONE.
           WRITE OUTPUT-HEADER FROM HEADER-TWO.
           WRITE OUTPUT-NEWLINE FROM BLANK-LINE.
           PERFORM READING-TEAMS.
           DISPLAY WS-OUTPUT-TABLE.
           PERFORM COMPUTE-TOTAL.
           DISPLAY "TOTAL: " WS-TOTALSCORE.
           WRITE OUTPUT-DATA FROM TEAM.
           CLOSE OUTPUT-REPORT.
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
                           PERFORM COMPARE-TWO-PROBS
                           PERFORM COMPUTING
                       END-IF
      *                DISPLAY "NAME FROM TEAMS.TXT: " WS-TEAMS
                       PERFORM READING-SUBMIT
               END-READ
               GO TO READING-TEAMS
           END-IF.
      *    IF WS-TEAMS-EOF='Y'
      *        DISPLAY WS-OUTPUT-TABLE
      *    END-IF.

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
      *        DISPLAY "---SAME---"
      *        MOVE 1 TO WS-TIMES
               PERFORM COMPARE-TWO-PROBS
               PERFORM COMPUTING
           END-IF.
           IF WS-TEAMS-NAME NOT EQUAL WS-SUBMIT-NAME
      *        DISPLAY "---NOT SAME---"
               MOVE 99 TO WS-LAST-PROB-ID
               DISPLAY WS-OUTPUT-TABLE
               PERFORM COMPUTE-TOTAL
               DISPLAY "TOTAL: " WS-TOTALSCORE
      *        DISPLAY "--END--"
               WRITE OUTPUT-DATA FROM TEAM
               MOVE 0 TO WS-TOTALSCORE
               MOVE ZEROS TO WS-OUTPUT-TABLE
               PERFORM READING-TEAMS
           END-IF.

       COMPARE-TWO-PROBS.
      *    DISPLAY "CUR: " WS-PROB-ID " VS LAST: " WS-LAST-PROB-ID.
           IF WS-PROB-ID EQUAL WS-LAST-PROB-ID
      *        DISPLAY "---SAME PROB---"
               ADD 1 TO WS-TIMES
           END-IF.
           IF WS-PROB-ID NOT EQUAL WS-LAST-PROB-ID
      *        DISPLAY "---NOT SAME PROB---"
      *        DISPLAY "LAST TOTAL SCORE: " WS-TOTALSCORE
               MOVE WS-PROB-ID TO WS-LAST-PROB-ID
      *        COMPUTE WS-TOTALSCORE=WS-TOTALSCORE+WS-FINALSCORE
               MOVE 1 TO WS-TIMES
               MOVE 0 TO WS-AVGSCORE
               MOVE 0 TO WS-MAXSCORE
               MOVE 0 TO WS-MINSCORE
           END-IF.

       MAX-MIN-SCORE.
           IF WS-TIMES EQUAL 1
               MOVE WS-SCORE TO WS-MAXSCORE
               MOVE WS-SCORE TO WS-MINSCORE
           END-IF.
           IF WS-TIMES EQUAL 2
               IF WS-SCORE > WS-MAXSCORE
                   MOVE WS-MAXSCORE TO WS-MINSCORE
                   MOVE WS-SCORE TO WS-MAXSCORE
                   
               END-IF
               IF WS-SCORE < WS-MAXSCORE
                   MOVE WS-SCORE TO WS-MINSCORE
               END-IF
           END-IF.
           IF WS-TIMES > 2
               IF WS-SCORE >= WS-MAXSCORE
      *            MOVE WS-MAXSCORE TO WS-MINSCORE
                   MOVE WS-SCORE TO WS-MAXSCORE
               END-IF
               IF WS-SCORE <=WS-MINSCORE
                   MOVE WS-SCORE TO WS-MINSCORE
               END-IF
           END-IF.
       COMPUTE-TOTAL.
           COMPUTE WS-TOTALSCORE=WS-TOTALSCORE+WS-OUTPUT(1)+
      -WS-OUTPUT(2)+WS-OUTPUT(3)+WS-OUTPUT(4)+WS-OUTPUT(5)+
      -WS-OUTPUT(6)+WS-OUTPUT(7)+WS-OUTPUT(8)+WS-OUTPUT(9)+
      -WS-OUTPUT(10).
           MOVE WS-TOTALSCORE TO TOTALSCORE.
           MOVE WS-OUTPUT(1) TO SCORE-1.
           MOVE WS-OUTPUT(2) TO SCORE-2.
           MOVE WS-OUTPUT(3) TO SCORE-3.
           MOVE WS-OUTPUT(4) TO SCORE-4.
           MOVE WS-OUTPUT(5) TO SCORE-5.
           MOVE WS-OUTPUT(6) TO SCORE-6.
           MOVE WS-OUTPUT(7) TO SCORE-7.
           MOVE WS-OUTPUT(8) TO SCORE-8.
           MOVE WS-OUTPUT(9) TO SCORE-9.
           MOVE WS-OUTPUT(10) TO SCORE-10.
           MOVE WS-TEAMS-NAME TO TEAM-NAME.

       COMPUTING.
      *    DISPLAY WS-TEAMS-NAME "---REFER TO---" WS-SUBMIT-NAME.
      *    DISPLAY "ID: " WS-PROB-ID " SCORE: " WS-SCORE.
      *    DISPLAY "LAST SCORE: " WS-LAST-PROB-ID.
      *    DISPLAY "CALCULATING...........".
           COMPUTE WS-AVGSCORE = WS-AVGSCORE * (WS-TIMES - 1).
           COMPUTE WS-AVGSCORE = (WS-AVGSCORE + WS-SCORE).
           COMPUTE WS-AVGSCORE = WS-AVGSCORE / WS-TIMES.
      *    DISPLAY WS-AVGSCORE.
      *    DISPLAY WS-TIMES.
           PERFORM MAX-MIN-SCORE.
      *    DISPLAY "MAX: " WS-MAXSCORE "--MIN: " WS-MINSCORE.
           COMPUTE WS-ROBUST = 100 - (WS-MAXSCORE - WS-MINSCORE).
           COMPUTE WS-DECAY = 1/WS-TIMES.
           DISPLAY WS-DECAY.
           IF WS-MAXSCORE <= 30
               MOVE 0 TO WS-ROBUST
           END-IF.
           IF WS-SCORE = 100
               COMPUTE WS-FINALSCORE = 0.6 * WS-SCORE +
      -0.3 * WS-AVGSCORE + 0.1 * WS-ROBUST
           END-IF.
           IF WS-SCORE < 100
           COMPUTE WS-FINALSCORE = 0.6 * WS-SCORE * WS-DECAY
           END-IF.
           COMPUTE WS-FINALSCORE = WS-FINALSCORE + 0.3 * WS-AVGSCORE.
           COMPUTE WS-FINALSCORE = WS-FINALSCORE + 0.1 * WS-ROBUST.
           COMPUTE WS-CHECK = WS-FINALSCORE + 0.0001.
           MOVE WS-FINALSCORE TO WS-CHECK-TWO.

           DISPLAY "SCORE IS: " WS-FINALSCORE.
           COMPUTE WS-OUTPUT-INDEX = WS-PROB-ID + 1.
           MOVE WS-FINALSCORE TO WS-OUTPUT(WS-OUTPUT-INDEX).

           IF WS-CHECK NOT EQUAL WS-CHECK-TWO
               MOVE WS-CHECK TO WS-OUTPUT(WS-OUTPUT-INDEX)
           END-IF.
