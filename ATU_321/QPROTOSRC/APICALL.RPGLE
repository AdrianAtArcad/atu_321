000100161216     d crtusrspc       pr                  extpgm('QUSCRTUS')
000200161216     D  usrspc                       20
000300161216     D spc_attr                      10    const
000400161216     D spc_size                      10i 0 const
000500161216     D spc_init                       1    const
000600161216     D spc_aut                       10    const
000700161216     D spc_text                      50    const
000800161216     D spc_replace                   10    const
000900161216     D  errcod                      256
001000161216
001100161216     d rtvusrspcptr    pr                  extpgm('QUSPTRUS')
001200161216     D  usrspc                       20    const
001300161216     d  ptr                            *
001400161216
001500161216      /if not defined(exec)
001600161216     D exec            pr                  extpgm('QCMDEXC')
001700161216     D                             3000A   options(*varsize) const
001800161216     D                               15P 5 const
001900161216     D                                3A   const options(*nopass)
002000161216      /define exec
002100161216      /endif
002200161216      /if not defined(errcod)
002300161216     d errcod          ds
002400161216     d  byte_provided                10i 0 inz(%len(errcod))
002500161216     d  byte_availabl                10i 0
002600161216     d  error_msgid                   7
002700161216     d                                1
002800161216     d  message_data                240
002900161216
003000161216      /define errcod
003100161216      /endif
