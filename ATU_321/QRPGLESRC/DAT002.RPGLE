000018161027
000019161027      * Status Data Structure
000020161027      *
000021161027     d                sds
000022161027      * Program Name
000023161027     d stPgmName               1     10
000024161027      * Exception Error Message Text
000025161027     d stExcText              91    170
000026161027
000100161027     d isotodat40      pr                    extpgm('DAT002')
000101161027       // input
000102161027     d  dat8                          8  0
000103161027       // result
000500161027     d  date                           d
000700161027       // Null Indicator Parameters
000900161027     d  dat8_ind                      5i 0
001000161027     d  date_ind                      5i 0
001200161027       // SQL Function Parameters
001400161027       // SQL State  -  Input/Output
001500161027     d SQL_State                      5
001600161027       // Function Name    Schema.Def name - Input only
001700161027     d Function_Name                139
001800161027       // Function Specific Name - Input Only
001900161027     d Specific_Name                128
002000161027       // Message Text - Input/Output
002100161027     d Msg_Text                      70    varying
002200161027
002202161027     d isotodat40      pi
002203161027     d  dat8                          8  0
002205161027     d  date                           d
002207161027     d  dat8_ind                      5i 0
002208161027     d  date_ind                      5i 0
002211161027     d SQL_State                      5
002213161027     d Function_Name                139
002215161027     d Specific_Name                128
002217161027     d Msg_Text                      70    varying
002218161103      /free
004400161027       // Clear NULL column indicator and SQL State
004500161027       date_ind=*zero ;
004600161027       SQL_State='00000';
004601161027        //  Special values
004701161027       if dat8 = 0;
004702161027         date = D'1940-01-01';
004703161027       elseif dat8 = *Hival;
004704161027         date = D'2039-12-31';
004800161027       else;
004801161027         test(de) *iso dat8;
004802161027         if %error;
004803161027           date_ind = -1;
004804161027         else;
004805161027           date = %date(dat8:*iso);
004806161027         endif;
004807161027       endif;
004808161027       return;
006000161027
006001161027       begsr *PSSR;
006700161027         // Return error code in SQL State (38xxx)
006800161027         // Set SQL Message Text to first 70 characters of SDS exception text
006900161027
007000161027         SQL_State='38I02';
007100161027         Msg_Text=%trimr(stExcText);
007101161027         return;
007102161027       endsr;
007200161103      /end-free
