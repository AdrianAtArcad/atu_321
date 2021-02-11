000100000000     h nomain
000200000000
000300000000     FFAMILLY   if   e           k disk    usropn
000400000000
000500000000      /copy qprotosrc,FAMILLY
000600000000
000700000000     d chainFAMILLY    pr
000800161025     D P_FAID                         3     value
000900000000
001000000000     D K_FAID          S                   LIKE(FAID)
001100000000
001200000000     C     kf            klist
001300000000     C                   KFLD                    K_FAID
001400000000
001500000000      *=============================================
001600000000     PGetArtFamDesc    B                     export
001700161027     DGetArtFamDesc    PI                   like(fadesc)
001800161025     D P_FAID                         3     value
001900000000      /free
002000000000         chainFAMILLY(P_FAID
002100000000               );
002200000000         return FADESC;
002300000000      /end-free
002400000000     pGetArtFamDesc    e
002500000000      *=============================================
002600161025     P ExistArtFam     B                     export
002700161025     D ExistArtFam     PI              n
002800161025     D P_FAID                         3     value
002900000000      /free
003000000000         chainFAMILLY(P_FAID
003100000000               );
003200161025         return %found(familly);
003300000000      /end-free
003400161025     p ExistArtFam     e
003500000000
003600161025      *=============================================
003700161025     PIsArtFamDeleted  B                     export
003800161025     DIsArtFamDeleted  PI              n
003900161025     D P_FAID                         3     value
004000161025      /free
004100161025         chainFAMILLY(P_FAID
004200161025               );
004300161025         return FADEL = 'X';
004400161025      /end-free
004500161025     pIsArtFamDeleted  e
004600161025
004700000000     p chainFAMILLY    b
004800000000     d chainFAMILLY    pi
004900161025     D P_FAID                         3     value
005000000000      /free
005100000000        if not %open(FAMILLY);
005200000000          open FAMILLY;
005300000000        endif;
005400000000         if P_FAID <> FAID;
005500000000           K_FAID =  P_FAID;
005600000000           clear *all FFAMI;
005700000000           chain kf FAMILLY;
005800000000         endif;
005900000000      /end-free
006000000000     p chainFAMILLY    e
006100000000
006200000000     p closeFAMILLY    b
006300000000     d closeFAMILLY    pi
006400000000      /free
006500000000        if %open(FAMILLY);
006600000000          close FAMILLY;
006700000000        endif;
006800000000      /end-free
006900000000     p closeFAMILLY    e
007000000000
007100000000
