000100161025
000401161201     fprovide1  if   e           k disk
000500161201     fpro202d   cf   e             workstn
000600161024     F                                     indds(indds)
000700161024     F                                     sfile(sfl01:rrn01)
000800161024     F                                     Infds(Info)
000801161201
000802161201      /copy qprotosrc,xml
000803161209      /copy qprotosrc,parameter
000804161201
000805161201     d pro202          pr
000806161201     d  id                                 like(prid)
000807161201     d pro202          pi
000808161201     d  id                                 like(prid)
001115161129
001200161024     D indds           ds
001300161024     D  help                   1      1n
001400161024     D  exit                   3      3n
001500161024     D  prompt                 4      4n
001600161024     D  refresh                5      5n
001601161201     D  confirm                8      8n
001700161024     D  cancel                12     12n
001800161024     D  morekeys              24     24n
001900161024     D  pagedown              25     25n
002000161024     D  sflclr                30     30n
002100161024     D  sfldsp                31     31n
002200161024     D  sfldspctl             32     32n
002300161024     D  sflnxtchg             33     33n
002400161024     D  dspatr_ri             34     34n
002500161024     D  sflmsg                35     35n
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
004300161024     d mode            s              3
004400161024
004700161024     d prp             c                   'prp'
004800161024     d lod             c                   'lod'
004900161024     d dsp             c                   'dsp'
005000161024     d key             c                   'key'
005100161024     d chk             c                   'chk'
005400161024     d act             c                   'act'
005401161201
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
008801161201         exec sql declare c2 cursor for
008802161201           SELECT ARID, ARDESC, arstock, ARMINQTY,
008803161201                  ARCUSQTY, ARPURQTY, APPRICE, apref
008804161201           FROM article, artiprov
008805161201           WHERE arstock < ARMINQTY - arcusqty + arpurqty
008806161201             and arid = aparid
008807161201             AND apprid = :id
008808161201           order by arid ;
008809161201         exec sql open c2;
008900161024         step01 = lod;
008901161027         rrs01 = 0;
009200161024       endsr;
009300161024       //--- Load Subfile  -----------------------------------------------------
009400161024       begsr s01lod;
009401161027         rrn01 = rrs01;
009600161024         RRb01 = RRn01 + 1;
009702161201         exec sql fetch c2 into :arid, :ardesc, :arstock, :arminqty,
009703161201                                :ARCUSQTY, :ARPURQTY, :APPRICE, :APREF;
010000161201         dow sqlcod = 0;
010001161201           neword = ARMINQTY + ARCUSQTY - arpurqty - arstock;
010002161201           name25 = ardesc;
010100161201           RRN01 += 1;
010300161201           write sfl01;
010302161201           exec sql fetch c2 into :arid, :ardesc, :arstock, :arminqty,
010303161201                                :ARCUSQTY, :ARPURQTY, :APPRICE, :APREF;
010500161024         enddo;
010600161201         sflend = *on;
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
014001161027         when pagedown;
014002161027           step01 = lod;
014300161024         other;
014400161024           step01 = chk;
014500161024         endsl;
014600161024       endsr;
014700161024       //--- Check Subfile  ----------------------------------------------------
014800161024       begsr s01chk;
014900161024         step01 = act;
016800161024       endsr;
016900161024       //--- action Subfile  ---------------------------------------------------
017000161024       begsr s01act;
017100161201         if confirm;
017101161201           fileName = 'Pur_Ord_' + %trim(%char(prid)) + '_' +
017102161201                      %char(%dec(%date:*YMD)) + '.xml';
017103161209           path = getParm2('PATH':' ');
017105161201           xmlopen(%trim(path) + fileName);
017106161201           xmlStrTable('PURODR');
017107161201           XmlStrRec('Customer');
017108161201           xmladdcol('NAME':'SAMPLE Company');
017109161201           xmladdcol('ADDRES':'55, rue Adrastee');
017110161201           xmladdcol('ZIPCODE':'F-74650');
017111161201           xmladdcol('CITY':'Chavanod');
017112161201           xmlendrec('Customer');
017113161201           rrn01 = 1;
017114161201           chain rrn01 sfl01;
017115161201           dow %found();
017116161201             xmlstrRec('Item');
017117161201             xmladdcol('ID':arid);
017118161201             xmladdcol('YOUR_REF':apref);
017119161201             xmladdcol('DESC':ardesc);
017120161201             xmladdcol('QTY':%char(neword));
017121161201             xmladdcol('UnitPrice':%editc(apprice:'2'));
017139161201             XmlEndRec('Item');
017140161201             rrn01 += 1;
017142161201             chain rrn01 sfl01;
017143161201           ENDDO;
017144161201           xmlEndTable('PURODR');
017145161201           xmlclose();
017146161201           exfmt fmt03;
017147161201           panel = 0;
017148161201         else;
017149161201           step01 = dsp;
017150161201         endif;
017151161201
018800161024       endsr;
018900161024
025700161025       //--------INITIALIZATION ----------------------------------
025800161025       begsr *inzsr;
025801161201         chain prid provide1;
025900161025       endsr;
026000161025       //--------END SUBROUTINE ----------------------------------
026100161025       begsr pnl00;
026101161201         exec sql close c2;
026200161025         *inlr = *on;
026300161025       endsr;
026400161103      /end-free
