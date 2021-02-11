000021161208     h dftactgrp(*no)
000022161208     fpro202d   cf   e             workstn
000023161208
000024161208      /copy qprotosrc,Xss
000025161209      /copy qprotosrc,Parameter
000026161208
000027161208     d data            ds                  inz
000028161208     d   ARID                         6
000029161208     d   ARDESC                      50A
000030161208     d   ARSTOCK                      5P 0
000031161208     d   ARMINQTY                     5P 0
000032161208     d   ARCUSQTY                     5P 0
000033161208     d   ARPURQTY                     5P 0
000034161208     d   PRID                         5P 0
000035161208     d   PROVNM                      30A
000036161208     d   APPRICE                      7P 2
000037161208     d   APREF                       10A
000038161208     d   TOT                          3  0
000039161208
000040161208     d r1              s             12
000041161208     d r2              s             12
000042161208     d head            s              3u 0
000043161208     d dec2            s              3u 0
000044161208     d Yellow          s              3u 0
000045161208
000046161208      /free
000047161208        fileName = 'Goods to purchase' + '_' +
000048161208                    %char(%dec(%date:*YMD)) + '.xml';
000049161209        path = GetParm2('PATH':' ');
000050161208        xssopenfile(%trim(path) + fileName);
000051161208        XssSetDocProperties('SAMPLE Company':' ':1);
000052161208        head = xsscreatestyle();
000053170109        xssSetFontSize(12);
000054161208        XssSetalign(ALIGN_CENTER);
000055161208        Xsssetwrap();
000056161208        dec2 = xsscreatestyle();
000057161208        XssSetFormat(FORMAT_DEC2);
000058161208        Yellow = xsscreatestyle();
000059161208        XsssetForcolor(COLOR_YELLOW);
000060161208        Xssaddsheet('Purchasing');
000061170109        XssSetColWidth(150 :2);
000062161208        xssaddrow(40);
000063161208        xssaddcellChar('Art Id':head);
000064161208        r1 = XssGetCellId();
000065161208        xssaddcellChar('Description':head);
000066161208        xssaddcellChar('Stock':head);
000067161208        xssaddcellChar('Minimun Stock':head);
000068161208        xssaddcellChar('Customer Order Qty':head);
000069161208        xssaddcellChar('Purchase Order Qty':head);
000070161208        xssaddcellChar('Proposed Order Qty':head);
000071161208        xssaddcellChar('Provider Id':head);
000072161208        xssaddcellChar('Name':head);
000073161208        xssaddcellChar('Purchase Price':head);
000074161208        xssaddcellChar('Provider Reference':head);
000075161208
000076161208        exec sql declare c1 cursor for
000077161208           SELECT ARID, ARDESC, arstock, ARMINQTY, ARCUSQTY, ARPURQTY, PRID,
000078161208                  PROVnm,  APPRICE, apref,
000079161208                  (select count(*) from artiprov b where a.aparid = b.aparid )
000080161208           FROM article, artiprov a, provider
000081161208           WHERE arstock < ARMINQTY - arcusqty + arpurqty
000082161208             and Arcusqty > 0
000083161208             and arid = aparid AND apprid = prid
000084161208          ORDER BY arid, apprid;
000085161208        exec sql open c1;
000086161208
000087161208        exec sql fetch c1 into :data;
000088161208        dow sqlcod = 0;
000089161208          xssaddrow();
000090161208          if tot = 1;
000091161208            XssAddCellChar(ARID);
000092161208            XssAddCellChar(ARDESC);
000093161208          else;
000094161208            XssAddCellChar(ARID:Yellow);
000095161208            XssAddCellChar(ARDESC:Yellow);
000096161208          ENDIF;
000097161208          xssaddcellNum(ARSTOCK);
000098161208          XssAddCellNum(ARMINQTY);
000099161208          XssAddCellNum(ARCUSQTY);
000100161208          XssAddCellNum(ARPURQTY);
000101161208          XssAddCellNum(ARMINQTY + ARCUSQTY - arpurqty - arstock);
000102161208          XssAddCellNum(PRID);
000103161208          XssAddCellChar(PROVNM);
000104161208          XssAddCellNum(APPRICE:dec2);
000105161208          XssAddCellChar(APREF);
000106161208          exec sql fetch c1 into :data;
000107161208        ENDDO;
000108161208        exec sql close c1;
000109161208        r2 = XssGetCellId();
000110161208        XssSetAutoFilter(r1:r2);
000111161208        Xssclosefile();
000112161208        exfmt fmt03;
000113161208
000114161208        *inlr = *on;
000115161208      /end-free
000116161208
