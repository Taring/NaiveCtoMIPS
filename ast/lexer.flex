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
Comment = {OneLineComment} | {IncludeComment} | {TraditionalComment}

TraditionalComment = "/*"[^"*/"]*"*/"
IncludeComment = #[^"\n"]*"\n"
OneLineComment = "//"[^"\n"]*"\n"

/*Constants*/
Identifier = [a-zA-Z_$][a-zA-Z_$0-9]*
Constint = 0[0-7]*|0[xX][0-9a-fA-F]+|[1-9][0-9]*
Constchar = '([^\n']|\\')+'
Conststr = \"([^\n\r\"]|\\\")*\"

%%
/* ------------------------Lexical Rules Section---------------------- */
<YYINITIAL>	"void"				{return symbol(VOID);}
<YYINITIAL>	"char"				{return symbol(CHAR);}
<YYINITIAL>	"int"				{return symbol(INT);}
<YYINITIAL> "struct"			{return symbol(STRUCT);}
<YYINITIAL> "union"				{return symbol(UNION);}
<YYINITIAL> "if"				{return symbol(IF);}
<YYINITIAL> "else"				{return symbol(ELSE);}
<YYINITIAL>	"while"				{return symbol(WHILE);}
<YYINITIAL>	"for"				{return symbol(FOR);}
<YYINITIAL>	"continue"			{return symbol(CONTINUE);}
<YYINITIAL>	"break"				{return symbol(BREAK);}
<YYINITIAL>	"return"			{return symbol(RETURN);}
<YYINITIAL>	"sizeof"			{return symbol(SIZEOF);}

<YYINITIAL> {
	/*Ignorance*/
	{Comment}			{/*ignore*/}
	{WhiteSpace}		{/*ignore*/}
	
	/*Constants*/
	{Identifier}		{return symbol(ID, yytext());}
	{Constint}			{return symbol(CONSTINT, yytext());}
	{Constchar}			{return symbol(CONSTCHAR, yytext());}
	{Conststr}			{return symbol(CONSTSTR, yytext());}
	
	/*Keywords*/

	/*Op*/
	"("					{return symbol(LPA);}
	")"					{return symbol(RPA);}
	";"					{return symbol(SEMI);}
	","					{return symbol(COMMA);}
	"="					{return symbol(EVA);}
	"{"					{return symbol(LCU);}
	"}"					{return symbol(RCU);}
	"["					{return symbol(LSQ);}
	"]"					{return symbol(RSQ);}
	"|"					{return symbol(OR);}
	"^"					{return symbol(XOR);}
	"&"					{return symbol(AND);}
	"<"					{return symbol(LT);}
	">"					{return symbol{GT};}
	"+"					{return symbol(ADD);}
	"-"					{return symbol(SUB);}
	"*"					{return symbol(MUL);}
	"/"					{return symbol(DIV);}
	"%"					{return symbol(MOD);}
	"~"					{return symbol(TILDE);}
	"!"					{return symbol(NOT_L);}
	"."					{return symbol(DOT);}
	
	"||"					{return symbol(OR_L);}
	"&&"					{return symbol(AND_L);}
	"=="					{return symbol(EQ);}
	"!="					{return symbol(NE);}
	"<="					{return symbol(LE);}
	">="					{return symbol(GE);}
	"<<"					{return symbol(SHL);}
	">>"					{return symbol(SHR);}
	"++"					{return symbol(INC);}
	"--"					{return symbol(DEC);}
	"->"					{return symbol{PTR};}
	
	"*="					{return symbol(MUL_ASSIGN);}
	"/="					{return symbol(DIV_ASSIGN);}
	"%="					{return symbol(MOD_ASSIGN);}
	"+="					{return symbol(ADD_ASSIGN);}
	"-="					{return symbol(SUB_ASSIGN);}
	"<<="					{return symbol(SHL_ASSIGN);}
	">>="					{return symbol(SHR_ASSIGN);}
	"&="					{return symbol(AND_ASSIGN);}
	"^="					{return symbol(XOR_ASSIGN);}
	"|="					{return symbol(OR_ASSIGN);}
	
	/*others*/
	.						{System.out.print((int)yytext[0]); yyerror("invalid character");}
}

