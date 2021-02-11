000019161104             CMD        PROMPT('Convert Spool to PDF')
000020161104
000021161104             PARM       KWD(FROMFILE) TYPE(*NAME) LEN(10) MIN(1) +
000022161104                          PROMPT('From spooled file name')
000023161104
000024161104             PARM       KWD(TOSTMF) TYPE(*NAME) LEN(64) MIN(1) PROMPT('To +
000025161104                          stream file name')
000026161104
000027161104             PARM       KWD(TODIR) TYPE(*PNAME) LEN(256) MIN(1) PROMPT('To +
000028161104                          directory')
000029161104
000030161104             PARM       KWD(JOB) TYPE(JOB) DFT(*) SNGVAL((*)) PROMPT('Job +
000031161104                          name')
000032161104 JOB:        QUAL       TYPE(*NAME) LEN(10) MIN(1)
000033161104             QUAL       TYPE(*NAME) LEN(10) MIN(1) PROMPT('User')
000034161104             QUAL       TYPE(*CHAR) LEN(6) RANGE(000000 999999) MIN(1) +
000035161104                          PROMPT('Number')
000036161104
000037161104             PARM       KWD(SPLNBR) TYPE(*DEC) LEN(4) DFT(*ONLY) RANGE(1 +
000038161104                          9999) SPCVAL((*LAST -2) (*ONLY -3)) +
000039161104                          PROMPT('Spooled file number')
000040161104
000041161104             PARM       KWD(STMFOPT) TYPE(*CHAR) LEN(8) RSTD(*YES) +
000042161104                          DFT(*NONE) VALUES(*NONE *REPLACE ) +
000043161104                          PROMPT('Stream file option')
000044161104
000045161104             PARM       KWD(STMFCODPAG) TYPE(*DEC) LEN(5 0) DFT(1250) +
000046161104                          RANGE(1 32767) SPCVAL((*PCASCII -1) (*STMF -2)) +
000047161104                          PMTCTL(*PMTRQS) PROMPT('Stream file code page')
000048161104
000049161104             PARM       KWD(TITLE) TYPE(*CHAR) LEN(50) RSTD(*NO) +
000050161104                          DFT(*NONE) SPCVAL((*NONE) (*STMFILE)) +
000051161104                          PROMPT('Title for PDF')
000052161104
000053161104             PARM       KWD(PAGESIZE) TYPE(LIST3) DFT(*SPLF) +
000054161104                          SNGVAL((*SPLF) (*CUSTOM)) CHOICE(*NONE) +
000055161104                          PROMPT('Page size')
000056161104 LIST3:      ELEM       TYPE(*CHAR) LEN(7) RSTD(*YES) VALUES(*A4 *A5 +
000057161104                          *LETTER *LEGAL *EXEC) PROMPT('Paper size')
000058161104             ELEM       TYPE(*CHAR) LEN(10) RSTD(*YES) DFT(*LANDSCAPE) +
000059161104                          VALUES(*LANDSCAPE *PORTRAIT) +
000060161104                          PROMPT('Orientation')
000061161104
000062161104             PARM       KWD(CUSTOMPAGE) TYPE(LIST4) CHOICE(*NONE) +
000063161104                          PMTCTL(CUSTOM) PROMPT('Custom page size')
000064161104 LIST4:      ELEM       TYPE(*DEC) LEN(6 3) DFT(210) RANGE(.001 999.999) +
000065161104                          EXPR(*YES) PROMPT('Page width')
000066161104             ELEM       TYPE(*DEC) LEN(6 3) DFT(297) RANGE(.001 999.999) +
000067161104                          EXPR(*YES) PROMPT('Page length')
000068161104             ELEM       TYPE(*CHAR) LEN(5) RSTD(*YES) DFT(*MM) +
000069161104                          VALUES(*INCH *MM) EXPR(*YES) PROMPT('Unit of +
000070161104                          measure')
000071161104
000072161104             PARM       KWD(FONT) TYPE(LIST5) DFT(*CONVERT) +
000073161104                          SNGVAL((*CONVERT)) CHOICE(*NONE) PROMPT('Font')
000075161104 LIST5:      ELEM       TYPE(*CHAR) LEN(10) RSTD(*YES) SPCVAL((*COURIER) +
000076161104                          (*COURIERB) (*COURIERO) (*COURIERBO) +
000077161104                          (*HELVETICA) (*HELVB) (*HELVO) (*HELVBO) +
000078161104                          (*TIMES) (*TIMESB) (*TIMESI) (*TIMESBI) +
000079161104                          (*SYMBOL) (*DINGBATS)) EXPR(*YES) PROMPT('Face')
000081161104             ELEM       TYPE(*DEC) LEN(2) DFT(*CALC) RANGE(4 36) +
000082161104                          SPCVAL((*CALC -1)) EXPR(*YES) PROMPT('Size')
000083161104
000084161104             PARM       KWD(BOOKMARK) TYPE(*CHAR) LEN(7) RSTD(*YES) +
000085161104                          DFT(*PAGNBR) VALUES(*PAGNBR *POS *KEY *NONE) +
000086161104                          PROMPT('Type of PDF bookmarks')
000087161104
000088161104             PARM       KWD(BMARKPOS) TYPE(LIST1) PMTCTL(POS) PROMPT('PDF +
000089161104                          bookmark string position')
000090161104 LIST1:      ELEM       TYPE(*DEC) LEN(3 0) DFT(1) RANGE(1 300) +
000091161104                          PROMPT('Line number')
000092161104             ELEM       TYPE(*DEC) LEN(3 0) DFT(1) RANGE(1 378) +
000093161104                          PROMPT('Character position')
000094161104             ELEM       TYPE(*DEC) LEN(3 0) DFT(1) RANGE(1 378) +
000095161104                          PROMPT('Length')
000096161104
000097161104             PARM       KWD(BMARKKEY) TYPE(LIST2) PMTCTL(KEY) PROMPT('PDF +
000098161104                          bookmark string key')
000099161104 LIST2:      ELEM       TYPE(*CHAR) LEN(378) DFT(' ') VARY(*YES *INT2) +
000100161104                          PROMPT('Key string')
000101161104             ELEM       TYPE(*DEC) LEN(3 0) DFT(1) RANGE(1 999) +
000102161104                          PROMPT('Occurrence')
000103161104             ELEM       TYPE(*DEC) LEN(3 0) DFT(0) RANGE(-378 378) +
000104161104                          PROMPT('Offset')
000105161104             ELEM       TYPE(*DEC) LEN(3 0) DFT(1) RANGE(1 378) +
000106161104                          PROMPT('Length')
000107161104
000108161104 CUSTOM:     PMTCTL     CTL(PAGESIZE) COND((*EQ *CUSTOM)) NBRTRUE(*EQ 1)
000110161104
000111161104 POS:        PMTCTL     CTL(BOOKMARK) COND((*EQ *POS)) NBRTRUE(*EQ 1)
000112161104
000113161104 KEY:        PMTCTL     CTL(BOOKMARK) COND((*EQ *KEY)) NBRTRUE(*EQ 1)
000114161104
