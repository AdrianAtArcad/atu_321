000100000000     h nomain
000200000000
000300000000     FARTICLE1  if   e           k disk    usropn
000400000000
000500000000      /copy qprotosrc,ARTICLE
000600000000
000700000000     d chainARTICLE1   pr
000800000000     D P_ARID                         6A    value
000900000000
001000000000     D K_ARID          S                   LIKE(ARID)
001100000000
001200000000     C     kf            klist
001300000000     C                   KFLD                    K_ARID
001400000000
001500000000      *=============================================
001600000000     PGetArtDesc       B                     export
001700161027     DGetArtDesc       PI                   like(ardesc)
001800000000     D P_ARID                         6A    value
001900000000      /free
002000000000         chainARTICLE1(P_ARID
002100000000               );
002200000000         return ARDESC;
002300000000      /end-free
002400000000     pGetArtDesc       e
002500000000      *=============================================
002600161025     PGetArtRefSalPrice...
002700161025     P                 B                     export
002800161025     DGetArtRefSalPrice...
002900161027     D                 PI                   like(arsalepr)
003000000000     D P_ARID                         6A    value
003100000000      /free
003200000000         chainARTICLE1(P_ARID
003300000000               );
003400000000         return ARSALEPR;
003500000000      /end-free
003600161025     p                 e
003700000000      *=============================================
003800161025     PGetArtStockPrice...
003900161025     P                 B                     export
004000161025     DGetArtStockPrice...
004100161027     D                 PI                   like(arwhspr)
004200000000     D P_ARID                         6A    value
004300000000      /free
004400000000         chainARTICLE1(P_ARID
004500000000               );
004600000000         return ARWHSPR;
004700000000      /end-free
004800161025     p                 e
004900000000      *=============================================
005000000000     PGetArtFam        B                     export
005100161027     DGetArtFam        PI                   like(artifa)
005200000000     D P_ARID                         6A    value
005300000000      /free
005400000000         chainARTICLE1(P_ARID
005500000000               );
005600000000         return ARTIFA;
005700000000      /end-free
005800000000     pGetArtFam        e
005900000000      *=============================================
006000000000     PGetArtStock      B                     export
006100161027     DGetArtStock      PI                   like(arstock)
006200000000     D P_ARID                         6A    value
006300000000      /free
006400000000         chainARTICLE1(P_ARID
006500000000               );
006600000000         return ARSTOCK;
006700000000      /end-free
006800000000     pGetArtStock      e
006900000000      *=============================================
007000000000     PGetArtMinStock   B                     export
007100161027     DGetArtMinStock   PI                   like(arminqty)
007200000000     D P_ARID                         6A    value
007300000000      /free
007400000000         chainARTICLE1(P_ARID
007500000000               );
007600000000         return ARMINQTY;
007700000000      /end-free
007800000000     pGetArtMinStock   e
007801161027      *=============================================
007802161027     PGetArtVatCode    B                     export
007803161027     DGetArtVatCode    PI                   like(arvatcd)
007804161027     D P_ARID                         6A    value
007805161027      /free
007806161027         chainARTICLE1(P_ARID
007807161027               );
007808161027         return ARvatcd ;
007809161027      /end-free
007810161027     pGetArtVatCode    e
007900000000      *=============================================
008000161025     P ExistArt        B                     export
008100161025     D ExistArt        PI              n
008200000000     D P_ARID                         6A    value
008300000000      /free
008400000000         chainARTICLE1(P_ARID
008500000000               );
008600161027         return %found(article1) and ardel <> 'X';
008700000000      /end-free
008800161025     p ExistArt        e
008900000000
009000161025      *=============================================
009100161025     PIsArtDeleted     B                     export
009200161025     DIsArtDeleted     PI              n
009300161025     D P_ARID                         6A    value
009400161025      /free
009500161025         chainARTICLE1(P_ARID
009600161025               );
009700161027         return ArDEL = 'X';
009800161025      /end-free
009900161025     pIsArtDeleted     e
010000161025
010100000000     p chainARTICLE1   b
010200000000     d chainARTICLE1   pi
010300000000     D P_ARID                         6A    value
010400000000      /free
010500000000        if not %open(ARTICLE1);
010600000000          open ARTICLE1;
010700000000        endif;
010800000000         if P_ARID <> ARID;
010900000000           K_ARID =  P_ARID;
011000000000           clear *all FARTI;
011100000000           chain kf ARTICLE1;
011200000000         endif;
011300000000      /end-free
011400000000     p chainARTICLE1   e
011500000000
011600000000     p closeARTICLE1   b
011700000000     d closeARTICLE1   pi
011800000000      /free
011900000000        if %open(ARTICLE1);
012000000000          close ARTICLE1;
012100000000        endif;
012200000000      /end-free
012300000000     p closeARTICLE1   e
012400000000
012500000000
