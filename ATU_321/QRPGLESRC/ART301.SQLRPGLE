000100161128     h nomain
000200161128
000600161129     Fart301d   CF   E             WORKSTN
000700161128     F                                     INFDS(INFO)
000800161128     F                                     SFILE(SFL01:RRN01)
000900161128     F                                     indds(indds)
001000161128     D INFO            DS
001100161128     D  LRRN                 378    379B 0
001200161128
001300161129      /copy qprotosrc,article
001301161129      /copy qprotosrc,familly
001400161128
001500161128     D indds           ds
001600161128     D  help                   1      1n
001700161128     D  exit                   3      3n
001800161128     D  prompt                 4      4n
001900161128     D  refresh                5      5n
002000161128     D  create                 6      6n
002200161128     D  cancel                12     12n
002300161128     D  morekeys              24     24n
002400161128     D  pagedown              25     25n
002500161128     D  sflclr                30     30n
002600161128     D  sfldsp                31     31n
002700161128     D  sfldspctl             32     32n
002800161128     D  sflnxtchg             33     33n
002900161128     D  dspatrri              34     34n
003000161128     D  InvalidOpt            35     35n
003100161128     D  OneSelect             36     36n
003200161128     D  bydesc                40     40n
003300161128     D  InvalidOptC           41     41n
003400161128     D  NotAvail              42     42n
003500161128     D  sflend                80     80n
003501161129
003502161129     d  data           ds                  inz
003503161129     d   arid                         6
003504161129     d   ardesc                      50
003505161129     d   artifa                       3
003506161129     d   arsalePr                     7  2
003600161128
003700161128     D rrn01           s              5i 0
003800161128
003900161128     d prp             c                   'prp'
004000161128     d lod             c                   'lod'
004100161128     d dsp             c                   'dsp'
004200161128     d key             c                   'key'
004300161128     d chk             c                   'chk'
004600161128     d act             c                   'act'
004700161128
004800161128
004900161128      *=============================================
005000161129     P sltarticle      B                   export
005100161129     D sltarticle      PI             6
005200161129     d pcod                           6    value
005208161128
005209161128     d  savData        ds                  likeds(data)
005210161128
005300161129     D dft             S                   like(arid      )
005400161128     D step01          S              3    inz(prp)
005500161128     d in08            s               n
005600161128     d sts01           s               n
005700161128     D rrs01           s              5i 0
005800161128     D teller          s              5i 0
005900161128     D err01           s               n
006000161128     D slt01           s               n
006200161129     d savDesc         s             10
006500161129     d savFam          s                    like(artifa     )
006501161128     d stm             s            500     varying
006600161128      /free
006700161129       if not %open(art301d   );
006800161129         open art301d    ;
006900161128       endif;
007100161128       dft = pcod;
007101161129       famdesc = '<F4> to select.';
007300161128       dow step01 <> ' ';
007400161128         select ;
007500161128         when step01 = prp ;
007600161128           exsr s01prp;
007700161128         when step01 = lod ;
007800161128           exsr s01lod;
007900161128         when step01 = dsp ;
008000161128           exsr s01dsp;
008100161128         when step01 = key ;
008200161128           exsr s01key;
008300161128         when step01 = chk ;
008400161128           exsr s01chk;
008500161128         when step01 = act ;
008600161128           exsr s01act ;
008700161128         endsl;
008800161128       enddo;
008801161128       exec sql close c1;
008900161128       return dft;
009000161128       //--- Clear Subfile  -----------------------------------------------------
009100161128
009200161128       begsr s01prp;
009300161128         RRS01 = 0;
009500161128         sflclr = *on;
009600161128         sfldsp = *off;
009700161128         sfldspctl = *off;
009800161128         write CTL01;
009900161128         sflclr = *off;
009901161129         stm =  'SELECT arid, ardesc, artifa, arsalepr FROM article ';
009903161129         if srchDesc <> ' ' and srchFam <> ' ';
009904161129           stm +=  ' WHERE artifa = ''' + srchfam +
009905161129                   ''' AND UPPER(arDesc) like ''%' + %trim(srchDesc) +
009906161129                  '%'' ';
009907161129         elseif srchDesc <> ' ' ;
009908161129           stm += ' WHERE UPPER(arDesc) like ''%' + %trim(srchDesc) +
009909161129                  '%'' ';
009910161129         elseif srchFam <> ' ';
009911161129           stm +=  ' WHERE artifa = ''' + srchfam + ''' ';
009914161128         endif;
009915161129         stm += ' ORDER BY arDesc';
010900161129         SAVDesc = srchDesc;
011000161129         SAVFam  = srchFam ;
011100161128         Step01 = lod;
011101161128         exec sql prepare s1 from :stm;
011102161128         exec sql declare C1 cursor for s1;
011103161128         exec sql open c1;
011104161128         exec sql fetch c1 into :data;
011105161128         savData = data;
011200161128       endsr;
011300161128       //--- Load Subfile  -----------------------------------------------------
011400161128       begsr S01lod;
011500161128         RRN01 = RRS01;
011501161128         Data = Savdata;
011600161128         RRB01 = RRS01 + 1;
011700161128         TELLER = 0;
011800161128         OPT01 = 0;
011900161128         SflNxtChg = *OFF;
012200161128         dow sqlcod = 0
012300161129               and TELLER < 14;
012400161128           RRN01 = RRN01 + 1;
012500161128           TELLER = TELLER + 1;
012600161128           write SFL01;
012601161128           exec sql fetch c1 into :data;
013300161128         enddo;
013301161129         sflend = sqlcod <> 0;
013302161128         savData = data;
013600161128         RRS01 = RRN01;
013700161128         Step01 = dsp;
013800161128       endsr;
013900161128       //--- Display Subfile  --------------------------------------------------
014000161128       begsr S01dsp;
014100161128         sfldsp = rrs01 > 0;
014200161128         sfldspctl = *on;
014300161128         write KEY01;
014400161128         exfmt CTL01;
014600161128         RRB01 = LRRN;
014700161128         Step01 = key;
014800161128       endsr;
014900161128       //--- Command Keys  -----------------------------------------------------
015000161128       begsr S01key;
015100161128         select;
015200161128         when exit;
015300161128           step01 = ' ';
015400161128         when cancel ;
015500161128           Step01 = ' ';
015600161128         when PageDown;
015700161128           Step01 = lod;
015701161129         when prompt;
015702161129           srchfam = sltArtFam(SrchFam);
015703161129           famdesc = getArtFamDesc(SrchFam);
015704161129           exec sql close c1;
015705161129           step01 = prp;
015800161128         other;
015900161128           Step01 = chk;
016000161128         endsl;
016100161128       endsr;
016200161128       //--- Check Subfile  ----------------------------------------------------
016300161128       begsr S01chk;
016400161128         // SET FLAG SELECTION MADE OFF
016500161128         SLT01 = *OFF;
016600161128         // SET FLAG OPTION  MADE OFF
016700161128         STS01 = *OFF;
016800161128         // SET FLAG ERROR   MADE OFF
016900161128         ERR01 = *OFF;
017000161128         Step01 = act;
017100161128         readc(E) SFL01;
017200161128         SflNxtChg = *ON;
017300161128         dow not %error and not %eof;
017400161128           select;
017500161128           when OPT01 = 0;
017600161128             // NO ERROR
017700161128           when OPT01 <>1;
017800161128             STS01 = *ON;
017900161128             Step01 = dsp;
018000161128             dspatrRi = *on;
018100161128             InvalidOpt= *on;
018200161128             if ERR01 = *OFF;
018300161128               RRB01 = RRN01;
018400161128               ERR01 = *ON;
018500161128             endif;
018600161128             //OPTION = 1 BUT SELECTION ALREADY MADE
018700161128           when SLT01 = *ON;
018800161128             Step01 = dsp;
018900161128             dspatrRi = *on;
019000161128             OneSelect = *on;
019100161128             if ERR01 = *OFF;
019200161128               RRB01 = RRN01;
019300161128               ERR01 = *ON;
019400161128             endif;
019500161128           other;
019600161128             //OPTION = 1
019700161128             SLT01 = *ON;
019800161128             STS01 = *ON;
019900161128           endsl;
020000161128           update SFL01;
020100161128           dspatrRi = *off;
020200161128           readc SFL01;
020300161128         enddo;
021700161128       endsr;
021800161128       //--- Write Subfile  ----------------------------------------------------
021900161128       begsr S01act;
022000161128         Step01 = dsp;
022100161128         select;
022200161129         when savDesc <> srchDesc or savfam  <> srchfam ;
022300161128           Step01 = prp;
022301161128           exec sql close c1;
023700161128         other;
023800161128           readc(E) SFL01;
023900161128           dow not %error and not %eof;
024000161128             if OPT01 = 1;
024001161129               exec sql close c1;
024100161129               return arid      ;
024200161128             endif;
024300161128             readc SFL01;
024400161128           enddo;
024500161128         endsl;
024600161128       endsr;
024700161128      /end-free
024800161128
024900161129     p sltarticle      e
025000161128
025100161128
