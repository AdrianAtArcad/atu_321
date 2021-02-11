000100000000     h nomain
000200000000
000300000000     FCUSTOME1  if   e           k disk    usropn
000400000000
000500000000      /copy qprotosrc,CUSTOMER
000600000000
000700000000     d chainCUSTOME1   pr
000800161025     D P_CUID                         5  0  value
000900000000
001000000000     D K_CUID          S                   LIKE(CUID)
001100000000
001200000000     C     kf            klist
001300000000     C                   KFLD                    K_CUID
001400000000
001500000000      *=============================================
001600000000     PGetCusName       B                     export
001700161027     DGetCusName       PI                   like(custnm)
001800161025     D P_CUID                         5  0  value
001900000000      /free
002000000000         chainCUSTOME1(P_CUID
002100000000               );
002200000000         return CUSTNM;
002300000000      /end-free
002400000000     pGetCusName       e
002500000000      *=============================================
002600000000     PGetCusPhone      B                     export
002700161027     DGetCusPhone      PI                   like(cuphone)
002800161025     D P_CUID                         5  0  value
002900000000      /free
003000000000         chainCUSTOME1(P_CUID
003100000000               );
003200000000         return CUPHONE;
003300000000      /end-free
003400000000     pGetCusPhone      e
003500000000      *=============================================
003600000000     PGetCusVat        B                     export
003700161027     DGetCusVat        PI                   like(cuvat)
003800161025     D P_CUID                         5  0  value
003900000000      /free
004000000000         chainCUSTOME1(P_CUID
004100000000               );
004200000000         return CUVAT;
004300000000      /end-free
004400000000     pGetCusVat        e
004500000000      *=============================================
004600000000     PGetCusMail       B                     export
004700161027     DGetCusMail       PI                   like(cumail)
004800161025     D P_CUID                         5  0  value
004900000000      /free
005000000000         chainCUSTOME1(P_CUID
005100000000               );
005200000000         return CUMAIL;
005300000000      /end-free
005400000000     pGetCusMail       e
005500000000      *=============================================
005600000000     PGetCusAdrline1   B                     export
005700161027     DGetCusAdrline1   PI                   like(culine1)
005800161025     D P_CUID                         5  0  value
005900000000      /free
006000000000         chainCUSTOME1(P_CUID
006100000000               );
006200000000         return CULINE1;
006300000000      /end-free
006400000000     pGetCusAdrline1   e
006500000000      *=============================================
006600000000     PGetCusAdrline2   B                     export
006700161027     DGetCusAdrline2   PI                   like(culine2)
006800161025     D P_CUID                         5  0  value
006900000000      /free
007000000000         chainCUSTOME1(P_CUID
007100000000               );
007200000000         return CULINE2;
007300000000      /end-free
007400000000     pGetCusAdrline2   e
007500000000      *=============================================
007600000000     PGetCusAdrline3   B                     export
007700161027     DGetCusAdrline3   PI                   like(culine3)
007800161025     D P_CUID                         5  0  value
007900000000      /free
008000000000         chainCUSTOME1(P_CUID
008100000000               );
008200000000         return CULINE3;
008300000000      /end-free
008400000000     pGetCusAdrline3   e
008500000000      *=============================================
008600000000     PGetCusZip        B                     export
008700161027     DGetCusZip        PI                   like(cuzip)
008800161025     D P_CUID                         5  0  value
008900000000      /free
009000000000         chainCUSTOME1(P_CUID
009100000000               );
009200000000         return CUZIP;
009300000000      /end-free
009400000000     pGetCusZip        e
009500000000      *=============================================
009600000000     PGetCusCity       B                     export
009700161027     DGetCusCity       PI                   like(cucity)
009800161025     D P_CUID                         5  0  value
009900000000      /free
010000000000         chainCUSTOME1(P_CUID
010100000000               );
010200000000         return CUCITY;
010300000000      /end-free
010400000000     pGetCusCity       e
010500000000      *=============================================
010600000000     PGetCusCountry    B                     export
010700161027     DGetCusCountry    PI                   like(cucoun)
010800161025     D P_CUID                         5  0  value
010900000000      /free
011000000000         chainCUSTOME1(P_CUID
011100000000               );
011200000000         return CUCOUN;
011300000000      /end-free
011400000000     pGetCusCountry    e
011500000000      *=============================================
011600000000     PGetCusLimCredit  B                     export
011700161027     DGetCusLimCredit  PI                   like(culimcre)
011800161025     D P_CUID                         5  0  value
011900000000      /free
012000000000         chainCUSTOME1(P_CUID
012100000000               );
012200000000         return CULIMCRE;
012300000000      /end-free
012400000000     pGetCusLimCredit  e
012500000000      *=============================================
012600000000     PGetCusCredit     B                     export
012700161027     DGetCusCredit     PI                   like(cucredit)
012800161025     D P_CUID                         5  0  value
012900000000      /free
013000000000         chainCUSTOME1(P_CUID
013100000000               );
013200000000         return CUCREDIT;
013300000000      /end-free
013400000000     pGetCusCredit     e
013401161219      *=============================================
013402161219      // Remove the comment (//) to test the addition of a function
013403161219      // PGetCusLastOrdDate...
013404161219      // P                 B                     export
013405161219      // dGetCusLastOrdDate...
013406161219      // D                 PI                   like(culastord)
013407161219      // D P_CUID                         5  0  value
013408161219      //  /free
013409161219      //   chainCUSTOME1(P_CUID
013410161219      //         );
013411161219      //   return CULastOrd;
013412161219      //  /end-free
013413161219      // p                 e
013500161025      *=============================================
013600161025     P ExistCus        B                     export
013700161025     D ExistCus        PI              n
013800161025     D P_CUID                         5  0  value
013900161025      /free
014000161025         chainCUSTOME1(P_CUID
014100161025               );
014200161025         return %found(custome1) and CUDEL <> 'X';
014300161025      /end-free
014400161025     p ExistCus        e
014500161025
014600000000      *=============================================
014700000000     PIsCusDeleted     B                     export
014800161025     DIsCusDeleted     PI              n
014900161025     D P_CUID                         5  0  value
015000000000      /free
015100000000         chainCUSTOME1(P_CUID
015200000000               );
015300161025         return CUDEL = 'X';
015400000000      /end-free
015500000000     pIsCusDeleted     e
015600000000
015700000000     p chainCUSTOME1   b
015800000000     d chainCUSTOME1   pi
015900161025     D P_CUID                         5  0  value
016000000000      /free
016100000000        if not %open(CUSTOME1);
016200000000          open CUSTOME1;
016300000000        endif;
016400000000         if P_CUID <> CUID;
016500000000           K_CUID =  P_CUID;
016600000000           clear *all FCUST;
016700000000           chain kf CUSTOME1;
016800000000         endif;
016900000000      /end-free
017000000000     p chainCUSTOME1   e
017100000000
017200000000     p closeCUSTOME1   b
017300000000     d closeCUSTOME1   pi
017400000000      /free
017500000000        if %open(CUSTOME1);
017600000000          close CUSTOME1;
017700000000        endif;
017800000000      /end-free
017900000000     p closeCUSTOME1   e
018000000000
018100000000
