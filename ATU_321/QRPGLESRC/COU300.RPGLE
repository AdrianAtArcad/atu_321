000100000000     h nomain
000200000000
000300000000     FCOUNTRY   if   e           k disk    usropn
000400000000
000500000000      /copy qprotosrc,COUNTRY
000600000000
000700000000     d chainCOUNTRY    pr
000800000000     D P_COID                         2A    value
000900000000
001000000000     D K_COID          S                   LIKE(COID)
001100000000
001200000000     C     kf            klist
001300000000     C                   KFLD                    K_COID
001400000000
001500000000      *=============================================
001600161027     PGetCountryName   B                     export
001700161027     DGetCountryName   PI                   like(countr)
001800000000     D P_COID                         2A    value
001900000000      /free
002000000000         chainCOUNTRY(P_COID
002100000000               );
002200000000         return COUNTR;
002300000000      /end-free
002400000000     pGetCountryName   e
002500000000      *=============================================
002600000000     PGetCountryIso3   B                     export
002700161027     DGetCountryIso3   PI                   like(coiso)
002800000000     D P_COID                         2A    value
002900000000      /free
003000000000         chainCOUNTRY(P_COID
003100000000               );
003200000000         return COISO;
003300000000      /end-free
003400000000     pGetCountryIso3   e
003500000000
003600161025      *=============================================
003700161025     P ExistCountry    B                     export
003800161025     D ExistCountry    PI              n
003900161025     D P_COID                         2A    value
004000161025      /free
004100161025         chainCOUNTRY(P_COID
004200161025               );
004300161025         return %found(country);
004400161025      /end-free
004500161025     p ExistCountry    e
004600161025
004700000000     p chainCOUNTRY    b
004800000000     d chainCOUNTRY    pi
004900000000     D P_COID                         2A    value
005000000000      /free
005100000000        if not %open(COUNTRY);
005200000000          open COUNTRY;
005300000000        endif;
005400000000         if P_COID <> COID;
005500000000           K_COID =  P_COID;
005600000000           clear *all FCOUN;
005700000000           chain kf COUNTRY;
005800000000         endif;
005900000000      /end-free
006000000000     p chainCOUNTRY    e
006100000000
006200000000     p closeCOUNTRY    b
006300000000     d closeCOUNTRY    pi
006400000000      /free
006500000000        if %open(COUNTRY);
006600000000          close COUNTRY;
006700000000        endif;
006800000000      /end-free
006900000000     p closeCOUNTRY    e
007000000000
007100000000
