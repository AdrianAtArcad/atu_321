000018161209     forder     UF   E             DISK
000019161209
000020161209     d lastdate        s              8  0
000021161209     d today           s              8  0
000022161209     d days            s              5  0
000023161209
000024161209      /free
000025161209         exec sql select max(ordate)  into :LastDate from order;
000026161209         if lastdate = 0;
000027161209           *inlr = *on;
000028161209           return;
000029161209         ENDIF;
000030161209         today = %dec(%date():*iso);
000031161209         days = %diff(%date():%date(lastdate:*iso):*d);
000032161209         lastdate = %dec(%date() - %days(10):*iso);
000033161209         read order;
000034161209         dow not %eof;
000035161209           ordate = %dec(%date(ordate:*iso) + %days(days):*iso);
000036161209           if ordatdel > 0;
000037161209              ordatdel = %dec(%date(ordatdel:*iso) + %days(days):*iso);
000038161209              if  ordatdel > today;
000039161209                ordatdel = 0;
000040161209              ENDIF;
000041161209           ENDIF;
000042161209           if ordatclo > 0;
000043161209              ordatclo = %dec(%date(ordatclo:*iso) + %days(days):*iso);
000044161209              if  ordatclo > today ;
000045161209                ordatclo = 0;
000046161209              ENDIF;
000047161209           else;
000048161209              if ordatdel > 0 and ordatdel < lastdate ;
000049161209                ordatclo =  %dec(%date(ordatdel:*iso) + %days(10):*iso);
000050161209              ENDIF;
000051161209           ENDIF;
000052161209           oryear = %subdt(%date(ordate:*iso):*Y);
000053161209           update forde;
000054161209           read order;
000055161209         ENDDO;
000056161209         exec sql Update detord d set odyear = (select oryear
000057161209                from order where d.odorid = orid)
000058161209                where odyear <> (select oryear
000059161209                from order where d.odorid = orid) ;
000060161219         exec sql  UPDATE CUSTOMER  C SET CULASTORD =
000061161219              ( SELECT MAX ( ORDATE ) FROM "ORDER"
000062161219                      WHERE C.CUID = ORCUID )
000063161219                WHERE EXISTS ( SELECT ORCUID FROM "ORDER"
000064161219                      WHERE C.CUID = ORCUID );
000065161209         *inlr = *on;
000066161209      /end-free
