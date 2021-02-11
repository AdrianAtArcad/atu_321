000100161025     h nomain
000200161025
000300161025     Fcountry   IF   E           K DISK
000400161025     Fcountr1   IF   E           K DISK
000500161025     F                                     RENAME(fcoun   :REC52)
000600161025     Fcou301d   CF   E             WORKSTN
000700161025     F                                     INFDS(INFO)
000800161025     F                                     SFILE(SFL01:RRN01)
000900161025     F                                     indds(indds)
001000161025     D INFO            DS
001100161025     D  LRRN                 378    379B 0
001200161025
001300161025      /copy qprotosrc,country
001400161025
001500161025     D indds           ds
001600161025     D  help                   1      1n
001700161025     D  exit                   3      3n
001800161025     D  prompt                 4      4n
001900161025     D  refresh                5      5n
002000161025     D  create                 6      6n
002100161025     D  cf08                   8      8n
002200161025     D  cancel                12     12n
002300161025     D  morekeys              24     24n
002400161025     D  pagedown              25     25n
002500161025     D  sflclr                30     30n
002600161025     D  sfldsp                31     31n
002700161025     D  sfldspctl             32     32n
002800161025     D  sflnxtchg             33     33n
002900161025     D  dspatrri              34     34n
003000161025     D  InvalidOpt            35     35n
003100161025     D  OneSelect             36     36n
003200161025     D  bydesc                40     40n
003300161025     D  InvalidOptC           41     41n
003400161025     D  NotAvail              42     42n
003500161025     D  sflend                80     80n
003600161025
003700161025     D rrn01           s              5i 0
003800161025
003900161025     d prp             c                   'prp'
004000161025     d lod             c                   'lod'
004100161025     d dsp             c                   'dsp'
004200161025     d key             c                   'key'
004300161025     d chk             c                   'chk'
004400161025     d chkctl          c                   'chc'
004500161025     d actctl          c                   'acc'
004600161025     d act             c                   'act'
004700161025
004800161025
004900161025      *=============================================
005000161025     P sltcountry      B                   export
005100161025     D sltcountry      PI                  like(coid      )
005200161025     d pcod                                like(coid      )
005300161025     D dft             S                   like(coid      )
005400161025     D step01          S              3    inz(prp)
005500161025     d in08            s               n
005600161025     d sts01           s               n
005700161025     D rrs01           s              5i 0
005800161025     D teller          s              5i 0
005900161025     D err01           s               n
006000161025     D slt01           s               n
006100161025     d keycod          s                    like(coid       )
006200161025     d savcod          s                    like(coid       )
006300161025     d pdes            s                    like(countr     )
006400161025     d keydes          s                    like(countr     )
006500161025     d savdes          s                    like(countr     )
006600161103      /free
006700161025       if not %open(cou301d   );
006800161025         open cou301d    ;
006900161025       endif;
007000161025       keycod = pcod;
007001161025       dft = pcod;
007100161025       bydesc = *off;
007200161025       dow step01 <> ' ';
007300161025         select ;
007400161025         when step01 = prp ;
007500161025           exsr s01prp;
007600161025         when step01 = lod ;
007700161025           exsr s01lod;
007800161025         when step01 = dsp ;
007900161025           exsr s01dsp;
008000161025         when step01 = key ;
008100161025           exsr s01key;
008200161025         when step01 = chk ;
008300161025           exsr s01chk;
008400161025         when step01 = act ;
008500161025           exsr s01act ;
008600161025         endsl;
008700161025       enddo;
008800161025       return dft;
008900161103       //--- Clear Subfile  -----------------------------------------------------
009000161025
009100161025       begsr s01prp;
009200161025         RRS01 = 0;
009300161025         clear CTL01;
009400161025         sflclr = *on;
009500161025         sfldsp = *off;
009600161025         sfldspctl = *off;
009700161025         write CTL01;
009800161025         sflclr = *off;
009900161025         if not bydesc;
010000161025           setll KEYCOD country   ;
010100161025           read country;
010200161025           sflend = %EOF;
010300161025         else;
010400161025           setll KEYDES countr1   ;
010500161025           read countr1    ;
010600161025           SflEnd = %EOF;
010700161025         endif;
010800161025         SAVCOD = coid  ;
010900161025         SAVDES = countr;
011000161025         Step01 = lod;
011100161025       endsr;
011200161025       //--- Load Subfile  -----------------------------------------------------
011300161025       begsr S01lod;
011400161025         RRN01 = RRS01;
011500161025         RRB01 = RRS01 + 1;
011600161025         TELLER = 0;
011700161025         OPT01 = 0;
011800161025         SflNxtChg = *OFF;
011900161025         coid   = SAVCOD;
012000161025         countr = SAVDES;
012100161025         dow not sflend
012200161025               and TELLER < 20;
012300161025           RRN01 = RRN01 + 1;
012400161025           TELLER = TELLER + 1;
012500161025           write SFL01;
012600161025           if not bydesc;
012700161025             read country   ;
012800161025           else;
012900161025             read countr1   ;
013000161025           endif;
013100161025           SflEnd = %EOF;
013200161025         enddo;
013300161025         SAVCOD = coid  ;
013400161025         SAVDES = countr;
013500161025         RRS01 = RRN01;
013600161025         Step01 = dsp;
013700161025       endsr;
013800161025       //--- Display Subfile  --------------------------------------------------
013900161025       begsr S01dsp;
014000161025         sfldsp = rrs01 > 0;
014100161025         sfldspctl = *on;
014200161025         write KEY01;
014300161025         exfmt CTL01;
014400161025         IN08 = CF08;
014500161025         RRB01 = LRRN;
014600161025         Step01 = key;
014700161025       endsr;
014800161025       //--- Command Keys  -----------------------------------------------------
014900161025       begsr S01key;
015000161025         select;
015100161025         when exit;
015200161025           step01 = ' ';
015300161025         when cancel ;
015400161025           Step01 = ' ';
015500161025         when PageDown;
015600161025           Step01 = lod;
015700161025         other;
015800161025           Step01 = chk;
015900161025         endsl;
016000161025       endsr;
016100161025       //--- Check Subfile  ----------------------------------------------------
016200161025       begsr S01chk;
016300161025         // SET FLAG SELECTION MADE OFF
016400161025         SLT01 = *OFF;
016500161025         // SET FLAG OPTION  MADE OFF
016600161025         STS01 = *OFF;
016700161025         // SET FLAG ERROR   MADE OFF
016800161025         ERR01 = *OFF;
016900161025         Step01 = act;
017000161025         readc(E) SFL01;
017100161025         SflNxtChg = *ON;
017200161025         dow not %error and not %eof;
017300161025           select;
017400161025           when OPT01 = 0;
017500161025             // NO ERROR
017600161025           when OPT01 <>1;
017700161025             STS01 = *ON;
017800161025             Step01 = dsp;
017900161025             dspatrRi = *on;
018000161025             InvalidOpt= *on;
018100161025             if ERR01 = *OFF;
018200161025               RRB01 = RRN01;
018300161025               ERR01 = *ON;
018400161025             endif;
018500161025             //OPTION = 1 BUT SELECTION ALREADY MADE
018600161025           when SLT01 = *ON;
018700161025             Step01 = dsp;
018800161025             dspatrRi = *on;
018900161025             OneSelect = *on;
019000161025             if ERR01 = *OFF;
019100161025               RRB01 = RRN01;
019200161025               ERR01 = *ON;
019300161025             endif;
019400161025           other;
019500161025             //OPTION = 1
019600161025             SLT01 = *ON;
019700161025             STS01 = *ON;
019800161025           endsl;
019900161025           update SFL01;
020000161025           dspatrRi = *off;
020100161025           readc SFL01;
020200161025         enddo;
020300161025         select;
020400161025         when OPTC1 <>8
020500161025               and OPTC1 <>0;
020600161025           InvalidOptC = *ON;
020700161025           Step01 = dsp;
020800161025         when SLT01 = *ON
020900161025               and OPTC1 <>0;
021000161025           NotAvail = *ON;
021100161025           Step01 = dsp;
021200161025         when STS01 = *ON
021300161025               and IN08 = *ON;
021400161025           Step01 = dsp;
021500161025         endsl;
021600161025       endsr;
021700161025       //--- Write Subfile  ----------------------------------------------------
021800161025       begsr S01act;
021900161025         Step01 = dsp;
022000161025         select;
022100161025         when IN08 ;
022200161025           Step01 = prp;
022300161025           bydesc = not bydesc;
022400161025           if bydesc;
022500161025             clear KEYdes;
022600161025           else;
022700161025             clear KEYcod;
022800161025           endif;
022900161025         when OPTC1 = 8;
023000161025           Step01 = prp;
023100161025           if not bydesc;
023200161025             KEYCOD = POSCOD;
023300161025           else;
023400161025             KEYDES = POSDES;
023500161025           endif;
023600161025         other;
023700161025           readc(E) SFL01;
023800161025           dow not %error and not %eof;
023900161025             if OPT01 = 1;
024000161025               return coid      ;
024100161025             endif;
024200161025             readc SFL01;
024300161025           enddo;
024400161025         endsl;
024500161025       endsr;
024501161103      /end-free
024600161025
024700161025     p sltcountry      e
024800161025
024900161025
