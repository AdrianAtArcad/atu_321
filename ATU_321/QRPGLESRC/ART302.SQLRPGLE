000100170303     h nomain
000200170303
000300170303      /copy qprotosrc,ARTICLE
000400170303
000500170303     d savInfo         s           1520
000600170303     d savId           s              6
000700170303      *=============================================
000800170303     PGetArtInfo       B                     export
000900170303     DGetArtInfo       PI          1520
001000170303     D P_ARID                         6A    value
001100170303      /free
001200170303         if P_arid <> savId;
001203170303           savid = p_arid;
001204170303           exec sql select artinf into :savinfo
001205170303              from artiinf
001206170303              where arid = :savid;
001207170303         endif;
001300170303
001301170303         return savinfo;
001500170303      /end-free
001600170303     pGetArtInfo       e
