000100161025
000200161025     h dftactgrp(*no) bnddir('SAMPLE')
000300161025
000400161104     fartiprov  uf a e           k disk
000500161104     fart202d   cf   e             workstn
000600161024     F                                     indds(indds)
000700161024     F                                     sfile(sfl01:rrn01)
000800161024     F                                     Infds(Info)
000900161024
001000161025      /copy qprotosrc,provider
001001161025      /copy qprotosrc,article
001100161025
001101161104     d art202          pr
001102161104     d  prid                               like(apprid)
001103161025
001104161104     d art202          pi
001105161104     d  prid                               like(apprid)
001106161025
001200161024     D indds           ds
001300161024     D  help                   1      1n
001400161024     D  exit                   3      3n
001500161024     D  prompt                 4      4n
001600161024     D  refresh                5      5n
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
004100161104     d savId           s                   like(prid)
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
005200161024     d chkctl          c                   'chc'
005300161024     d actctl          c                   'acc'
005400161024     d act             c                   'act'
005500161103      /free
005600161024       select;
005700161024       when panel = 1;
005800161024         exsr pnl01;
005900161024       when panel = 2;
006000161024         exsr pnl02;
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
008801161104         provnm = GetProName(prid);
008900161024         step01 = lod;
009200161024       endsr;
009300161024       //--- Load Subfile  -----------------------------------------------------
009400161024       begsr s01lod;
009600161024         RRb01 = RRn01 + 1;
009700161024         opt01 = 0;
009801161104         setll prid artiprov;
009900161104         reade(n) prid artiprov;
010000161104         dow not %eof(artiprov);
010002161104           ardesc = GetArtDesc(aparid);
010100161024           RRN01 += 1;
010300161024           write sfl01;
010301161104           reade(n) prid artiprov;
010500161024         enddo;
010600161025         sflend = *on ;
010700161024         step01 = dsp;
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
015400161025           if opt01 <> 0 and opt01 <> 2;
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
017400161024           step01 = dsp;
017500161024         when opt01 = 2;
017600161024           panel = 2;
017700161024           step02 = prp;
017800161024           opt01 = 0;
017900161024           update sfl01;
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
020900161104         chain (prid: aparid) artiprov;
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
023100161024         other;
023200161024           step02 = chk;
023300161024         endsl;
023400161024       endsr;
023500161024       //--- check -------------------------------------------------------------
023600161024       begsr S02chk;
023700161024         step02 = act;
024600161024
024700161024       endsr;
024800161024       //--- Action ------------------------------------------------------------
024900161024       begsr S02act;
025000161024         step02 = prp;
025100161024         if mode = upd;
025101161025           apmod = %timestamp();
025102161025           apmodid = user;
025200161025           update farpr;
025300161024         endif;
025400161024         panel = 1;
025500161024       endsr;
025600161024
025700161025       //--------INITIALIZATION ----------------------------------
025800161025       begsr *inzsr;
025900161025       endsr;
026000161025       //--------END SUBROUTINE ----------------------------------
026100161025       begsr pnl00;
026200161025         *inlr = *on;
026300161025       endsr;
026400161103      /end-free
