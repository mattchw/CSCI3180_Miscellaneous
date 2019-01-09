      PROGRAM HELLO_WORLD
      IMPLICIT NONE
c
      INTEGER STAT
      STAT=1
      CHARACTER TEXT*20
c
 10   FORMAT ('The text is: ',/,A)

      CALL GETARG(1,TEXT)
      WRITE (*,10) TEXT

      OPEN(1,FILE=TEXT)
      IF (STAT>=0) THEN
      	READ (1,*,IOSTAT=STAT) TEXT
      	WRITE (*,10) TEXT
      	
      END IF
C     READ (1,*) TEXT
C     WRITE (*,10) TEXT
C     READ (1,*) TEXT
      CLOSE(1)

C     WRITE (*,10) TEXT

      STOP
      END
