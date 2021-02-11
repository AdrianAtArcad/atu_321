000100161209     h nomain
000200161209
000300161209     FPARAMETER if   e           k disk    usropn
000400161209
000500161209      /copy qprotosrc,PARAMETER
000600161209
000700161209     d chainPARAMETER  pr
000800161209     D P_PACODE                      10A    value
000900161209     D P_PASUBCODE                   10A    value
001000161209
001100161209     D K_PACODE        S                   LIKE(PACODE)
001200161209     D K_PASUBCODE     S                   LIKE(PASUBCODE)
001300161209
001400161209     C     kf            klist
001500161209     C                   KFLD                    K_PACODE
001600161209     C                   KFLD                    K_PASUBCODE
001700161209
001800161209      *=============================================
001900161209     PGetPARM1         B                     export
002000161209     DGetPARM1         PI            10A
002100161209     D P_PACODE                      10A    value
002200161209     D P_PASUBCODE                   10A    value
002300161209      /free
002400161209         chainPARAMETER(P_PACODE
002500161209               :P_PASUBCODE);
002600161209
002700161209         return PARM1;
002800161209      /end-free
002900161209     pGetPARM1         e
003000161209      *=============================================
003100161209     PGetPARM2         B                     export
003200161209     DGetPARM2         PI           100A
003300161209     D P_PACODE                      10A    value
003400161209     D P_PASUBCODE                   10A    value
003500161209      /free
003600161209         chainPARAMETER(P_PACODE
003700161209               :P_PASUBCODE);
003800161209
003900161209         return PARM2;
004000161209      /end-free
004100161209     pGetPARM2         e
004200161209      *=============================================
004300161209     PGetPARM3         B                     export
004400161209     DGetPARM3         PI             2A
004500161209     D P_PACODE                      10A    value
004600161209     D P_PASUBCODE                   10A    value
004700161209      /free
004800161209         chainPARAMETER(P_PACODE
004900161209               :P_PASUBCODE);
005000161209
005100161209         return PARM3;
005200161209      /end-free
005300161209     pGetPARM3         e
005400161209      *=============================================
005500161209     PGetPARM4         B                     export
005600161209     DGetPARM4         PI             1P 0
005700161209     D P_PACODE                      10A    value
005800161209     D P_PASUBCODE                   10A    value
005900161209      /free
006000161209         chainPARAMETER(P_PACODE
006100161209               :P_PASUBCODE);
006200161209
006300161209         return PARM4;
006400161209      /end-free
006500161209     pGetPARM4         e
006600161209      *=============================================
006700161209     PGetPARM5         B                     export
006800161209     DGetPARM5         PI             3P 0
006900161209     D P_PACODE                      10A    value
007000161209     D P_PASUBCODE                   10A    value
007100161209      /free
007200161209         chainPARAMETER(P_PACODE
007300161209               :P_PASUBCODE);
007400161209
007500161209         return PARM5;
007600161209      /end-free
007700161209     pGetPARM5         e
007800161209
007900161209     p chainPARAMETER  b
008000161209     d chainPARAMETER  pi
008100161209     D P_PACODE                      10A    value
008200161209     D P_PASUBCODE                   10A    value
008300161209      /free
008400161209        if not %open(PARAMETER);
008500161209          open PARAMETER;
008600161209        endif;
008700161209         if P_PACODE <> PACODE
008800161209           or P_PASUBCODE <> PASUBCODE;
008900161209           K_PACODE =  P_PACODE;
009000161209           K_PASUBCODE =  P_PASUBCODE;
009100161209           clear *all FPARAM;
009200161209           chain kf PARAMETER;
009300161209         endif;
009400161209      /end-free
009500161209     p chainPARAMETER  e
009600161209
009700161209     p closePARAMETER  b
009800161209     d closePARAMETER  pi
009900161209      /free
010000161209        if %open(PARAMETER);
010100161209          close PARAMETER;
010200161209        endif;
010300161209      /end-free
010400161209     p closePARAMETER  e
010500161209
010600161209
