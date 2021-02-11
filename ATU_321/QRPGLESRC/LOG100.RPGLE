000100161216
000200161216     h dftactgrp(*no)
000300161216     fparameter if   e           k disk
000301161216     f                                     infds(info)
000302161216
000400161216      /copy qprotosrc,apicall
000500161216
000501161216     d info            ds
000502161216     D  lib                   93    102
000503161216
000504161216     d                 ds                  based(p1)
000505161216     d  pos                          10i 0
000506161216     d  data                          3
000507161216
000508161216     d usrspc          s             20
000600161216      /free
000601161216        usrspc = 'SAMLOG    ' + Lib;
000700161216        crtusrspc(usrspc:'LOG':5000:X'00':'*ALL':'Sample Application Log'
000800161216                  :'*YES':errcod);
000900161216        rtvusrspcptr(usrspc:p1);
001000161216        pos = 7;
001100161216        data = '***';
001200161216        *inlr = *on;
001300161216      /end-free
