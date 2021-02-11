000100000000     h nomain
000200000000
000300000000     FPROVIDE1  if   e           k disk    usropn
000400000000
000500000000      /copy qprotosrc,PROVIDER
000600000000
000700000000     d chainPROVIDE1   pr
000800000000     D P_PRID                         5P 0  value
000900000000
001000000000     D K_PRID          S                   LIKE(PRID)
001100000000
001200000000     C     kf            klist
001300000000     C                   KFLD                    K_PRID
001400000000
001500000000      *=============================================
001600000000     PGetProName       B                     export
001700161027     DGetProName       PI                  like(provnm)
001800000000     D P_PRID                         5P 0  value
001900000000      /free
002000000000         chainPROVIDE1(P_PRID
002100000000               );
002200000000         return PROVNM;
002300000000      /end-free
002400000000     pGetProName       e
002500000000      *=============================================
002600000000     PGetProCONT       B                     export
002700161027     DGetProCONT       PI                  like(prcont)
002800000000     D P_PRID                         5P 0  value
002900000000      /free
003000000000         chainPROVIDE1(P_PRID
003100000000               );
003200000000         return PRCONT;
003300000000      /end-free
003400000000     pGetProCONT       e
003500000000      *=============================================
003600000000     PGetProPHONE      B                     export
003700161027     DGetProPHONE      PI                  like(prphone)
003800000000     D P_PRID                         5P 0  value
003900000000      /free
004000000000         chainPROVIDE1(P_PRID
004100000000               );
004200000000         return PRPHONE;
004300000000      /end-free
004400000000     pGetProPHONE      e
004500000000      *=============================================
004600000000     PGetProVAT        B                     export
004700161027     DGetProVAT        PI                  like(prvat)
004800000000     D P_PRID                         5P 0  value
004900000000      /free
005000000000         chainPROVIDE1(P_PRID
005100000000               );
005200000000         return PRVAT;
005300000000      /end-free
005400000000     pGetProVAT        e
005500000000      *=============================================
005600000000     PGetProMAIL       B                     export
005700161027     DGetProMAIL       PI                  like(prmail)
005800000000     D P_PRID                         5P 0  value
005900000000      /free
006000000000         chainPROVIDE1(P_PRID
006100000000               );
006200000000         return PRMAIL;
006300000000      /end-free
006400000000     pGetProMAIL       e
006500000000      *=============================================
006600000000     PGetProAdr1       B                     export
006700161027     DGetProAdr1       PI                  like(prline1)
006800000000     D P_PRID                         5P 0  value
006900000000      /free
007000000000         chainPROVIDE1(P_PRID
007100000000               );
007200000000         return PRLINE1;
007300000000      /end-free
007400000000     pGetProAdr1       e
007500000000      *=============================================
007600000000     PGetProAdr2       B                     export
007700161027     DGetProAdr2       PI                  like(prline2)
007800000000     D P_PRID                         5P 0  value
007900000000      /free
008000000000         chainPROVIDE1(P_PRID
008100000000               );
008200000000         return PRLINE2;
008300000000      /end-free
008400000000     pGetProAdr2       e
008500000000      *=============================================
008600000000     PGetProAdr3       B                     export
008700161027     DGetProAdr3       PI                  like(prline3)
008800000000     D P_PRID                         5P 0  value
008900000000      /free
009000000000         chainPROVIDE1(P_PRID
009100000000               );
009200000000         return PRLINE3;
009300000000      /end-free
009400000000     pGetProAdr3       e
009500000000      *=============================================
009600000000     PGetProZip        B                     export
009700161027     DGetProZip        PI                  like(przip)
009800000000     D P_PRID                         5P 0  value
009900000000      /free
010000000000         chainPROVIDE1(P_PRID
010100000000               );
010200000000         return PRZIP;
010300000000      /end-free
010400000000     pGetProZip        e
010500000000      *=============================================
010600000000     PGetProCity       B                     export
010700161027     DGetProCity       PI                  like(prcity)
010800000000     D P_PRID                         5P 0  value
010900000000      /free
011000000000         chainPROVIDE1(P_PRID
011100000000               );
011200000000         return PRCITY;
011300000000      /end-free
011400000000     pGetProCity       e
011500000000      *=============================================
011600000000     PGetProCountry    B                     export
011700161027     DGetProCountry    PI                  like(prcoun)
011800000000     D P_PRID                         5P 0  value
011900000000      /free
012000000000         chainPROVIDE1(P_PRID
012100000000               );
012200000000         return PRCOUN;
012300000000      /end-free
012400000000     pGetProCountry    e
012500000000      *=============================================
012600161025     P ExistProvider   B                     export
012700161025     D ExistProvider   PI              n
012800000000     D P_PRID                         5P 0  value
012900000000      /free
013000000000         chainPROVIDE1(P_PRID
013100000000               );
013200161025         return %found(provide1) and prdel <> 'X';
013300000000      /end-free
013400161025     p ExistProvider   e
013500000000
013501161025      *=============================================
013502161025     PIsProDeleted     B                     export
013503161025     DIsProDeleted     PI              n
013504161025     D P_PRID                         5P 0  value
013505161025      /free
013506161025         chainPROVIDE1(P_PRID
013507161025               );
013508161025         return PRDEL = 'X';
013509161025      /end-free
013510161025     pIsProDeleted     e
013511161025
013600000000     p chainPROVIDE1   b
013700000000     d chainPROVIDE1   pi
013800000000     D P_PRID                         5P 0  value
013900000000      /free
014000000000        if not %open(PROVIDE1);
014100000000          open PROVIDE1;
014200000000        endif;
014300000000         if P_PRID <> PRID;
014400000000           K_PRID =  P_PRID;
014500000000           clear *all FPROV;
014600000000           chain kf PROVIDE1;
014700000000         endif;
014800000000      /end-free
014900000000     p chainPROVIDE1   e
015000000000
015100000000     p closePROVIDE1   b
015200000000     d closePROVIDE1   pi
015300000000      /free
015400000000        if %open(PROVIDE1);
015500000000          close PROVIDE1;
015600000000        endif;
015700000000      /end-free
015800000000     p closePROVIDE1   e
015900000000
016000000000
