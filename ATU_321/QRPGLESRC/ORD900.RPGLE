000100161104     forder1    if   e           k disk
000300161104     d next            s              6s 0 DTAARA('LASTORDNO')
000400161104     c     *hival        setgt     order1
000500161104     c                   readp     order1
000600161104     c     *lock         in        next
000700161104     c                   z-add     orid          next
000800161104     c                   out       next
000900161104     c                   seton                                        lr
