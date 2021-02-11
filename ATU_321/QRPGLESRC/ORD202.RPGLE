000100161103
000200161103     h dftactgrp(*no) bnddir('SAMPLE')
000300161103
000500161103     fcustome1  if   e           k disk
000600161103     farticle1  if   e           k disk
000700161103     fdetord1   if   e           k disk
000701161103     forder1    if   e           k disk
000800161103     ford202d   cf   e             workstn
000900161103     F                                     indds(indds)
001000161103     F                                     sfile(sfl01:rrn01)
001100161103     F                                     Infds(Info)
001200161103
001201161103     d ord202          pr
001202161103     d  id                                 like(orid)
001203161103     d ord202          pi
001204161103     d  id                                 like(orid)
001600161103     D indds           ds
001700161103     D  help                   1      1n
001800161103     D  exit                   3      3n
001900161103     D  prompt                 4      4n
002000161103     D  refresh                5      5n
002100161103     D  create                 6      6n
002200161103     D  cancel                12     12n
002300161103     D  morekeys              24     24n
002400161103     D  pagedown              25     25n
002500161103     D  sflclr                30     30n
002600161103     D  sfldsp                31     31n
002700161103     D  sfldspctl             32     32n
002800161103     D  sflnxtchg             33     33n
002900161103     D  dspatr_ri             34     34n
003000161103     D  sflmsg                35     35n
003100161103     D  sflend                80     80n
003200161103
003300161103     D info            ds
003400161103     D  lrrn                 378    379i 0
003500161103
003600161103     D rrn01           s              5i 0
003700161103     D rrs01           s              5i 0
003800161103     D err01           s               n
003900161103
004000161103     D panel           S              3i 0 INZ(1)
004100161103     D step01          S              3    inz(prp)
004200161103     d User            s             10    inz(*user)
004300161103     d count           s              3i 0
004400161103     d mode            s              3
004500161103
004600161103     d crt             c                   'CRT'
004700161103     d upd             c                   'UPD'
004800161103     d prp             c                   'prp'
004900161103     d lod             c                   'lod'
005000161103     d dsp             c                   'dsp'
005100161103     d key             c                   'key'
005200161103     d chk             c                   'chk'
005300161103     d act             c                   'act'
005400161103     d datBlank        c                   d'1940-01-01'
005500161103      /free
005600161103       select;
005700161103       when panel = 1;
005800161103         exsr pnl01;
005900161103       other;
006000161103         exsr pnl00;
006100161103       endsl;
006200161103       //- Subfiles  01 Subroutines --------------------------------------  ---
006300161103       begsr pnl01;
006400161103         select ;
006500161103         when step01 = prp ;
006600161103           exsr s01prp;
006700161103         when step01 = lod ;
006800161103           exsr s01lod;
006900161103         when step01 = dsp ;
007000161103           exsr s01dsp;
007100161103         when step01 = key ;
007200161103           exsr s01key;
007500161103         when step01 = act ;
007600161103           exsr s01act ;
007700161103         endsl;
007800161103       endsr;
007900161103       //--- Clear Subfile  ----------------------------------------------------
008000161103       begsr s01prp;
008001161103         chain id order1;
008002161103         chain orcuid custome1;
008003161103         datord = %date(ordate:*iso);
008004161103         if ordatdel > 0;
008005161103           datliv = %date(ordatdel:*iso);
008006161103         endif;
008007161103         if ordatclo > 0;
008008161103           datclo = %date(ordatclo:*iso);
008009161103         endif;
008100161103         RRn01 = 0;
008200161103         sflclr = *on;
008300161103         write ctl01;
008400161103         sflclr = *off;
009100161103         step01 = lod;
009300161103       endsr;
009400161103       //--- Load Subfile  -----------------------------------------------------
009500161103       begsr s01lod;
009700161103         RRb01 = RRn01 + 1;
009701161201         tot = 0;
009702161201         totvat = 0;
009901161103         setll id detord1;
009902161103         reade id detord1;
010000161103         dow not %eof(detord1);
010001161201           tot += odtot;
010002161201           totvat += odtotvat;
010003161103           chain odarid article1;
010500161103           RRN01 += 1;
010700161103           write sfl01;
010701161103           reade id detord1;
010900161103         enddo;
010901161201         sflend = *on;
011100161103         step01 = dsp;
011300161103       endsr;
011400161103       //--- Display Subfile  --------------------------------------------------
011500161103       begsr s01dsp;
011600161103         sfldspctl = *on;
011700161103         sfldsp = RRn01 > 0;
011800161103
011900161103         write key01;
012000161103         exfmt ctl01;
012100161103         if LRRN <>0;
012200161103           RRb01 = LRRN;
012300161103         endif;
012400161103         step01 = key;
012500161103       endsr;
012600161103       //--- Command Keys  -----------------------------------------------------
012700161103       begsr s01key;
012800161103         select;
012900161103         when exit;
013000161103           panel  = 0;
013100161103           step01 = prp;
013200161103         when cancel;
013300161103           step01 = prp;
013400161103           panel  = 0 ;
013700161103         other;
013800161103           step01 = act;
013900161103         endsl;
014000161103       endsr;
016300161103       //--- action Subfile  ---------------------------------------------------
016400161103       begsr s01act;
016401161103         panel = 0;
017900161103       endsr;
018000161103
018100161103       //--------INITIALIZATION ----------------------------------
018200161103       begsr *inzsr;
018300161103         datord = datBlank;
018400161103         datclo = datBlank;
018500161103         datliv = datBlank;
018600161103       endsr;
018700161103       //--------END SUBROUTINE ----------------------------------
018800161103       begsr pnl00;
019000161103         *inlr = *on;
019100161103       endsr;
019200161103      /end-free
