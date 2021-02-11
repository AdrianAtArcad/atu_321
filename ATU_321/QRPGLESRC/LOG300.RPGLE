000001170303      *   %XREF XREFTYPE(*OBJ)   OBJ(SAMLOG) OBJTYPE(*USRSPC)   USAGE(*UPD)
000004170215
000100161216     h nomain
000101161216
000200161216      /copy qprotosrc,apicall
000300161216      /copy qprotosrc,log
000301161216     d init            pr
000400161216
000401161216     d pos             s             10i 0 based(p1)
000402161216     d data            s            600    based(p2)
000403161216     d usrspc          s             20
000404161216     d inz             s               n
000405161216     d User            s             10    inz(*USER)
000406161216
000407161216     p AddLogEntry     b                   export
000408161216     d AddLogEntry     pi
000409161216     d  entry                       500    value
000410161216
000411161216     d  data2          s            500    varying
000412161216      /free
000413161216        if not inz;
000414161216          init();
000415161216        endif;
000416161216        p2 = p1 + pos;
000417161216        data2 = 'User: ' +user + ' * ';
000418161216        data2 += 'Date: '  + %char(%Timestamp()) + ' * ' ;
000419161216        data2 += 'Msg: '  + %trim(entry) + ' ***' ;
000420161216        data = data2;
000421161216        pos += %len(data2);
000422161216      /end-free
000423161216
000424161216     p AddLogEntry     e
000425161216
000426161216     p init            b
000427161216     d init            pi
000428161216
000500161216      /free
000502161216        usrspc = 'SAMLOG    *LIBL';
000504161216        inz = *on;
000505161216        rtvusrspcptr(usrspc:p1);
000506161216      /end-free
000600161216
000700161216     p init            e
