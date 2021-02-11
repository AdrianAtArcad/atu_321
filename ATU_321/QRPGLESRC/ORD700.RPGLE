000022161130     H dftactgrp(*no)
000023161130
000024161130     Farticle1  UF   E           K DISK
000025161130
000026161216      /copy qprotosrc,log
000027161216
000028161130     d UpdArt          pr
000029161130     d   qty                          5  0 value
000030161130     d   id                                like(new.ODARID)
000031161130
000032161130     D PARM1           DS
000033161130      * Physical file name
000034161130     D  FNAME                        10
000035161130      * Physical file library
000036161130     D  LNAME                        10
000037161130      * Member name
000038161130     D  MNAME                        10
000039161130      * Trigger event 1=Ins, 2=Del, 3=Upd
000040161130     D  TEVEN                         1
000041161130      * Trigger time  1=After, 2=Before
000042161130     D  TTIME                         1
000043161130      * Commit lock level
000044161130     D  CMTLCK                        1
000045161130      * Reserved
000046161130     D                                3
000047161130      * CCSID
000048161130     D  CCSID                        10i 0
000049161130      * Reserved
000050161130     D                                8
000051161130      * Offset to the original record
000052161130     D  OLDOFF                       10i 0
000053161130      * length of the original record
000054161130     D  OLDLEN                       10i 0
000055161130      * Offset to the original record null byte map
000056161130     D  ONOFF                        10i 0
000057161130      * length of the null byte map
000058161130     D  ONLEN                        10i 0
000059161130      * Offset to the new record
000060161130     D  NEWOFF                       10i 0
000061161130      * length of the new record
000062161130     D  NEWLEN                       10i 0
000063161130      * Offset to the new record null byte map
000064161130     D  NNOFF                        10i 0
000065161130      * length of the null byte map
000066161130     D  NNLEN                        10i 0
000067161130
000068161130      * Trigger Buffer Length
000069161130     D  parm2          s             10i 0
000070161130
000071161130      * Record to be inserted or new values
000072161130     D NEW           E DS                  EXTNAME(detord)
000073161130     D                                     qualified
000074161130     D                                     based(pn)
000075161130
000076161130      * Record to be deleted or old values
000077161130     D OLD           E DS                  EXTNAME(detord)
000078161130     D                                     qualified
000079161130     D                                     based(po)
000080161130
000081161130      * SET UP THE ENTRY PARAMETER LIST.
000082161130
000083161130     C     *ENTRY        PLIST
000084161130     C                   PARM                    PARM1
000085161130     C                   PARM                    PARM2
000086161130     C                   if                      %parms = 0
000087161130     C                   seton                                        lr
000088161130     C                   return
000089161130     C                   ENDIF
000090161130     C                   select
000091161130     c                   when      teven = '1'
000092161130     c                   eval      pn = %addr(parm1) + newoff
000093161130     c                   callp     UpdArt(new.odqty:new.odarid)
000094161130     c                   when      teven = '2'
000095161130     c                   eval      po = %addr(parm1) + oldoff
000096161216     c                   callp(e)  addlogEntry('ORD700:Order Line deleted ' +
000097161216     c                             %char(Old.odorid) + ' ' + %char(Old.odline)
000098161216     c                              + ' article : ' + old.odarid
000099161216     c                              + ' quantity : ' + %char(old.odqty))
000100161130     c                   callp     UpdArt(-Old.odqty + Old.odqtyliv:old.odarid)
000101161130     c                   when      teven = '3'
000102161130     c                   eval      pn = %addr(parm1) + newoff
000103161130     c                   eval      po = %addr(parm1) + oldoff
000104161130     c                   if        new.odarid = Old.odarid
000105161130     c                   callp     UpdArt((New.odqty - Old.odqty)
000106161130     c                              - (New.odqtyLiv - Old.odqtyLiv)
000107161130     c                             :new.odarid)
000108161130     c                   else
000109161130     c                   callp     UpdArt(new.odqty- new.odqtyliv:new.odarid)
000110161130     c                   callp     UpdArt(-Old.odqty + Old.odqtyliv:old.odarid)
000111161130     c                   endif
000112161130     c                   endsl
000113161130     c                   return
000114161130
000115161130     P UpdArt          b
000116161130     d UpdArt          pi
000117161130     d   qty                          5  0 value
000118161130     d   id                                like(new.ODARID)
000119161130     c                   if        qty = 0
000120161130     c                   return
000121161130     c                   ENDIF
000122161130     c     id            chain     article1
000123161130     c                   if        not %found
000124161130     c                   return
000125161130     c                   ENDIF
000126161130     c                   eval      ARCUSQTY += qty
000127161130     c                   update    farti
000128161130     P UpdArt          e
