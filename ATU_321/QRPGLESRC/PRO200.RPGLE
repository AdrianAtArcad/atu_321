000020161025
000100161025     fprovide1  uf a e           k disk
000200161025     fpro200d   cf   e             workstn
000300161025     F                                     indds(indds)
000400161025     F                                     sfile(sfl01:rrn01)
000500161025     F                                     Infds(Info)
000600161025
000601161025      /copy qprotosrc,country
000602161201
000603161104     d articles        pr                  extpgm('ART202')
000604161104     d  id                                 like(prid)
000605161104
000606161201     d prpord          pr                  extproc('PRO202')
000607161201     d  id                                 like(prid)
000608161201
000700161025     D indds           ds
000800161025     D  help                   1      1n
000900161025     D  exit                   3      3n
001000161025     D  prompt                 4      4n
001100161025     D  refresh                5      5n
001200161025     D  cancel                12     12n
001300161025     D  morekeys              24     24n
001400161025     D  pagedown              25     25n
001500161025     D  sflclr                30     30n
001600161025     D  sfldsp                31     31n
001700161025     D  sfldspctl             32     32n
001800161025     D  sflnxtchg             33     33n
001900161025     D  dspatr_ri             34     34n
002000161025     D  sflmsg                35     35n
002001161025     D  ErrCountry            40     40n
002002161025     D  ErrName               41     41n
002100161025     D  sflend                80     80n
002200161025
002300161025     D info            ds
002400161025     D  lrrn                 378    379i 0
002500161025
002600161025     D rrn01           s              5i 0
002700161025     D rrs01           s              5i 0
002800161025     D err01           s               n
002900161025
003000161025     D panel           S              3i 0 INZ(1)
003100161025     D step01          S              3    inz(prp)
003200161025     D step02          S              3    inz(prp)
003300161025     D step03          S              3    inz(prp)
003400161025     d savId           s                   like(prid)
003401161025     d User            s             10    inz(*user)
003500161025     d count           s              3i 0
003600161025     d mode            s              3
003700161025
003800161025     d crt             c                   'CRT'
003900161025     d upd             c                   'UPD'
004000161025     d prp             c                   'prp'
004100161025     d lod             c                   'lod'
004200161025     d dsp             c                   'dsp'
004300161025     d key             c                   'key'
004400161025     d chk             c                   'chk'
004700161025     d act             c                   'act'
004800161103      /free
004900161025       select;
005000161025       when panel = 1;
005100161025         exsr pnl01;
005200161025       when panel = 2;
005300161025         exsr pnl02;
005400161025       other;
005500161025         exsr pnl00;
005600161025       endsl;
005700161025       //- Subfiles  01 Subroutines --------------------------------------  ---
005800161025       begsr pnl01;
005900161025         select ;
006000161025         when step01 = prp ;
006100161025           exsr s01prp;
006200161025         when step01 = lod ;
006300161025           exsr s01lod;
006400161025         when step01 = dsp ;
006500161025           exsr s01dsp;
006600161025         when step01 = key ;
006700161025           exsr s01key;
006800161025         when step01 = chk ;
006900161025           exsr s01chk;
007000161025         when step01 = act ;
007100161025           exsr s01act ;
007200161025         endsl;
007300161025       endsr;
007400161025       //--- Clear Subfile  ----------------------------------------------------
007500161025       begsr s01prp;
007600161025         RRn01 = 0;
007700161025         sflclr = *on;
007800161025         write ctl01;
007900161025         sflclr = *off;
008000161025         step01 = lod;
008100161025         clear savid;
008200161025         rrs01 = 0;
008300161025       endsr;
008400161025       //--- Load Subfile  -----------------------------------------------------
008500161025       begsr s01lod;
008600161025         exsr s01rst;
008700161025         RRb01 = RRn01 + 1;
008800161025         opt01 = 0;
008900161025         count = 0;
009000161025         read(n) provide1;
009100161025         dow not %eof(provide1) and count < 14;
009200161025           RRN01 += 1;
009300161025           count += 1;
009400161025           write sfl01;
009500161025           read(n) provide1;
009600161025         enddo;
009700161025         sflend = %eof(provide1);
009800161025         step01 = dsp;
009900161025         exsr s01sav;
010000161025       endsr;
010100161025       //--- restore last read -------------------------------------------------
010200161025       begsr s01rst;
010300161025         setll savid  provide1;
010400161025         rrn01 = rrs01;
010500161025       endsr;
010600161025       //--- Save last read -------------------------------------------------
010700161025       begsr s01sav;
010800161025         savid = prid;
010900161025         rrs01 = rrn01;
011000161025       endsr;
011100161025       //--- Display Subfile  --------------------------------------------------
011200161025       begsr s01dsp;
011300161025         sfldspctl = *on;
011400161025         sfldsp = RRn01 > 0;
011500161025
011600161025         write key01;
011700161025         exfmt ctl01;
011800161025         if LRRN <>0;
011900161025           RRb01 = LRRN;
012000161025         endif;
012100161025         step01 = key;
012200161025       endsr;
012300161025       //--- Command Keys  -----------------------------------------------------
012400161025       begsr s01key;
012500161025         select;
012600161025         when exit;
012700161025           panel  = 0;
012800161025           step01 = prp;
012900161025         when cancel;
013000161025           step01 = prp;
013100161025           panel  = panel  - 1;
013200161025         when pagedown;
013300161025           step01 = lod;
013400161025         other;
013500161025           step01 = chk;
013600161025         endsl;
013700161025       endsr;
013800161025       //--- Check Subfile  ----------------------------------------------------
013900161025       begsr s01chk;
014000161025         step01 = act;
014100161025         err01 = *off;
014200161025         sflnxtchg = *on;
014300161025         readc(e) sfl01;
014400161025         dow not %error and not %eof;
014500161201           if opt01  <> 0 and opt01  <> 2 and opt01  <> 5 and opt01  <> 7;
014600161025             step01 = dsp;
014700161025             dspatr_ri = *on;
014800161025             sflmsg = *on;
014900161025             if not err01;
015000161025               rrb01 = rrn01;
015100161025               err01 = *on;
015200161025             endif;
015300161025           endif;
015400161025           update sfl01;
015500161025           dspatr_ri = *off;
015600161025           readc(e) sfl01;
015700161025         enddo;
015800161025         sflnxtchg = *off;
015900161025       endsr;
016000161025       //--- action Subfile  ---------------------------------------------------
016100161025       begsr s01act;
016200161025         readc(e) sfl01;
016300161025         select;
016400161025         when %error or %eof;
016500161025           step01 = dsp;
016600161025         when opt01 = 2;
016700161025           panel = 2;
016800161025           step02 = prp;
016900161025           opt01 = 0;
017000161025           update sfl01;
017001170511           // to remove the bug uncomment the following line
017002170511           // mode = upd;
017100161025         when opt01 = 5;
017200161104           articles(prid);
017400161025           opt01 = 0;
017500161025           update sfl01;
017501161201         when opt01 = 7;
017502161201           prpOrd(prid);
017503161201           opt01 = 0;
017504161201           update sfl01;
017600161025         other;
017700161025
017800161025         endsl;
017900161025       endsr;
018000161025
018100161025
018200161025       //--- Format 02 Subroutines ------------------------------------     ---
018300161025       begsr pnl02;
018400161025         select ;
018500161025         when step02 = prp ;
018600161025           exsr s02prp;
018700161025         when step02 = dsp ;
018800161025           exsr s02dsp;
018900161025         when step02 = key ;
019000161025           exsr s02key;
019100161025         when step02 = chk ;
019200161025           exsr s02chk;
019300161025         when step02 = act ;
019400161025           exsr s02act ;
019500161025         endsl;
019600161025
019700161025       endsr;
019800161025       //--- clear & Load ------------------------------------------------------
019900161025       begsr S02prp;
019901161025         chain prid provide1;
019902161025         coname = GetCountryName(prcoun);
020100161025         step02 = dsp;
020200161025       endsr;
020300161025       //--- Display  ----------------------------------------------------------
020400161025       begsr S02dsp;
020500161025         exfmt fmt02;
020600161025         step02 = key;
020700161025       endsr;
020800161025       //--- command Keys  -----------------------------------------------------
020900161025       begsr S02key;
021000161025         select;
021100161025         when exit;
021200161025           panel  = 1;
021300161025           step02 = prp;
021400161025         when cancel;
021500161025           step02 = prp;
021600161025           panel  = panel  - 1;
021601161025         when prompt;
021602161025           step02 = dsp;
021603161025           prcoun = SltCountry(prcoun);
021604161025           coname = GetCountryName(prcoun);
021700161025         other;
021800161025           step02 = chk;
021900161025         endsl;
022000161025       endsr;
022100161025       //--- check -------------------------------------------------------------
022200161025       begsr S02chk;
022300161025         step02 = act;
022400161025         if not ExistCountry(prcoun);
022401161025           errCountry = *on;
022600161025           step02 = dsp;
022700161025         endif;
022701161025         if provnm = *blanks;
022702161025           errName = *on;
022703161025           step02 = dsp;
022704161025         endif;
022800161025
022900161025       endsr;
023000161025       //--- Action ------------------------------------------------------------
023100161025       begsr S02act;
023200161025         step02 = prp;
023300161025         if mode = upd;
023301161025           prmod = %timestamp();
023302161025           prmodid = user;
023400161025           update fprov;
023500161025         endif;
023600161025         panel = 1;
023700161025       endsr;
023800161025
023900161025       //--------INITIALIZATION ----------------------------------
024000161025       begsr *inzsr;
024100161025       endsr;
024200161025       //--------END SUBROUTINE ----------------------------------
024300161025       begsr pnl00;
024400161025         *inlr = *on;
024500161025       endsr;
024600161103      /end-free
