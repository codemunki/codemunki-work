package minimud_shared;

%%
%class MessageScanner 
%unicode
%line
%column
%byaccj

%{

/* store a reference to the parser object */
	private MessageParser yyparser;

	/* constructor taking an additional parser */
	public MessageScanner (java.io.Reader r, MessageParser yyparser) {
		this (r);	
		this.yyparser = yyparser;
	}

	/* return the current line number. We need this
	   because yyline is made private and we don't have
	   a mechanism like extern in C. */
	public int getLine() {
		return yyline;
	}
%}

%%
text_msg		{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.TEXTMSG;}
message			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.MESSAGE;}
from			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.FROM;}
to				{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.TO;}
at				{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.AT;}
player			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.PLAYER;}
server			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.SERVER;}
request_input	{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.REQUEST_INPUT;}
type			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.TYPE;}
normal_input	{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.NORMAL_INPUT;}
passwd_input	{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.PASSWD_INPUT;}
server_status	{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.SERVER_STATUS;}
logon_success	{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.LOGON_SUCCESS;}
logon_failed	{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.LOGON_FAILED;}
invalid			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.INVALID;}
quit			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.QUIT;}
exit			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.EXIT;}
logout			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.LOGOUT;}
\/tell			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.TELL;}
\/say			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.SAY;}
\/shout			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.SHOUT;}
\/whisper		{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.WHISPER;}
\/who           {yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.WHO;}
north			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.GO_NORTH;}
south			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.GO_SOUTH;}
east			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.GO_EAST;}
west			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.GO_WEST;}
northeast		{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.GO_NORTHEAST;}
northwest		{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.GO_NORTHWEST;}
southeast		{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.GO_SOUTHEAST;}
southwest		{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.GO_SOUTHWEST;}
up				{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.GO_UP;}
down			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.GO_DOWN;}
look			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.LOOK;}
kick			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.KICK;}
punch			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.PUNCH;}
talk			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.TALK;}
stab			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.STAB;}
slash			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.SLASH;}
push			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.PUSH;}
shoot			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.SHOOT;}
take			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.TAKE;}
drop			{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.DROP;}
attack          {yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.ATTACK;}
\/leaders       {yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.LEADERS;}
gold            {yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.GOLD;}
xp              {yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.XP;}
with            {yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.WITH;}
\/inventory     {yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.INVENTORY;}
\/help          {yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.HELP;}
\/questlog      {yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.QUESTLOG;}
use             {yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.USE;}
\/charinfo      {yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.CHARINFO;}
    \/questcompletion {yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.QUESTCOMPLETION;}

\,		{return (int)yycharat(0);}
\=		{return (int)yycharat(0);}
\:		{return (int)yycharat(0);}
\(		{return (int)yycharat(0);}
\)		{return (int)yycharat(0);}

\'[a-zA-Z0-9\,\+\-\!\@\#\$\%\^\&\*\(\)\{\}\[\]\;\:\.\<\>\?\/\~\"\t_ ]*\'	{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.CHARLITERAL;}
\"[a-zA-Z0-9\,\+\-\!\@\#\$\%\^\&\*\(\)\{\}\[\]\;\:\.\<\>\?\/\~\'\t_ ]*\"	{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.STRINGLITERAL;}

[a-zA-Z][a-zA-Z0-9]{1,31}	{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.CHARNAME;}
[0-9]*		{yyparser.yylval = new MessageParserVal(yytext()); return MessageParser.INT;}
[\n]		{;}
[ \t]		{;}
[\r]		{;}