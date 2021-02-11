000100161025
000200161025     h dftactgrp(*no) bnddir('SAMPLE')
000300161025
000400161103     farticle2  if   e           k disk    rename(farti:farti2)
000401161103     farticle1  uf a e           k disk
000500161024     fart200d   cf   e             workstn
000600161024     F                                     indds(indds)
000700161024     F                                     sfile(sfl01:rrn01)
000800161024     F                                     Infds(Info)
000900161024
001000161025      /copy qprotosrc,familly
001001161025
001002161025     d providers       pr                  extpgm('ART201')
001003161025     d  id                                 like(arid)
001100161025
001200161024     D indds           ds
001300161024     D  help                   1      1n
001400161024     D  exit                   3      3n
001500161024     D  prompt                 4      4n
001600161024     D  refresh                5      5n
001601161027     D  Create                 6      6n
001700161024     D  cancel                12     12n
001800161024     D  morekeys              24     24n
001900161024     D  pagedown              25     25n
002000161024     D  sflclr                30     30n
002100161024     D  sfldsp                31     31n
002200161024     D  sfldspctl             32     32n
002300161024     D  sflnxtchg             33     33n
002400161024     D  dspatr_ri             34     34n
002500161024     D  sflmsg                35     35n
002600161025     D  errFamilly            40     40n
002700161025     D  errDesc               41     41n
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
003900161024     D step02          S              3    inz(prp)
004000161024     D step03          S              3    inz(prp)
004100161024     d savId           s                   like(arid)
004101161103     d savDesc         s                   like(ardesc)
004102161027     d NewId           s              6  0
004103161025     d User            s             10    inz(*user)
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
005401161103      /free
005500161024
005600161024       select;
005700161024       when panel = 1;
005800161024         exsr pnl01;
005900161024       when panel = 2;
006000161024         exsr pnl02;
006100161024       when panel = 3;
006200161024         exsr pnl03;
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
008900161024         step01 = lod;
009000161024         clear savid;
009001161103         savDesc = posTo;
009002161103         clear posTo;
009100161024         rrs01 = 0;
009200161024       endsr;
009300161024       //--- Load Subfile  -----------------------------------------------------
009400161024       begsr s01lod;
009500161024         exsr s01rst;
009600161024         RRb01 = RRn01 + 1;
009700161024         opt01 = 0;
009800161024         count = 0;
009900161103         read article2;
010000161103         dow not %eof(article2) and count < 14;
010100161024           RRN01 += 1;
010200161024           count += 1;
010300161024           write sfl01;
010400161103           read article2;
010500161024         enddo;
010600161024         sflend = %eof(article1);
010700161024         step01 = dsp;
010800161024         exsr s01sav;
010900161024       endsr;
011000161024       //--- restore last read -------------------------------------------------
011100161024       begsr s01rst;
011200161103         setll (savdesc:savid)  article2;
011300161024         rrn01 = rrs01;
011400161024       endsr;
011500161024       //--- Save last read -------------------------------------------------
011600161024       begsr s01sav;
011700161024         savid = arid;
011701161103         savdesc = ardesc;
011800161024         rrs01 = rrn01;
011900161024       endsr;
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
014001161027         when create;
014002161027           step01 = prp;
014003161027           panel  = 2 ;
014004161027           step02 = prp;
014005161027           mode = crt;
014100161024         when pagedown;
014200161024           step01 = lod;
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
015400161209           if opt01  > 6 or opt01 = 1 or opt01 = 5;
015500161024             step01 = dsp;
015600161024             dspatr_ri = *on;
015700161024             sflmsg = *on;
015800161024             if not err01;
015900161024               rrb01 = rrn01;
016000161024               err01 = *on;
016100161024             endif;
016200161024           endif;
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
017301161103           if posto > ' ';
017400161103             step01 = prp;
017401161103           else;
017402161103             step01 = dsp;
017403161103           endif;
017500161024         when opt01 = 2;
017600161024           panel = 2;
017700161024           step02 = prp;
017800161024           opt01 = 0;
017900161024           update sfl01;
017901161027           mode = upd;
018000161024         when opt01 = 3;
018100161024           panel = 3;
018200161024           step02 = prp;
018300161024           opt01 = 0;
018400161024           update sfl01;
018401161027         when opt01 = 4;
018402161027           chain arid article1;
018403161027           ardel = 'X';
018404161027           armod = %timestamp();
018405161027           armodid = user;
018406161027           update farti;
018407161027           step02 = dsp;
018408161027           opt01 = 0;
018409161027           update sfl01;
018410161025         when opt01 = 6;
018411161025           providers(arid);
018412161025           opt01 = 0;
018413161025           update sfl01;
018500161024         other;
018600161024
018700161024         endsl;
018800161024       endsr;
018900161024
019000161024
019100161024       //--- Format 02 Subroutines ------------------------------------     ---
019200161024       begsr pnl02;
019300161024         select ;
019400161024         when step02 = prp ;
019500161024           exsr s02prp;
019600161024         when step02 = dsp ;
019700161024           exsr s02dsp;
019800161024         when step02 = key ;
019900161024           exsr s02key;
020000161024         when step02 = chk ;
020100161024           exsr s02chk;
020200161024         when step02 = act ;
020300161024           exsr s02act ;
020400161024         endsl;
020500161024
020600161024       endsr;
020700161024       //--- clear & Load ------------------------------------------------------
020800161024       begsr S02prp;
020801161027         if mode = crt;
020803161027           setgt *hival article1;
020804161027           readp article1;
020805161027           Newid = %dec(arid :6: 0)  +1;
020806161027           reset farti;
020807161027           arid = %editc(NewId:'X');
020808161027         else;
020900161027           chain arid article1;
021000161027           famdesc = getArtFamDesc(artifa);
021001161027         endif;
021100161024         step02 = dsp;
021200161024       endsr;
021300161024       //--- Display  ----------------------------------------------------------
021400161024       begsr S02dsp;
021500161024         exfmt fmt02;
021600161024         step02 = key;
021700161024       endsr;
021800161024       //--- command Keys  -----------------------------------------------------
021900161024       begsr S02key;
022000161024         select;
022100161024         when exit;
022200161024           panel  = 1;
022300161024           step02 = prp;
022400161024         when cancel;
022500161024           step02 = prp;
022600161024           panel  = panel  - 1;
022700161025         when prompt;
022800161025           artifa = sltArtFam(artifa);
022900161025           famdesc = getArtFamDesc(artifa);
023000161025           step02 = dsp;
023100161024         other;
023200161024           step02 = chk;
023300161024         endsl;
023400161024       endsr;
023500161024       //--- check -------------------------------------------------------------
023600161024       begsr S02chk;
023700161024         step02 = act;
023800161025         if ardesc = ' ';
023900161025           errDesc = *on;
024000161025           step02 = dsp;
024100161025         endif;
024200161025         if not existArtFam(artifa);
024300161025           errFamilly = *on;
024400161025           step02 = dsp;
024500161025         endif;
024600161024
024700161024       endsr;
024800161024       //--- Action ------------------------------------------------------------
024900161024       begsr S02act;
025000161024         step02 = prp;
025002161027         armod = %timestamp();
025003161027         armodid = user;
025100161024         if mode = upd;
025200161024           update farti;
025201161027         else;
025202161027           arcrea = %date();
025203161027           write(e) farti;
025204161027           dow %error;
025205161027             Newid += 1;
025207161027             arid = %editc(NewId:'X');
025209161027             write(e) farti;
025210161027           enddo;
025211161103           savdesc = ardesc;
025212161103           savId = arid;
025213161027           step01 = lod;
025300161024         endif;
025400161024         panel = 1;
025500161024       endsr;
025600161024
025700161024       //--- Format 03 Subroutines ------------------------------------     ---
025800161024       begsr pnl03;
025900161024         select ;
026000161024         when step03 = prp ;
026100161024           exsr s03prp;
026200161024         when step03 = dsp ;
026300161024           exsr s03dsp;
026400161024         when step03 = key ;
026500161024           exsr s03key;
026600161024         when step03 = chk ;
026700161024           exsr s03chk;
026800161024         when step03 = act ;
026900161024           exsr s03act ;
027000161024         endsl;
027100161024
027200161024       endsr;
027300161024       //--- clear & Load ------------------------------------------------------
027400161024       begsr S03prp;
027401161027         exec sql set option commit = *none;
027500161024         exec sql select ARTICLE_INFORMATION into :text
027600161024                  FROM artiinf
027700161024                  WHERE ARTICLE_INFO_ID = :arid;
027701161027         if sqlcod <> 0;
027702161027           mode = crt;
027703161027           clear text;
027704161027         else;
027705161027           mode = upd;
027706161027         endif;
027800161024         step03 = dsp;
027900161024       endsr;
028000161024       //--- Display  ----------------------------------------------------------
028100161024       begsr S03dsp;
028200161024         exfmt fmt03;
028300161024         step03 = key;
028400161024       endsr;
028500161024       //--- command Keys  -----------------------------------------------------
028600161024       begsr S03key;
028700161024         select;
028800161024         when exit;
028900161024           panel  = 1;
029000161024           step03 = prp;
029100161024         when cancel;
029200161024           step03 = prp;
029300161024           panel  = 1;
029400161024         other;
029500161024           step03 = chk;
029600161024         endsl;
029700161024       endsr;
029800161024       //--- check -------------------------------------------------------------
029900161024       begsr S03chk;
030000161024         step03 = act;
030100161024       endsr;
030200161024       //--- Action ------------------------------------------------------------
030300161024       begsr S03act;
030400161024         step03 = prp;
030500161024         panel = 1;
030501161027         if mode = upd;
030600161027           exec sql update artiinf
030700161025                  set ARTICLE_INFORMATION = trim(:text)
030800161024                  WHERE ARTICLE_INFO_ID = :arid;
030801161027         else;
030802161027           exec sql insert into artiinf
030803161027                    Values(:arid, trim(:text));
030805161027         endif;
031000161024       endsr;
031100161024       //--------INITIALIZATION ----------------------------------
031200161024       begsr *inzsr;
031300161024       endsr;
031400161024       //--------END SUBROUTINE ----------------------------------
031500161024       begsr pnl00;
031600161024         *inlr = *on;
031700161024       endsr;
031800161103      /end-free
