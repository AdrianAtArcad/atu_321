000001170925      *       Before compilation
000100170925      *       ovrdbf tmpdetord detord
000101161129
000102161129     h dftactgrp(*no) bnddir('SAMPLE')
000103161129
000104161129
000105161128     forder     o    e             disk
000106161129     fdetord    o    e           k disk
000107161129     fTmpdetord uf a e           k disk    rename(fdeto:tmprec)
000200161128     ford100d   cf   e             workstn
000300161128     F                                     indds(indds)
000301161128     F                                     sfile(sfl01:rrn01)
000302161128     F                                     Infds(Info)
000303161128
000304161129      /copy qprotosrc,customer
000305161129      /copy qprotosrc,article
000306161129      /copy qprotosrc,vat
000307161129
000308161128     d  ord100         pr
000309161128     d   cuid                              options(*NOPASS)
000310161128     d                                     like(orcuid)
000311161128
000312161128     d  ord100         pi
000313161128     d   cuid                              options(*NOPASS)
000314161128     d                                     like(orcuid)
000315161129
000316161129     d Prtord          pr                  extpgm('ORD500')
000317161129     d  x                                  like(orid)
000318161128
000319161128     D info            ds
000320161128     D  lrrn                 378    379i 0
000321161128
000500161128     D indds           ds
000600161128     D  help                   1      1n
000700161128     D  exit                   3      3n
000800161128     D  prompt                 4      4n
000900161128     D  refresh                5      5n
000901161129     D  create                 6      6n
000902161129     D  confirm                8      8n
001000161128     D  cancel                12     12n
001100161128     D  morekeys              24     24n
001200161128     D  pagedown              25     25n
001201161129     D  change                27     27n
001300161128     D  sflclr                30     30n
001400161128     D  sfldsp                31     31n
001500161128     D  sfldspctl             32     32n
001600161128     D  sflnxtchg             33     33n
001700161128     D  dspatr_ri             34     34n
001800161128     D  sflmsg                35     35n
001801161129     D  sflmsg2               36     36n
001900161128     D  sflend                80     80n
002000161128
002010161129     d Ordno           s              6s 0 DTAARA('LASTORDNO')
002011161129
002100161128     D panel           S              3  0 INZ(1)
002200161128     D step01          S              3    inz(prp)
002202161129     D step02          S              3    inz(prp)
002203161128     D rrn01           s              5i 0
002206161129     D count           s              3  0
002207161128     D err01           s               n
002300161128
002400161128     d prp             c                   'prp'
002500161128     d lod             c                   'lod'
002600161128     d dsp             c                   'dsp'
002700161128     d key             c                   'key'
002800161128     d chk             c                   'chk'
003100161128     d act             c                   'act'
003200161129      /free
003300161129        select;
003400161129        when panel = 1;
003500161129          exsr pnl01;
003501161129        when panel = 2;
003502161129          exsr pnl02;
003600161129        other;
003700161129          exsr pnl00;
003800161129        endsl;
003801161129        //- Subfiles  01 Subroutines --------------------------------------  ---
003802161129        begsr pnl01;
003803161129          select ;
003804161129          when step01 = prp ;
003805161129            exsr s01prp;
003806161129          when step01 = lod ;
003807161129            exsr s01lod;
003808161129          when step01 = dsp ;
003809161129            exsr s01dsp;
003810161129          when step01 = key ;
003811161129            exsr s01key;
003812161129          when step01 = chk ;
003813161129            exsr s01chk;
003814161129          when step01 = act ;
003815161129            exsr s01act ;
003816161129          endsl;
003817161129        endsr;
003818161129        //--- Clear Subfile  ----------------------------------------------------
003819161129        begsr s01prp;
003831161129          RRn01 = 0;
003832161129          sflclr = *on;
003833161129          write ctl01;
003834161129          sflclr = *off;
003835161129          step01 = lod;
003836161201          tot = 0;
003837161201          totvat = 0;
003838161129        endsr;
003839161129        //--- Load Subfile  -----------------------------------------------------
003840161129        begsr s01lod;
003841161129          RRb01 = RRn01 + 1;
003842161129          opt01 = 0;
003843161129          setll *loval tmpdetord;
003844161129          read  tmpdetord;
003845161129          dow not %eof;
003846161201            tot += odtot;
003847161201            totvat += odtotvat;
003848161129            RRN01 = RRN01 + 1;
003849161129            artdesc = GetArtDesc(odarid);
003850161129            line = odline;
003851161129            write sfl01;
003852161129            read  tmpdetord;
003853161129          enddo;
003854161129          sflend = *on;
003855161129          step01 = dsp;
003856161129        endsr;
003857161129        //--- Display Subfile  --------------------------------------------------
003858161129        begsr s01dsp;
003859161129          sfldspctl = *on;
003860161129          sfldsp = RRn01 > 0;
003861161128
003862161129          write key01;
003863161129          exfmt ctl01;
003864161129          if LRRN <>0;
003865161129            RRb01 = LRRN;
003866161129          endif;
003867161129          step01 = key;
003868161129        endsr;
003869161129        //--- Command Keys  -----------------------------------------------------
003870161129        begsr s01key;
003871161129          select;
003872161129          when exit;
003873161129            panel  = 0;
003874161129            step01 = prp;
003875161129          when cancel;
003876161129            step01 = prp;
003877161129            panel  = panel  - 1;
003878161129          when refresh;
003879161129            step01 = prp;
003881161129          when create;
003882161129            panel = 2;
003883161129            step02 = prp;
003884161129          other;
003885161129            step01 = chk;
003886161129          endsl;
003887161129        endsr;
003888161129        //--- Check Subfile  ----------------------------------------------------
003889161129        begsr s01chk;
003890161129          step01 = act;
003891161129          err01 = *off;
003892161129          sflnxtchg = *on;
003893161129          readc(e) sfl01;
003894161129          dow not %error and not %eof;
003895161129            if opt01 <> 0 and opt01 <> 2 and opt01 <> 4;
003896161129              step01 = dsp;
003897161129              dspatr_ri = *on;
003898161129              sflmsg = *on;
003899161129              if not err01;
003900161129                rrb01 = rrn01;
003901161129                err01 = *on;
003902161129              endif;
003903161129            endif;
003904161201            if confirm and (opt01 = 2 or opt01 = 4) ;
003905161129              step01 = dsp;
003906161129              dspatr_ri = *on;
003907161129              sflmsg2 = *on;
003908161129              if not err01;
003909161129                rrb01 = rrn01;
003910161129                err01 = *on;
003911161129              endif;
003912161129            endif;
003913161129            update sfl01;
003914161129            dspatr_ri = *off;
003915161129            readc(e) sfl01;
003916161129          enddo;
003917161129          sflnxtchg = *off;
003918161129        endsr;
003919161129        //--- action Subfile  ---------------------------------------------------
003920161129        begsr s01act;
003921161129          if confirm;
003922161129            in *lock ordno;
003923161129            ordno += 1;
003924161129            out ordno;
003925161129            ORID = ordno;
003926161129            ORYEAR  = *year;
003927161129            ORDATE = %dec(%date():*iso);
003928161129            ORDATDEL = 0;
003929161129            ORDATCLO = 0;
003930161129            write forde;
003931161129            odorid = orid;
003932161129            setll *loval tmpdetord;
003933161129            read  tmpdetord;
003934161129            count = 0;
003935161129            dow not %eof;
003936161129              odorid = orid;
003937161129              count += 1;
003938161129              odline = count;
003939161129              write fdeto;
003940161129              read  tmpdetord;
003941161129            enddo;
003942161129            prtOrd(orid);
003943161129            exfmt fmt03;
003944161129            panel = 0;
003945161129            leavesr;
003946161129          ENDIF;
003947161129          readc(e) sfl01;
003948161129          select;
003949161129          when %error or %eof;
003950161129            step01 = dsp;
003951161129          when opt01 = 2;
003952161201            panel = 2;
003953161201            step02 = prp;
003954161129          when opt01 = 4;
003955161201            tot -= odtot;
003956161201            totvat -= odtotvat;
003957161201            delete (line) tmpdetord;
003958161201            opt01 = 0;
003959161201            odarid = ' ';
003960161201            odqty = 0;
003961161201            odprice = 0;
003962161201            odtot = 0;
003963161201            artdesc = '**** Delete ***';
003964161201            update sfl01;
003969161129          endsl;
003970161129        endsr;
003971161129        //--- Format 02 Subroutines ------------------------------------     ---
003972161129        begsr pnl02;
003973161129          select ;
003974161129          when step02 = prp ;
003975161129            exsr s02prp;
003976161129          when step02 = dsp ;
003977161129            exsr s02dsp;
003978161129          when step02 = key ;
003979161129            exsr s02key;
003980161129          when step02 = chk ;
003981161129            exsr s02chk;
003982161129          when step02 = act ;
003983161129            exsr s02act ;
003984161129          endsl;
003985161128
003986161129        endsr;
003987161129        //--- clear & Load ------------------------------------------------------
003988161129        begsr S02prp;
003989161129          if create;
003990161129            odarid = sltArticle(' ');
003991161129            if odarid = ' ';
003992161129              panel = 1;
003993161129              step02 = prp;
003994161129            ENDIF;
003995161129            odqty = 1;
003996161129            odprice = GetArtRefSalPrice(odarid);
003998161129            odtot =  odqty * odprice;
003999161129            count += 1;
004000161129            odline = count;
004001161129          else;
004002161129            chain (line) tmpDetord;
004003161129          ENDIF;
004004161129          artdesc = GetArtDesc(odarid);
004005161129          vat = CLCVat(GetArtVatCode(odarid):odtot);
004006161129          odtotvat = odtot + vat;
004007161129          vatRate = GetVatRate(GetArtVatCode(odarid));
004008161129          step02 = dsp;
004009161129        endsr;
004010161129        //--- Display  ----------------------------------------------------------
004011161129        begsr S02dsp;
004012161129          exfmt fmt02;
004013161129          step02 = key;
004014161129        endsr;
004015161129        //--- command Keys  -----------------------------------------------------
004016161129        begsr S02key;
004017161129          select;
004018161129          when exit;
004019161129            panel  = 1;
004020161129            step02 = prp;
004021161129          when cancel;
004022161129            step02 = prp;
004023161129            panel  = panel  - 1;
004024161129          other;
004025161129            step02 = chk;
004026161129          endsl;
004027161129        endsr;
004028161129        //--- check -------------------------------------------------------------
004029161129        begsr S02chk;
004030161129          step02 = act;
004031161129          odtot =  odqty * odprice;
004032161129          vat = CLCVat(GetArtVatCode(odarid):odtot);
004033161129          odtotvat = odtot + vat;
004034161129        endsr;
004035161129        //--- Action ------------------------------------------------------------
004036161129        begsr S02act;
004037161129          if change;
004038161129            step02 = dsp;
004039161129          else;
004040161129            if create;
004041161129              write tmprec;
004042161129              step01 = prp;
004043161129            else;
004044161129              update tmprec;
004045161129              opt01 = 0;
004046161129              update sfl01;
004047161129              step01 = dsp;
004048161129            ENDIF;
004051161129            panel = 1;
004052161129          endif;
004053161129        endsr;
004054161128
004055161128
004056161128
004057161129        //--------INITIALIZATION ----------------------------------
004058161129        begsr *inzsr;
004059161201          panel = 2;
004060170131          if %parms = 0 or cuid = 0;
004061161129            orcuid = SltCustomer(0);
004062161129            if orcuid = 0;
004063161129              panel = 0;
004064161129             endif;
004065161129           else;
004066161129             orcuid = cuid;
004067161129           endif;
004068161129           CUSTNAME = GetCusName(orcuid);
004069161129           create = *on;
004070161129           count = 0;
004100161129        endsr;
004200161129        //--------END SUBROUTINE ----------------------------------
004300161129        begsr pnl00;
004400161129          *inlr = *on;
004500161129        endsr;
004501161129      /end-free
004502161129
