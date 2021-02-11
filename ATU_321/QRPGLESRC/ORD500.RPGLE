000021161129     h dftactgrp(*no)
000100161129
000200161130     ford500o   o    e             printer oflind(overflow)
000300161129
000400161129     forder1    if   e           k disk
000500161129     fdetord1   if   e           k disk
000600161129     fcustome1  if   e           k disk
000700161129     farticle1  if   e           k disk
000800161129
000801161209      /copy qprotosrc,parameter
000802161209
000900161129     d ord500          pr
001000161129     d   id                                like(orid)
001001161129
001100161129     d ord500          pi
001200161129     d   id                                like(orid)
001201161130
001202161130     d pdford          pr                  extpgm('ORD500C')
001203161130     d   id                           5    const
001204161209     d   path                       100    const
001205161130
001206161130     d count           s              3u 0
001207161209     d path            s            100
001300161129
001400161129      /free
001401170303
001402170303        datord = %date();
001500161129        chain id order1;
001501170220        datord = %date(ORDATE:*iso);
001600161129        chain orcuid custome1;
001700161129        write header;
001701161130        write header2;
001702161130        write header3;
001800161129        setll (orid) detord1;
001900161129        reade (orid) detord1;
002000161129        dow not %eof;
002001161130          if count > 14;
002002161130            write footer;
002003161130            write header;
002004161130            write header3;
002005161130            count = 0;
002006161129          endif;
002100161129          chain odarid article1;
002101161130          count += 1;
002102161130          totnet += odtot;
002103161130          tottot += odtotvat;
002200161129          write detail;
002300161129          reade (orid) detord1;
002400161129        enddo;
002500161129        *inlr = *on;
002501161130        totvat = tottot -totnet;
002502161130        write total;
002503161130        write footer;
002504161130        close ord500o;
002505161209        path = getParm2('PATH':' ');
002506161209        pdfOrd(%trim(%char(orid)):path);
002600161129      /end-free
