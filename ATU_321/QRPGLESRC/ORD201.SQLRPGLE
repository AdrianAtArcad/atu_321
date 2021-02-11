000100161025
000200161025     h dftactgrp(*no) bnddir('SAMPLE')
000300161025
000400161201     forder1    uf   e           k disk
000401161027     fcustome1  if   e           k disk
000402161103     farticle1  if   e           k disk
000403161201     fdetord1   uf   e           k disk
000500161027     ford201d   cf   e             workstn
000600161024     F                                     indds(indds)
000700161024     F                                     sfile(sfl01:rrn01)
000800161024     F                                     Infds(Info)
001106161025
001107161209     d Neword          pr                  extpgm('ORD100C2')
001109161209
001110161201     d Updord          pr                  extpgm('ORD101')
001111161103     d  x                                  like(orid)
001112161201
001113161201     d dspord          pr                  extpgm('ORD202')
001114161201     d  x                                  like(orid)
001115161103
001116161129     d Prtord          pr                  extpgm('ORD500')
001117161129     d  x                                  like(orid)
001118161129
001200161024     D indds           ds
001300161024     D  help                   1      1n
001400161024     D  exit                   3      3n
001500161024     D  prompt                 4      4n
001600161024     D  refresh                5      5n
001601161027     D  create                 6      6n
001700161024     D  cancel                12     12n
001800161024     D  morekeys              24     24n
001900161024     D  pagedown              25     25n
002000161024     D  sflclr                30     30n
002100161024     D  sfldsp                31     31n
002200161024     D  sfldspctl             32     32n
002300161024     D  sflnxtchg             33     33n
002400161024     D  dspatr_ri             34     34n
002500161024     D  sflmsg                35     35n
002501161201     D  sflmsg2               36     36n
002502161201     D  sflmsg3               37     37n
002800161024     D  sflend                80     80n
002900161024
003000161024     D info            ds
003100161024     D  lrrn                 378    379i 0
003200161024
003300161024     D rrn01           s              5i 0
003400161024     D rrs01           s              5i 0
003500161024     D err01           s               n
003600161024
003700161024     D panel           S              3i 0 INZ(1)
003800161024     D step01          S              3    inz(prp)
004101161025     d User            s             10    inz(*user)
004200161024     d count           s              3i 0
004300161024     d mode            s              3
004400161024
004500161024     d crt             c                   'CRT'
004600161024     d upd             c                   'UPD'
004700161024     d prp             c                   'prp'
004800161024     d lod             c                   'lod'
004900161024     d dsp             c                   'dsp'
005000161024     d key             c                   'key'
005100161024     d chk             c                   'chk'
005400161024     d act             c                   'act'
005401161027     d datBlank        c                   d'1940-01-01'
005500161103      /free
005600161024       select;
005700161024       when panel = 1;
005800161024         exsr pnl01;
006300161024       other;
006400161024         exsr pnl00;
006500161024       endsl;
006600161024       //- Subfiles  01 Subroutines --------------------------------------  ---
006700161024       begsr pnl01;
006800161024         select ;
006900161024         when step01 = prp ;
007000161024           exsr s01prp;
007100161024         when step01 = lod ;
007200161024           exsr s01lod;
007300161024         when step01 = dsp ;
007400161024           exsr s01dsp;
007500161024         when step01 = key ;
007600161024           exsr s01key;
007700161024         when step01 = chk ;
007800161024           exsr s01chk;
007900161024         when step01 = act ;
008000161024           exsr s01act ;
008100161024         endsl;
008200161024       endsr;
008300161024       //--- Clear Subfile  ----------------------------------------------------
008400161024       begsr s01prp;
008500161024         RRn01 = 0;
008600161024         sflclr = *on;
008700161024         write ctl01;
008800161024         sflclr = *off;
008801161027         exec sql declare c1 cursor for
008802170705           SELECT ORID, ORYEAR,
008803170705                  ISOTODATE40(ORDATE) AS DATORD,
008804170705                  ISOTODATE40(ORDATDEL) AS DATLIV,
008805170705                  ISOTODATE40(ORDATCLO) AS DATCLO ,
008806170705                  TOTVAL,
008807161027                  orcuid, custnm
008808161027           FROM Ordercus
008809161209           order by datord desc, orid desc;
008810161027         exec sql open c1;
008900161024         step01 = lod;
008901161027         rrs01 = 0;
009200161024       endsr;
009300161024       //--- Load Subfile  -----------------------------------------------------
009400161024       begsr s01lod;
009401161027         rrn01 = rrs01;
009600161024         RRb01 = RRn01 + 1;
009700161024         opt01 = 0;
009701161027         count = 0;
010000161027         dow sqlcod = 0 and count < 14;
010001161027         exec sql fetch c1 into :orid, :oryear, :datord,
010002161027                                :datliv, :datclo, :sumord,
010003161027                                :cuid, :custnm;
010004161027           if sqlcod =  0;
010100161027             RRN01 += 1;
010101161027             count += 1;
010300161027             write sfl01;
010301161027           endif;
010500161024         enddo;
010600161027         sflend = sqlcod <> 0;
010700161024         step01 = dsp;
010701161027         rrs01 = rrn01;
010900161024       endsr;
012000161024       //--- Display Subfile  --------------------------------------------------
012100161024       begsr s01dsp;
012200161024         sfldspctl = *on;
012300161024         sfldsp = RRn01 > 0;
012400161024
012500161024         write key01;
012600161024         exfmt ctl01;
012700161024         if LRRN <>0;
012800161024           RRb01 = LRRN;
012900161024         endif;
013000161024         step01 = key;
013100161024       endsr;
013200161024       //--- Command Keys  -----------------------------------------------------
013300161024       begsr s01key;
013400161024         select;
013500161024         when exit;
013600161024           panel  = 0;
013700161024           step01 = prp;
013800161024         when cancel;
013900161024           step01 = prp;
014000161024           panel  = panel  - 1;
014001161209         when refresh;
014002161209           step01 = prp;
014003161209           exec sql close c1;
014004161209         when create;
014005161209           NewOrd();
014006161209           step01 = prp;
014008161209           exec sql close c1;
014009161027         when pagedown;
014010161027           step01 = lod;
014300161024         other;
014400161024           step01 = chk;
014500161024         endsl;
014600161024       endsr;
014700161024       //--- Check Subfile  ----------------------------------------------------
014800161024       begsr s01chk;
014900161024         step01 = act;
015000161024         err01 = *off;
015100161024         sflnxtchg = *on;
015200161024         readc(e) sfl01;
015300161024         dow not %error and not %eof;
015400161129           if opt01 = 1 or opt01 > 8 ;
015500161024             step01 = dsp;
015600161024             dspatr_ri = *on;
015700161024             sflmsg = *on;
015800161024             if not err01;
015900161024               rrb01 = rrn01;
016000161024               err01 = *on;
016100161024             endif;
016200161024           endif;
016201161201           if opt01 = 7 and datclo > datBlank
016202161201             or opt01 = 8 and datliv > datBlank;
016203161201             step01 = dsp;
016204161201             dspatr_ri = *on;
016205161201             sflmsg = *on;
016206161201             if not err01;
016207161201               rrb01 = rrn01;
016208161201               err01 = *on;
016209161201             endif;
016210161201           endif;
016211170112           if (opt01 = 2 or opt01 = 4) and datclo > datBlank;
016212161201             step01 = dsp;
016213161201             dspatr_ri = *on;
016214161201             sflmsg2 = *on;
016215161201             if not err01;
016216161201               rrb01 = rrn01;
016217161201               err01 = *on;
016218161201             endif;
016219161201           endif;
016220161201           if opt01 = 4;
016221161201             setll orid detord1;
016222161201             reade(n) orid detord1;
016223161201             dow not %eof();
016224161201               if odqtyliv > 0;
016225161201                 step01 = dsp;
016226161201                 dspatr_ri = *on;
016227161201                 sflmsg3 = *on;
016228161201                 if not err01;
016229161201                   rrb01 = rrn01;
016230161201                   err01 = *on;
016231161201                 endif;
016232161201                 leave;
016233161201               endif;
016234161201               reade(n) orid detord1;
016235161201             enddo;
016236161201           endif;
016300161024           update sfl01;
016400161024           dspatr_ri = *off;
016500161024           readc(e) sfl01;
016600161024         enddo;
016700161024         sflnxtchg = *off;
016800161024       endsr;
016900161024       //--- action Subfile  ---------------------------------------------------
017000161024       begsr s01act;
017100161024         readc(e) sfl01;
017200161024         select;
017300161024         when %error or %eof;
017400161024           step01 = dsp;
017500161103         when opt01 = 2;
017501161201           Updord(orid);
017800161024           opt01 = 0;
017900161024           update sfl01;
017901161201         when opt01 = 4;
017902161201           dou not %found();
017903161201             delete orid detord1;
017904161201           enddo;
017905161201           delete orid order1;
017906161209           orid = 0;
017907161209           oryear = 0;
017908161201           opt01 = 0;
017909161201           update sfl01;
017910161103         when opt01 = 5;
017911161103           dspord(orid);
017912161103           opt01 = 0;
017913161103           update sfl01;
017914161129         when opt01 = 6;
017915161129           Prtord(orid);
017916161129           opt01 = 0;
017917161129           update sfl01;
017918161201         when opt01 = 7;
017919161201           chain (orid) order1;
017920161201           if ordatdel = 0;
017921161201             ordatdel = %dec(%date():*iso);
017922161201             datliv = %date();
017923161201           endif;
017924161201           ordatclo = %dec(%date():*iso);
017925161201           update forde;
017926161201           datclo = %date();
017927161201           opt01 = 0;
017928161201           update sfl01;
017929161201         when opt01 = 8;
017930161201           chain (orid) order1;
017931161201           ordatdel = %dec(%date():*iso);
017932161201           datliv = %date();
017933161201           update forde;
017934161201           setll orid detord1;
017935161201           reade orid detord1;
017936161201           dow not %eof();
017937161201             if odqtyliv = 0;
017938161201               odqtyliv = odqty;
017939161201               update fdeto;
017940161201             else;
017941161201               unlock detord1;
017942161201             endif;
017943161201             reade orid detord1;
017944161201           enddo;
017945161201           opt01 = 0;
017946161201           update sfl01;
018500161024         other;
018600161024
018700161024         endsl;
018800161024       endsr;
018900161024
025700161025       //--------INITIALIZATION ----------------------------------
025800161025       begsr *inzsr;
025801161027         datord = datBlank;
025802161027         datclo = datBlank;
025803161027         datliv = datBlank;
025900161025       endsr;
026000161025       //--------END SUBROUTINE ----------------------------------
026100161025       begsr pnl00;
026101161027         exec sql close c1;
026200161025         *inlr = *on;
026300161025       endsr;
026400161103      /end-free
