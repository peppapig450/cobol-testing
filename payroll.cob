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
           05 EMP-HOURS        PIC 9(3)V99.
           05 EMP-RATE         PIC 9(3)V99.
       
       FD  REPORT-FILE.
       01  REPORT-LINE         PIC X(80).
       WORKING-STORAGE SECTION.
       01  WS-EOF              PIC X VALUE 'N'.
       01  WS-GROSS-PAY        PIC 9(5)V99.
       01  WS-REPORT-HEADER.
           05 FILLER           PIC X(20) VALUE 'PAYROLL SIMULATOR'.
           05 FILLER           PIC X(60) VALUE SPACES.
       01  WS-REPORT-DETAIL.
           05 FILLER           PIC X(5) VALUE 'ID: '.
           05 WS-EMP-ID        PIC X(5).
           05 FILLER           PIC X(5) VALUE 'NAME: '.
           05 WS-EMP-NAME      PIC X(20).
           05 FILLER           PIC X(5) VALUE 'GROSS: '.
           05 WS-GROSS-DISPLAY PIC $Z,ZZ9.99.
           05 FILLER           PIC X(35) VALUE SPACES.
       
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
           READ EMPLOYEE-FILE
               AT END MOVE 'Y' TO WS-EOF
           END-READ.
       
       2000-PROCESS.
           COMPUTE WS-GROSS-PAY = EMP-HOURS * EMP-RATE
           MOVE EMP-ID TO WS-EMP-ID
           MOVE EMP-NAME TO WS-EMP-NAME
           MOVE WS-GROSS-PAY TO WS-GROSS-DISPLAY
           WRITE REPORT-LINE FROM WS-REPORT-DETAIL
           READ EMPLOYEE-FILE
               AT END MOVE 'Y' TO WS-EOF
           END-READ.
       3000-TERMINATE.
           CLOSE EMPLOYEE-FILE
           CLOSE REPORT-FILE.
