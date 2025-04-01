       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAYROLL-SIM.
       AUTHOR. PAYROLL-OFFICE.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT EMPLOYEE-FILE ASSIGN TO "data/EMP.DAT"
               ORGANIZATION IS SEQUENTIAL.
           SELECT REPORT-FILE ASSIGN TO "data/PAYROLL.RPT"
               ORGANIZATION IS SEQUENTIAL.
           
       DATA DIVISION.
       FILE SECTION.
       FD  EMPLOYEE-FILE.
       01  EMPLOYEE-RECORD.
           05 EMP-ID           PIC X(5).
           05 EMP-NAME         PIC X(20).
           05 EMP-HOURS-X      PIC X(6).
           05 EMP-RATE-X       PIC X(6).
       
       FD  REPORT-FILE.
       01  REPORT-LINE         PIC X(132).
       WORKING-STORAGE SECTION.
       01  WS-EOF              PIC X VALUE 'N'.
       01  WS-GROSS-PAY        PIC 9(5)V99.
       01 WS-EMP-HOURS-N       PIC 9(3)V99.
       01 WS-EMP-RATE-N       PIC 9(3)V99.
       01  WS-REPORT-HEADER.
           05 FILLER           PIC X(40) VALUE SPACES.
           05 FILLER           PIC X(20) VALUE 'PAYROLL SIMULATOR'.
           05 FILLER           PIC X(72) VALUE SPACES.
       01 WS-REPORT-TITLE.
           05 FILLER           PIC X(14) VALUE SPACES.
           05 FILLER           PIC X(5) VALUE 'ID'.
           05 FILLER           PIC X(5) VALUE SPACES.
           05 FILLER           PIC X(20) VALUE 'EMPLOYEE NAME'.
           05 FILLER           PIC X(5) VALUE SPACES.
           05 FILLER           PIC X(10) VALUE 'HOURS'.
           05 FILLER           PIC X(5) VALUE SPACES.
           05 FILLER           PIC X(10) VALUE 'RATE'.
           05 FILLER           PIC X(5) VALUE SPACES. 
           05 FILLER           PIC X(12) VALUE 'GROSS PAY'.
           05 FILLER           PIC X(41) VALUE SPACES.
       01  WS-REPORT-DETAIL.
           05 FILLER           PIC X(10) VALUE SPACES.
           05 WS-EMP-ID        PIC X(5).
           05 FILLER           PIC X(3) VALUE SPACES.
           05 WS-EMP-NAME      PIC X(20).
           05 FILLER           PIC X(5) VALUE SPACES.
           05 WS-EMP-HOURS     PIC ZZ9.99B.
           05 FILLER           PIC X(4) VALUE SPACES.
           05 WS-EMP-RATE      PIC ZZ9.99B.
           05 FILLER           PIC X(4) VALUE SPACES.
           05 WS-GROSS-DISPLAY PIC $ZZZ,ZZ9.99.
           05 FILLER           PIC X(41) VALUE SPACES.
       
       PROCEDURE DIVISION.
       0000-MAIN-LOGIC.
           PERFORM 1000-INITIALIZE
           PERFORM 2000-PROCESS UNTIL WS-EOF = 'Y'
           PERFORM 3000-TERMINATE
           STOP RUN.
       
       1000-INITIALIZE.
           OPEN INPUT EMPLOYEE-FILE
           OPEN OUTPUT REPORT-FILE
           WRITE REPORT-LINE FROM WS-REPORT-HEADER
           WRITE REPORT-LINE FROM SPACES AFTER 2
           WRITE REPORT-LINE FROM WS-REPORT-TITLE
           WRITE REPORT-LINE FROM SPACES AFTER 1
           READ EMPLOYEE-FILE
               AT END MOVE 'Y' TO WS-EOF
           END-READ.
       
       2000-PROCESS.
           MOVE FUNCTION NUMVAL(EMP-HOURS-X) TO WS-EMP-HOURS-N
           MOVE FUNCTION NUMVAL(EMP-RATE-X) TO WS-EMP-RATE-N
           COMPUTE WS-GROSS-PAY = WS-EMP-HOURS-N * WS-EMP-RATE-N
           MOVE EMP-ID TO WS-EMP-ID
           MOVE EMP-NAME TO WS-EMP-NAME
           MOVE WS-EMP-HOURS-N TO WS-EMP-HOURS
           MOVE WS-EMP-RATE-N TO WS-EMP-RATE
           MOVE WS-GROSS-PAY TO WS-GROSS-DISPLAY
           WRITE REPORT-LINE FROM WS-REPORT-DETAIL
           READ EMPLOYEE-FILE
               AT END MOVE 'Y' TO WS-EOF
           END-READ.

       3000-TERMINATE.
           CLOSE EMPLOYEE-FILE
           CLOSE REPORT-FILE.
