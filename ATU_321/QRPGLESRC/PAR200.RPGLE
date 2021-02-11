000100161209
000200161209     fparameter uf a e           k disk
000300161209     fpar200d   cf   e             workstn
000400161209     F                                     indds(indds)
000500161209     F                                     sfile(sfl01:rrn01)
000600161209     F                                     Infds(Info)
000700161209
001600161209     D indds           ds
001700161209     D  help                   1      1n
001800161209     D  exit                   3      3n
001900161209     D  prompt                 4      4n
002000161209     D  refresh                5      5n
002001161209     D  create                 6      6n
002100161209     D  cancel                12     12n
002200161209     D  morekeys              24     24n
002300161209     D  pagedown              25     25n
002400161209     D  sflclr                30     30n
002500161209     D  sfldsp                31     31n
002600161209     D  sfldspctl             32     32n
002700161209     D  sflnxtchg             33     33n
002800161209     D  dspatr_ri             34     34n
002900161209     D  sflmsg                35     35n
003000161209     D  ErrDuplicate          40     40n
003200161209     D  sflend                80     80n
003300161209
003400161209     D info            ds
003500161209     D  lrrn                 378    379i 0
003600161209
003700161209     D rrn01           s              5i 0
003800161209     D rrs01           s              5i 0
003900161209     D err01           s               n
004000161209
004100161209     D panel           S              3i 0 INZ(1)
004200161209     D step01          S              3    inz(prp)
004300161209     D step02          S              3    inz(prp)
004400161209     D step03          S              3    inz(prp)
004500161209     d savId1          s                   like(pacode)
004501161209     d savId2          s                   like(pasubcode)
004600161209     d User            s             10    inz(*user)
004700161209     d count           s              3i 0
004800161209     d mode            s              3
004900161209
005200161209     d prp             c                   'prp'
005300161209     d lod             c                   'lod'
005400161209     d dsp             c                   'dsp'
005500161209     d key             c                   'key'
005600161209     d chk             c                   'chk'
005700161209     d act             c                   'act'
005800161209      /free
005900161209       select;
006000161209       when panel = 1;
006100161209         exsr pnl01;
006200161209       when panel = 2;
006300161209         exsr pnl02;
006301161209       when panel = 3;
006302161209         exsr pnl03;
006400161209       other;
006500161209         exsr pnl00;
006600161209       endsl;
006700161209       //- Subfiles  01 Subroutines --------------------------------------  ---
006800161209       begsr pnl01;
006900161209         select ;
007000161209         when step01 = prp ;
007100161209           exsr s01prp;
007200161209         when step01 = lod ;
007300161209           exsr s01lod;
007400161209         when step01 = dsp ;
007500161209           exsr s01dsp;
007600161209         when step01 = key ;
007700161209           exsr s01key;
007800161209         when step01 = chk ;
007900161209           exsr s01chk;
008000161209         when step01 = act ;
008100161209           exsr s01act ;
008200161209         endsl;
008300161209       endsr;
008400161209       //--- Clear Subfile  ----------------------------------------------------
008500161209       begsr s01prp;
008600161209         RRn01 = 0;
008700161209         sflclr = *on;
008800161209         write ctl01;
008900161209         sflclr = *off;
009000161209         step01 = lod;
009100161209         clear savid1;
009101161209         clear savid2;
009200161209         rrs01 = 0;
009300161209       endsr;
009400161209       //--- Load Subfile  -----------------------------------------------------
009500161209       begsr s01lod;
009600161209         exsr s01rst;
009700161209         RRb01 = RRn01 + 1;
009800161209         opt01 = 0;
009900161209         count = 0;
010000161209         read(n) parameter;
010100161209         dow not %eof(parameter) and count < 14;
010200161209           RRN01 += 1;
010300161209           count += 1;
010301161209           parm2s = parm2;
010400161209           write sfl01;
010500161209           read(n) parameter;
010600161209         enddo;
010700161209         sflend = %eof(parameter);
010800161209         step01 = dsp;
010900161209         exsr s01sav;
011000161209       endsr;
011100161209       //--- restore last read -------------------------------------------------
011200161209       begsr s01rst;
011300161209         setll (savid1:savid2)  parameter;
011400161209         rrn01 = rrs01;
011500161209       endsr;
011600161209       //--- Save last read -------------------------------------------------
011700161209       begsr s01sav;
011800161209         savid1 = pacode;
011801161209         savid2 = pasubcode;
011900161209         rrs01 = rrn01;
012000161209       endsr;
012100161209       //--- Display Subfile  --------------------------------------------------
012200161209       begsr s01dsp;
012300161209         sfldspctl = *on;
012400161209         sfldsp = RRn01 > 0;
012500161209
012600161209         write key01;
012700161209         exfmt ctl01;
012800161209         if LRRN <>0;
012900161209           RRb01 = LRRN;
013000161209         endif;
013100161209         step01 = key;
013200161209       endsr;
013300161209       //--- Command Keys  -----------------------------------------------------
013400161209       begsr s01key;
013500161209         select;
013600161209         when exit;
013700161209           panel  = 0;
013800161209           step01 = prp;
013900161209         when cancel;
014000161209           step01 = prp;
014100161209           panel  = panel  - 1;
014200161209         when pagedown;
014300161209           step01 = lod;
014301161209         when refresh;
014302161209           step01 = prp;
014303161209         when create;
014304161209           panel = 3;
014305161209           step01 = lod;
014400161209         other;
014500161209           step01 = chk;
014600161209         endsl;
014700161209       endsr;
014800161209       //--- Check Subfile  ----------------------------------------------------
014900161209       begsr s01chk;
015000161209         step01 = act;
015100161209         err01 = *off;
015200161209         sflnxtchg = *on;
015300161209         readc(e) sfl01;
015400161209         dow not %error and not %eof;
015500161209           if opt01  <> 0 and opt01  <> 2 and opt01  <> 4;
015600161209             step01 = dsp;
015700161209             dspatr_ri = *on;
015800161209             sflmsg = *on;
015900161209             if not err01;
016000161209               rrb01 = rrn01;
016100161209               err01 = *on;
016200161209             endif;
016300161209           endif;
016400161209           update sfl01;
016500161209           dspatr_ri = *off;
016600161209           readc(e) sfl01;
016700161209         enddo;
016800161209         sflnxtchg = *off;
016900161209       endsr;
017000161209       //--- action Subfile  ---------------------------------------------------
017100161209       begsr s01act;
017200161209         readc(e) sfl01;
017300161209         select;
017400161209         when %error or %eof;
017500161209           step01 = dsp;
017600161209         when opt01 = 2;
017700161209           panel = 2;
017800161209           step02 = prp;
017900161209           opt01 = 0;
018000161209           update sfl01;
018001161209         when opt01 = 4;
018002161209           delete (pacode:pasubcode) parameter;
018003161209           clear pacode;
018004161209           clear pasubcode;
018005161209           clear parm1;
018006161209           parm2 = '*** Deleted ****';
018007161209           opt01 = 0;
018008161209           update sfl01;
018900161209         other;
019000161209
019100161209         endsl;
019200161209       endsr;
019300161209
019301161209
019302161209       //--- Format 02 Subroutines ------------------------------------     ---
019303161209       begsr pnl02;
019304161209         select ;
019305161209         when step02 = prp ;
019306161209           exsr s02prp;
019307161209         when step02 = dsp ;
019308161209           exsr s02dsp;
019309161209         when step02 = key ;
019310161209           exsr s02key;
019311161209         when step02 = chk ;
019312161209           exsr s02chk;
019313161209         when step02 = act ;
019314161209           exsr s02act ;
019315161209         endsl;
019316161209
019317161209       endsr;
019318161209       //--- clear & Load ------------------------------------------------------
019319161209       begsr S02prp;
019320161209         chain (pacode:pasubcode) parameter;
019321161209         step02 = dsp;
019322161209       endsr;
019323161209       //--- Display  ----------------------------------------------------------
019324161209       begsr S02dsp;
019325161209         exfmt fmt02;
019326161209         step02 = key;
019327161209       endsr;
019328161209       //--- command Keys  -----------------------------------------------------
019329161209       begsr S02key;
019330161209         select;
019331161209         when exit;
019332161209           panel  = 1;
019333161209           step02 = prp;
019334161209         when cancel;
019335161209           step02 = prp;
019336161209           panel  = panel  - 1;
019337161209         other;
019338161209           step02 = chk;
019339161209         endsl;
019340161209       endsr;
019341161209       //--- check -------------------------------------------------------------
019342161209       begsr S02chk;
019343161209         step02 = act;
019344161209
019345161209       endsr;
019346161209       //--- Action ------------------------------------------------------------
019347161209       begsr S02act;
019348161209         step02 = prp;
019349161209         update fparam;
019350161209         panel = 1;
019351161209       endsr;
019352161209
019400161209
019500161209       //--- Format 03 Subroutines ------------------------------------     ---
019600161209       begsr pnl03;
019700161209         select ;
019800161209         when step03 = prp ;
019900161209           exsr s03prp;
020000161209         when step03 = dsp ;
020100161209           exsr s03dsp;
020200161209         when step03 = key ;
020300161209           exsr s03key;
020400161209         when step03 = chk ;
020500161209           exsr s03chk;
020600161209         when step03 = act ;
020700161209           exsr s03act ;
020800161209         endsl;
020900161209
021000161209       endsr;
021100161209       //--- clear & Load ------------------------------------------------------
021200161209       begsr S03prp;
021300161209         clear fmt03;
021500161209         step03 = dsp;
021600161209       endsr;
021700161209       //--- Display  ----------------------------------------------------------
021800161209       begsr S03dsp;
021900161209         exfmt fmt03;
022000161209         step03 = key;
022100161209       endsr;
022200161209       //--- command Keys  -----------------------------------------------------
022300161209       begsr S03key;
022400161209         select;
022500161209         when exit;
022600161209           panel  = 1;
022700161209           step03 = prp;
022800161209         when cancel;
022900161209           step03 = prp;
023000161209           panel  = 1;
023500161209         other;
023600161209           step03 = chk;
023700161209         endsl;
023800161209       endsr;
023900161209       //--- check -------------------------------------------------------------
024000161209       begsr S03chk;
024100161209         step03 = act;
024101161209         chain (pacode:pasubcode) parameter;
024102161209         if %found();
024103161209           ErrDuplicate = *on;
024104161209           step03 = dsp;
024105161209         endif;
025000161209
025100161209       endsr;
025200161209       //--- Action ------------------------------------------------------------
025300161209       begsr S03act;
025400161209         step03 = prp;
025800161209         write fparam;
026000161209         panel = 1;
026100161209       endsr;
026200161209
026300161209       //--------INITIALIZATION ----------------------------------
026400161209       begsr *inzsr;
026500161209       endsr;
026600161209       //--------END SUBROUTINE ----------------------------------
026700161209       begsr pnl00;
026800161209         *inlr = *on;
026900161209       endsr;
027000161209      /end-free
