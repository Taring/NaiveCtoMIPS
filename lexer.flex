/*
	* This is the lexer for compiler by using Jflex
	* And it will be good used by Jcup
	
	to Create the lexer.java
	> jflex lexer.flex
*/
/* --------------------------Usercode Section------------------------ */
import java_cup.runtime.*;
import java.io.*;
import java.util.*;

%%

/* -----------------Options and Declarations Section----------------- */

/* 
   The name of the class JFlex will create will be Lexer.
   Will write the code to the file lexer.java. 
*/
%class lexer

%unicode
%line
%column

/* 
   Will switch to a CUP compatibility mode to interface with a CUP
   generated parser.
*/
%cup

%{ 

	StringBuffer string = new StringBuffer();
	private Symbol symbol(int type) {
		return new Symbol(type, yyline, yycolumn);
	}

    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }

%}

/*WhiteSpace*/
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace = {LineTerminator}|[ \t\f]



/*Comments*/
Comment = {OneLineComment} | {IncludeComment} | {TraditionalComment} | {DocumentationComment}

TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
DocumentationComment = "/*" "*"+ [^/*] ~"*/"
IncludeComment = #[^"\n"]*"\n"
OneLineComment = "//"[^"\n"]*{LineTerminator}?

/*Constants*/
Identifier = [a-zA-Z_$][a-zA-Z_$0-9]*
Constint = 0[0-7]*|0[xX][0-9a-fA-F]+|[1-9][0-9]*
Constchar = '([^\n']|\\')+'
Conststr = \"([^\n\r\"]|\\\")*\"

%%
/* ------------------------Lexical Rules Section---------------------- */
<YYINITIAL>	"void"				{return symbol(sym.VOID);}
<YYINITIAL>	"char"				{return symbol(sym.CHAR);}
<YYINITIAL>	"int"				{return symbol(sym.INT);}
<YYINITIAL> "struct"			{return symbol(sym.STRUCT);}
<YYINITIAL> "union"				{return symbol(sym.UNION);}
<YYINITIAL> "if"				{return symbol(sym.IF);}
<YYINITIAL> "else"				{return symbol(sym.ELSE);}
<YYINITIAL>	"while"				{return symbol(sym.WHILE);}
<YYINITIAL>	"for"				{return symbol(sym.FOR);}
<YYINITIAL>	"continue"			{return symbol(sym.CONTINUE);}
<YYINITIAL>	"break"				{return symbol(sym.BREAK);}
<YYINITIAL>	"return"			{return symbol(sym.RETURN);}
<YYINITIAL>	"sizeof"			{return symbol(sym.SIZEOF);}

<YYINITIAL> {
	/*Ignorance*/
	{Comment}			{/*ignore*/}
	{WhiteSpace}		{/*ignore*/}
	
	/*Constants*/
	{Identifier}		{return symbol(sym.ID, yytext());}
	{Constint}			{return symbol(sym.CONSTINT, yytext());}
	{Constchar}			{return symbol(sym.CONSTCHAR, yytext());}
	{Conststr}			{return symbol(sym.CONSTSTR, yytext());}
	
	/*Keywords*/


	"*="					{return symbol(sym.MUL_ASSIGN);}
	"/="					{return symbol(sym.DIV_ASSIGN);}
	"%="					{return symbol(sym.MOD_ASSIGN);}
	"+="					{return symbol(sym.ADD_ASSIGN);}
	"-="					{return symbol(sym.SUB_ASSIGN);}
	"<<="					{return symbol(sym.SHL_ASSIGN);}
	">>="					{return symbol(sym.SHR_ASSIGN);}
	"&="					{return symbol(sym.AND_ASSIGN);}
	"^="					{return symbol(sym.XOR_ASSIGN);}
	"|="					{return symbol(sym.OR_ASSIGN);}
	
	"||"					{return symbol(sym.OR_L);}
	"&&"					{return symbol(sym.AND_L);}
	"=="					{return symbol(sym.EQ);}
	"!="					{return symbol(sym.NE);}
	"<="					{return symbol(sym.LE);}
	">="					{return symbol(sym.GE);}
	"<<"					{return symbol(sym.SHL);}
	">>"					{return symbol(sym.SHR);}
	"++"					{return symbol(sym.INC);}
	"--"					{return symbol(sym.DEC);}
	"->"					{return symbol(sym.PTR);}

	/*Op*/
	"("					{return symbol(sym.LPA);}
	")"					{return symbol(sym.RPA);}
	";"					{return symbol(sym.SEMI);}
	","					{return symbol(sym.COMMA);}
	"="					{return symbol(sym.EVA);}
	"{"					{return symbol(sym.LCU);}
	"}"					{return symbol(sym.RCU);}
	"["					{return symbol(sym.LSQ);}
	"]"					{return symbol(sym.RSQ);}
	"|"					{return symbol(sym.OR);}
	"^"					{return symbol(sym.XOR);}
	"&"					{return symbol(sym.AND);}
	"<"					{return symbol(sym.LT);}
	">"					{return symbol(sym.GT);}
	"+"					{return symbol(sym.ADD);}
	"-"					{return symbol(sym.SUB);}
	"*"					{return symbol(sym.MUL);}
	"/"					{return symbol(sym.DIV);}
	"%"					{return symbol(sym.MOD);}
	"~"					{return symbol(sym.COM);}
	"!"					{return symbol(sym.NOT);}
	"."					{return symbol(sym.DOT);}

}
/* others */
[^]						{throw new Error("Illegal character<"+yytext()+">");}

