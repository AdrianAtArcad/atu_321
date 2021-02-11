000100161129     h nomain
000200161129
000300161129     FVATDEF    if   e           k disk    usropn
000400161129
000500161129      /copy qprotosrc,VAT
000600161129
000700161129     d chainVATDEF     pr
000800161129     D P_VATCODE                      1A    value
000900161129
001000161129     D K_VATCODE       S                   LIKE(VATCODE)
001100161129
001200161129     C     kf            klist
001300161129     C                   KFLD                    K_VATCODE
001400161129
001500161129      *=============================================
001600161129     PGetVATRate       B                     export
001700161129     DGetVATRate       PI             4P 2
001800161129     D P_VATCODE                      1A    value
001900161129      /free
002000161129         chainVATDEF(P_VATCODE  );
002200161129         return VATRATE;
002300161129      /end-free
002400161129     pGetVATRate       e
002500161129      *=============================================
002600161129     PGetVATDesc       B                     export
002700161129     DGetVATDesc       PI            20A
002800161129     D P_VATCODE                      1A    value
002900161129      /free
003000161129         chainVATDEF(P_VATCODE  );
003200161129         return VATDESC;
003300161129      /end-free
003400161129     pGetVATDesc       e
003500161129
003501161129      *=============================================
003502161129     P ClcVAT          B                     export
003503161129     D ClcVAT          PI             9  2
003504161129     D P_VATCODE                      1     value
003505161129     d Net                            9  2  value
003506161129
003507161129     d tot             s             11  4
003508161129      /free
003509161129         chainVATDEF(P_VATCODE  );
003511161129         tot = (net * vatrate) / 100;
003512161129         return %dech(tot : 9 :2) ;
003513161129      /end-free
003514161129     p ClcVAT          e
003515161129
003516161129      *=============================================
003517161129     P ExistVATRate    B                     export
003518161129     D ExistVATRate    PI              n
003519161129     D P_VATCODE                      1A    value
003520161129      /free
003521161129         chainVATDEF(P_VATCODE  );
003523161129         return %found(VATDEF) and VATDEL <> 'X';
003524161129      /end-free
003525161129     p ExistVATRate    e
003526161129
003600161129     p chainVATDEF     b
003700161129     d chainVATDEF     pi
003800161129     D P_VATCODE                      1A    value
003900161129      /free
004000161129        if not %open(VATDEF);
004100161129          open VATDEF;
004200161129        endif;
004300161129         if P_VATCODE <> VATCODE;
004400161129           K_VATCODE =  P_VATCODE;
004500161129           clear *all FVAT;
004600161129           chain kf VATDEF;
004700161129         endif;
004800161129      /end-free
004900161129     p chainVATDEF     e
005000161129
005100161129     p closeVATDEF     b
005200161129     d closeVATDEF     pi
005300161129      /free
005400161129        if %open(VATDEF);
005500161129          close VATDEF;
005600161129        endif;
005700161129      /end-free
005800161129     p closeVATDEF     e
005900161129
006000161129
