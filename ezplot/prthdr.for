C*******************************************************************************CC       Copyright (C) 1993, California Institute of Technology.  U.S.C       Government Sponsorhip under NASA Contract NAS7-918 isC       acknowledged.CC*******************************************************************************C$ Procedure                        PRTHDRC      SUBROUTINE PRTHDR ( UNIT , WIDTH , PNAME )CC$ LogCC  27-Oct-1988 - Eric Cannell     - creationC  25-JAN-1990 - Eric Cannell     - added UNIT, WIDTH and variable PNAME lengthCC$ PurposeCC  PRTHDR prints a header to the specified FORTRAN unit which includes the C  string PNAME and a run time stamp.CC$ Input_ArgumentsCC  Name    Type   Dim          Units   DescriptionC  -----------------------------------------------------------------------------C  UNIT       I     1              -   FORTRAN unit number of output fileC  WIDTH      I     1     in columns   columnal width of header. WIDTH mustC                                      in range of MINWID..MAXWID.C  PNAME  C*(*)     1              -   header label, usually program name orC                                      some other significant label. Length ofC                                      PNAME without trailing blanks must be C                                      in range of 1..WIDTH-8.CC$ RestrictionsCC  1] WIDTH must be in the range MINWID..MAXWID.CC  2] PNAME must have a length in the range of 1..WIDTH-8.CC$ Library_LinksCC  NAVSYS     - navigation system libraryCC$ FilesCC  ? - UNIT   - output unit numberCC$ ParametersC      INTEGER              MINWID      PARAMETER          ( MINWID =  46 )      INTEGER              MAXWID      PARAMETER          ( MAXWID = 132 )CC$ Declarations_of_Input_and_Output_ArgumentsC      INTEGER              UNIT                                              INTEGER              WIDTH      CHARACTER*(*)        PNAMECC$ Declarations_of_Local_VariablesC      INTEGER              I      CHARACTER*132        L1      CHARACTER*132        L2      INTEGER              L2ALEN      CHARACTER*132        L3      CHARACTER*132        L4      CHARACTER*132        L5      INTEGER              PNLEN      CHARACTER*20         RUNTIM      INTEGER              WP4DIFCC$ MethodC-&C1    Check that WIDTH is in the range of MINWID..MAXWID.      IF ( WIDTH .LT. MINWID .OR. MAXWID .LT. WIDTH ) THEN         WRITE(UNIT,301) WIDTH , MINWID , MAXWID301      FORMAT(//,1X,'PRTHDR: WIDTH(',I,') is not in ',I3,'..',I3,'.')         RETURN      END IFC1    Determine length of PNAME without trailing blanks.      PNLEN = 0      DO 101 I = LEN( PNAME ) , 1 , -1         IF ( PNAME(I:I) .NE. ' ' ) THEN            PNLEN = I            GOTO 901         END IF                                          101   CONTINUE901   CONTINUEC1    Check that length of PNAME is in the range of 1..WIDTH-8.      IF ( PNLEN .LT. 1 .OR. (WIDTH-8) .LT. PNLEN ) THEN         WRITE(UNIT,302) PNLEN , WIDTH302      FORMAT(//,1X,     &   'PRTHDR: Length of PNAME(',I,') is not in 1..',I,'.')         RETURN      END IF                                       C1    Print the first line.            DO 102 I = 1 , 12         L1(11*(I-1)+1:11*I) = '***********'102   CONTINUE      WRITE(UNIT,303) L1(1:WIDTH)303   FORMAT(1X,A)C1    Print the second line.      WP4DIF = WIDTH - PNLEN - 4      L2ALEN = WP4DIF / 2      DO 103 I = 1 , L2ALEN         L2(I:I) = '*'103   CONTINUE      L2(L2ALEN+1:L2ALEN+PNLEN+4+1) = '  ' // PNAME(1:PNLEN) // '  '            DO 104 I = L2ALEN+PNLEN+4+2 , WIDTH         L2(I:I) = '*'104   CONTINUE      WRITE(UNIT,304) L2(1:WIDTH)304   FORMAT(1X,A)C1    Print the third line.      CALL GETTIM( RUNTIM )      L3(1:24) = '**     Date: ' // RUNTIM(1:11)      L3(WIDTH-20:WIDTH) = 'Time: ' // RUNTIM(13:20) // '     **'      DO 105 I = 25 , WIDTH - 21         L3(I:I) = ' '105   CONTINUE      WRITE(UNIT,305) L3(1:WIDTH)305   FORMAT(1X,A)C1    Print the fourth line.      L4(      1:    2) = '**'      L4(WIDTH-1:WIDTH) = '**'      DO 106 I = 3 , WIDTH - 2         L4(I:I) = '-'106   CONTINUE      WRITE(UNIT,306) L4(1:WIDTH)306   FORMAT(1X,A)C1    Print the fifth and last line.       L5(      1:    2) = '**'      L5(WIDTH-1:WIDTH) = '**'      DO 107 I = 3 , WIDTH - 2         L5(I:I) = ' '107   CONTINUE      WRITE(UNIT,307) L5(1:WIDTH)307   FORMAT(1X,A)      RETURN      END