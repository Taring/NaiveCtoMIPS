/* The following code was generated by JFlex 1.4.3 on 15-4-17 下午12:56 */

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


/**
 * This class is a scanner generated by 
 * <a href="http://www.jflex.de/">JFlex</a> 1.4.3
 * on 15-4-17 下午12:56 from the specification file
 * <tt>lexer.flex</tt>
 */
class lexer implements java_cup.runtime.Scanner {

  /** This character denotes the end of file */
  public static final int YYEOF = -1;

  /** initial size of the lookahead buffer */
  private static final int ZZ_BUFFERSIZE = 16384;

  /** lexical states */
  public static final int YYINITIAL = 0;

  /**
   * ZZ_LEXSTATE[l] is the state in the DFA for the lexical state l
   * ZZ_LEXSTATE[l+1] is the state in the DFA for the lexical state l
   *                  at the beginning of a line
   * l is of the form l = 2*k, k a non negative integer
   */
  private static final int ZZ_LEXSTATE[] = { 
     0, 0
  };

  /** 
   * Translates characters to character classes
   */
  private static final String ZZ_CMAP_PACKED = 
    "\11\0\1\3\1\2\1\0\1\3\1\1\22\0\1\3\1\65\1\17"+
    "\1\6\1\7\1\63\1\56\1\15\1\43\1\44\1\5\1\61\1\46"+
    "\1\62\1\66\1\4\1\11\7\12\2\10\1\0\1\45\1\57\1\47"+
    "\1\60\2\0\6\14\21\7\1\13\2\7\1\52\1\16\1\53\1\55"+
    "\1\7\1\0\1\26\1\40\1\24\1\23\1\35\1\34\1\7\1\25"+
    "\1\22\1\7\1\41\1\36\1\7\1\30\1\21\2\7\1\27\1\32"+
    "\1\31\1\33\1\20\1\37\1\13\1\7\1\42\1\50\1\54\1\51"+
    "\1\64\uff81\0";

  /** 
   * Translates characters to character classes
   */
  private static final char [] ZZ_CMAP = zzUnpackCMap(ZZ_CMAP_PACKED);

  /** 
   * Translates DFA states to action switch labels.
   */
  private static final int [] ZZ_ACTION = zzUnpackAction();

  private static final String ZZ_ACTION_PACKED_0 =
    "\1\0\1\1\2\2\1\3\1\4\1\1\1\5\2\6"+
    "\2\1\12\5\1\7\1\10\1\11\1\12\1\13\1\14"+
    "\1\15\1\16\1\17\1\20\1\21\1\22\1\23\1\24"+
    "\1\25\1\26\1\27\1\30\1\31\1\32\2\0\1\33"+
    "\1\34\1\6\5\0\1\35\2\5\1\36\12\5\1\37"+
    "\1\40\1\41\1\42\1\43\1\44\1\45\1\46\1\47"+
    "\1\50\1\51\1\52\1\53\1\54\1\55\1\56\1\57"+
    "\1\0\1\6\2\60\1\35\1\5\1\61\6\5\1\62"+
    "\3\5\1\63\1\64\1\65\1\5\1\66\4\5\1\67"+
    "\6\5\1\70\1\71\1\72\1\5\1\73\1\74\1\75"+
    "\1\5\1\76";

  private static int [] zzUnpackAction() {
    int [] result = new int[125];
    int offset = 0;
    offset = zzUnpackAction(ZZ_ACTION_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackAction(String packed, int offset, int [] result) {
    int i = 0;       /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int count = packed.charAt(i++);
      int value = packed.charAt(i++);
      do result[j++] = value; while (--count > 0);
    }
    return j;
  }


  /** 
   * Translates a state to a row index in the transition table
   */
  private static final int [] ZZ_ROWMAP = zzUnpackRowMap();

  private static final String ZZ_ROWMAP_PACKED_0 =
    "\0\0\0\67\0\156\0\67\0\245\0\334\0\u0113\0\u014a"+
    "\0\u0181\0\u01b8\0\u01ef\0\u0226\0\u025d\0\u0294\0\u02cb\0\u0302"+
    "\0\u0339\0\u0370\0\u03a7\0\u03de\0\u0415\0\u044c\0\67\0\67"+
    "\0\67\0\67\0\u0483\0\67\0\67\0\67\0\67\0\u04ba"+
    "\0\u04f1\0\u0528\0\u055f\0\u0596\0\u05cd\0\u0604\0\u063b\0\67"+
    "\0\u0672\0\67\0\u0113\0\u06a9\0\67\0\67\0\u06e0\0\u0717"+
    "\0\u074e\0\u0785\0\u0226\0\u07bc\0\67\0\u07f3\0\u082a\0\u014a"+
    "\0\u0861\0\u0898\0\u08cf\0\u0906\0\u093d\0\u0974\0\u09ab\0\u09e2"+
    "\0\u0a19\0\u0a50\0\67\0\67\0\67\0\67\0\67\0\67"+
    "\0\67\0\u0a87\0\67\0\u0abe\0\67\0\67\0\67\0\67"+
    "\0\67\0\67\0\67\0\u0af5\0\u0717\0\67\0\u074e\0\u0226"+
    "\0\u0b2c\0\u014a\0\u0b63\0\u0b9a\0\u0bd1\0\u0c08\0\u0c3f\0\u0c76"+
    "\0\u014a\0\u0cad\0\u0ce4\0\u0d1b\0\67\0\67\0\u014a\0\u0d52"+
    "\0\u014a\0\u0d89\0\u0dc0\0\u0df7\0\u0e2e\0\u014a\0\u0e65\0\u0e9c"+
    "\0\u0ed3\0\u0f0a\0\u0f41\0\u0f78\0\u014a\0\u014a\0\u014a\0\u0faf"+
    "\0\u014a\0\u014a\0\u014a\0\u0fe6\0\u014a";

  private static int [] zzUnpackRowMap() {
    int [] result = new int[125];
    int offset = 0;
    offset = zzUnpackRowMap(ZZ_ROWMAP_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackRowMap(String packed, int offset, int [] result) {
    int i = 0;  /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int high = packed.charAt(i++) << 16;
      result[j++] = high | packed.charAt(i++);
    }
    return j;
  }

  /** 
   * The transition table of the DFA
   */
  private static final int [] ZZ_TRANS = zzUnpackTrans();

  private static final String ZZ_TRANS_PACKED_0 =
    "\1\2\1\3\2\4\1\5\1\6\1\7\1\10\1\11"+
    "\1\12\1\11\2\10\1\13\1\2\1\14\1\15\1\10"+
    "\1\16\1\10\1\17\2\10\1\20\2\10\1\21\1\22"+
    "\1\23\1\24\1\10\1\25\1\26\2\10\1\27\1\30"+
    "\1\31\1\32\1\33\1\34\1\35\1\36\1\37\1\40"+
    "\1\41\1\42\1\43\1\44\1\45\1\46\1\47\1\50"+
    "\1\51\1\52\71\0\1\4\70\0\1\53\1\54\41\0"+
    "\1\55\66\0\1\56\17\0\2\53\1\4\64\53\7\0"+
    "\6\10\3\0\23\10\34\0\3\11\65\0\2\57\1\60"+
    "\53\0\2\61\1\0\12\61\1\0\1\62\50\61\1\63"+
    "\2\0\13\63\1\64\1\65\47\63\7\0\6\10\3\0"+
    "\1\10\1\66\21\10\33\0\6\10\3\0\10\10\1\67"+
    "\3\10\1\70\6\10\33\0\6\10\3\0\1\10\1\71"+
    "\3\10\1\72\15\10\33\0\6\10\3\0\15\10\1\73"+
    "\5\10\33\0\6\10\3\0\2\10\1\74\6\10\1\75"+
    "\11\10\33\0\6\10\3\0\10\10\1\76\12\10\33\0"+
    "\6\10\3\0\1\10\1\77\21\10\33\0\6\10\3\0"+
    "\16\10\1\100\4\10\33\0\6\10\3\0\5\10\1\101"+
    "\15\10\33\0\6\10\3\0\7\10\1\102\13\10\73\0"+
    "\1\103\66\0\1\104\4\0\1\105\61\0\1\106\66\0"+
    "\1\107\6\0\1\110\57\0\1\111\7\0\1\112\56\0"+
    "\1\113\10\0\1\114\55\0\1\115\11\0\1\116\54\0"+
    "\1\117\10\0\1\120\1\0\1\121\53\0\1\122\66\0"+
    "\1\123\17\0\4\54\1\0\1\124\61\54\11\0\2\57"+
    "\64\0\3\125\1\0\1\125\6\0\2\125\1\0\1\125"+
    "\5\0\2\125\2\0\1\125\26\0\2\61\1\0\12\61"+
    "\1\126\1\62\52\61\1\0\12\61\1\127\1\62\50\61"+
    "\1\63\2\0\13\63\1\64\1\130\47\63\7\0\6\10"+
    "\3\0\2\10\1\131\20\10\33\0\6\10\3\0\11\10"+
    "\1\132\11\10\33\0\6\10\3\0\10\10\1\133\12\10"+
    "\33\0\6\10\3\0\6\10\1\134\14\10\33\0\6\10"+
    "\3\0\11\10\1\135\11\10\33\0\6\10\3\0\22\10"+
    "\1\136\33\0\6\10\3\0\7\10\1\137\13\10\33\0"+
    "\6\10\3\0\2\10\1\140\20\10\33\0\6\10\3\0"+
    "\7\10\1\141\13\10\33\0\6\10\3\0\12\10\1\142"+
    "\10\10\33\0\6\10\3\0\2\10\1\143\20\10\33\0"+
    "\6\10\3\0\15\10\1\144\5\10\73\0\1\145\66\0"+
    "\1\146\23\0\1\4\71\0\6\10\3\0\3\10\1\147"+
    "\17\10\33\0\6\10\3\0\11\10\1\150\11\10\33\0"+
    "\6\10\3\0\7\10\1\151\13\10\33\0\6\10\3\0"+
    "\13\10\1\152\7\10\33\0\6\10\3\0\15\10\1\153"+
    "\5\10\33\0\6\10\3\0\13\10\1\154\7\10\33\0"+
    "\6\10\3\0\1\10\1\155\21\10\33\0\6\10\3\0"+
    "\15\10\1\156\5\10\33\0\6\10\3\0\16\10\1\157"+
    "\4\10\33\0\6\10\3\0\6\10\1\160\14\10\33\0"+
    "\6\10\3\0\2\10\1\161\20\10\33\0\6\10\3\0"+
    "\7\10\1\162\13\10\33\0\6\10\3\0\1\10\1\163"+
    "\21\10\33\0\6\10\3\0\4\10\1\164\16\10\33\0"+
    "\6\10\3\0\10\10\1\165\12\10\33\0\6\10\3\0"+
    "\15\10\1\166\5\10\33\0\6\10\3\0\21\10\1\167"+
    "\1\10\33\0\6\10\3\0\10\10\1\170\12\10\33\0"+
    "\6\10\3\0\10\10\1\171\12\10\33\0\6\10\3\0"+
    "\14\10\1\172\6\10\33\0\6\10\3\0\11\10\1\173"+
    "\11\10\33\0\6\10\3\0\13\10\1\174\7\10\33\0"+
    "\6\10\3\0\15\10\1\175\5\10\24\0";

  private static int [] zzUnpackTrans() {
    int [] result = new int[4125];
    int offset = 0;
    offset = zzUnpackTrans(ZZ_TRANS_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackTrans(String packed, int offset, int [] result) {
    int i = 0;       /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int count = packed.charAt(i++);
      int value = packed.charAt(i++);
      value--;
      do result[j++] = value; while (--count > 0);
    }
    return j;
  }


  /* error codes */
  private static final int ZZ_UNKNOWN_ERROR = 0;
  private static final int ZZ_NO_MATCH = 1;
  private static final int ZZ_PUSHBACK_2BIG = 2;

  /* error messages for the codes above */
  private static final String ZZ_ERROR_MSG[] = {
    "Unkown internal scanner error",
    "Error: could not match input",
    "Error: pushback value was too large"
  };

  /**
   * ZZ_ATTRIBUTE[aState] contains the attributes of state <code>aState</code>
   */
  private static final int [] ZZ_ATTRIBUTE = zzUnpackAttribute();

  private static final String ZZ_ATTRIBUTE_PACKED_0 =
    "\1\0\1\11\1\1\1\11\22\1\4\11\1\1\4\11"+
    "\10\1\1\11\1\1\1\11\2\0\2\11\1\1\5\0"+
    "\1\11\15\1\7\11\1\1\1\11\1\1\7\11\1\0"+
    "\1\1\1\11\16\1\2\11\27\1";

  private static int [] zzUnpackAttribute() {
    int [] result = new int[125];
    int offset = 0;
    offset = zzUnpackAttribute(ZZ_ATTRIBUTE_PACKED_0, offset, result);
    return result;
  }

  private static int zzUnpackAttribute(String packed, int offset, int [] result) {
    int i = 0;       /* index in packed string  */
    int j = offset;  /* index in unpacked array */
    int l = packed.length();
    while (i < l) {
      int count = packed.charAt(i++);
      int value = packed.charAt(i++);
      do result[j++] = value; while (--count > 0);
    }
    return j;
  }

  /** the input device */
  private java.io.Reader zzReader;

  /** the current state of the DFA */
  private int zzState;

  /** the current lexical state */
  private int zzLexicalState = YYINITIAL;

  /** this buffer contains the current text to be matched and is
      the source of the yytext() string */
  private char zzBuffer[] = new char[ZZ_BUFFERSIZE];

  /** the textposition at the last accepting state */
  private int zzMarkedPos;

  /** the current text position in the buffer */
  private int zzCurrentPos;

  /** startRead marks the beginning of the yytext() string in the buffer */
  private int zzStartRead;

  /** endRead marks the last character in the buffer, that has been read
      from input */
  private int zzEndRead;

  /** number of newlines encountered up to the start of the matched text */
  private int yyline;

  /** the number of characters up to the start of the matched text */
  private int yychar;

  /**
   * the number of characters from the last newline up to the start of the 
   * matched text
   */
  private int yycolumn;

  /** 
   * zzAtBOL == true <=> the scanner is currently at the beginning of a line
   */
  private boolean zzAtBOL = true;

  /** zzAtEOF == true <=> the scanner is at the EOF */
  private boolean zzAtEOF;

  /** denotes if the user-EOF-code has already been executed */
  private boolean zzEOFDone;

  /* user code: */

	StringBuffer string = new StringBuffer();
	private Symbol symbol(int type) {
		return new Symbol(type, yyline, yycolumn);
	}

    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }



  /**
   * Creates a new scanner
   * There is also a java.io.InputStream version of this constructor.
   *
   * @param   in  the java.io.Reader to read input from.
   */
  lexer(java.io.Reader in) {
    this.zzReader = in;
  }

  /**
   * Creates a new scanner.
   * There is also java.io.Reader version of this constructor.
   *
   * @param   in  the java.io.Inputstream to read input from.
   */
  lexer(java.io.InputStream in) {
    this(new java.io.InputStreamReader(in));
  }

  /** 
   * Unpacks the compressed character translation table.
   *
   * @param packed   the packed character translation table
   * @return         the unpacked character translation table
   */
  private static char [] zzUnpackCMap(String packed) {
    char [] map = new char[0x10000];
    int i = 0;  /* index in packed string  */
    int j = 0;  /* index in unpacked array */
    while (i < 144) {
      int  count = packed.charAt(i++);
      char value = packed.charAt(i++);
      do map[j++] = value; while (--count > 0);
    }
    return map;
  }


  /**
   * Refills the input buffer.
   *
   * @return      <code>false</code>, iff there was new input.
   * 
   * @exception   java.io.IOException  if any I/O-Error occurs
   */
  private boolean zzRefill() throws java.io.IOException {

    /* first: make room (if you can) */
    if (zzStartRead > 0) {
      System.arraycopy(zzBuffer, zzStartRead,
                       zzBuffer, 0,
                       zzEndRead-zzStartRead);

      /* translate stored positions */
      zzEndRead-= zzStartRead;
      zzCurrentPos-= zzStartRead;
      zzMarkedPos-= zzStartRead;
      zzStartRead = 0;
    }

    /* is the buffer big enough? */
    if (zzCurrentPos >= zzBuffer.length) {
      /* if not: blow it up */
      char newBuffer[] = new char[zzCurrentPos*2];
      System.arraycopy(zzBuffer, 0, newBuffer, 0, zzBuffer.length);
      zzBuffer = newBuffer;
    }

    /* finally: fill the buffer with new input */
    int numRead = zzReader.read(zzBuffer, zzEndRead,
                                            zzBuffer.length-zzEndRead);

    if (numRead > 0) {
      zzEndRead+= numRead;
      return false;
    }
    // unlikely but not impossible: read 0 characters, but not at end of stream    
    if (numRead == 0) {
      int c = zzReader.read();
      if (c == -1) {
        return true;
      } else {
        zzBuffer[zzEndRead++] = (char) c;
        return false;
      }     
    }

	// numRead < 0
    return true;
  }

    
  /**
   * Closes the input stream.
   */
  public final void yyclose() throws java.io.IOException {
    zzAtEOF = true;            /* indicate end of file */
    zzEndRead = zzStartRead;  /* invalidate buffer    */

    if (zzReader != null)
      zzReader.close();
  }


  /**
   * Resets the scanner to read from a new input stream.
   * Does not close the old reader.
   *
   * All internal variables are reset, the old input stream 
   * <b>cannot</b> be reused (internal buffer is discarded and lost).
   * Lexical state is set to <tt>ZZ_INITIAL</tt>.
   *
   * @param reader   the new input stream 
   */
  public final void yyreset(java.io.Reader reader) {
    zzReader = reader;
    zzAtBOL  = true;
    zzAtEOF  = false;
    zzEOFDone = false;
    zzEndRead = zzStartRead = 0;
    zzCurrentPos = zzMarkedPos = 0;
    yyline = yychar = yycolumn = 0;
    zzLexicalState = YYINITIAL;
  }


  /**
   * Returns the current lexical state.
   */
  public final int yystate() {
    return zzLexicalState;
  }


  /**
   * Enters a new lexical state
   *
   * @param newState the new lexical state
   */
  public final void yybegin(int newState) {
    zzLexicalState = newState;
  }


  /**
   * Returns the text matched by the current regular expression.
   */
  public final String yytext() {
    return new String( zzBuffer, zzStartRead, zzMarkedPos-zzStartRead );
  }


  /**
   * Returns the character at position <tt>pos</tt> from the 
   * matched text. 
   * 
   * It is equivalent to yytext().charAt(pos), but faster
   *
   * @param pos the position of the character to fetch. 
   *            A value from 0 to yylength()-1.
   *
   * @return the character at position pos
   */
  public final char yycharat(int pos) {
    return zzBuffer[zzStartRead+pos];
  }


  /**
   * Returns the length of the matched text region.
   */
  public final int yylength() {
    return zzMarkedPos-zzStartRead;
  }


  /**
   * Reports an error that occured while scanning.
   *
   * In a wellformed scanner (no or only correct usage of 
   * yypushback(int) and a match-all fallback rule) this method 
   * will only be called with things that "Can't Possibly Happen".
   * If this method is called, something is seriously wrong
   * (e.g. a JFlex bug producing a faulty scanner etc.).
   *
   * Usual syntax/scanner level error handling should be done
   * in error fallback rules.
   *
   * @param   errorCode  the code of the errormessage to display
   */
  private void zzScanError(int errorCode) {
    String message;
    try {
      message = ZZ_ERROR_MSG[errorCode];
    }
    catch (ArrayIndexOutOfBoundsException e) {
      message = ZZ_ERROR_MSG[ZZ_UNKNOWN_ERROR];
    }

    throw new Error(message);
  } 


  /**
   * Pushes the specified amount of characters back into the input stream.
   *
   * They will be read again by then next call of the scanning method
   *
   * @param number  the number of characters to be read again.
   *                This number must not be greater than yylength()!
   */
  public void yypushback(int number)  {
    if ( number > yylength() )
      zzScanError(ZZ_PUSHBACK_2BIG);

    zzMarkedPos -= number;
  }


  /**
   * Contains user EOF-code, which will be executed exactly once,
   * when the end of file is reached
   */
  private void zzDoEOF() throws java.io.IOException {
    if (!zzEOFDone) {
      zzEOFDone = true;
      yyclose();
    }
  }


  /**
   * Resumes scanning until the next regular expression is matched,
   * the end of input is encountered or an I/O-Error occurs.
   *
   * @return      the next token
   * @exception   java.io.IOException  if any I/O-Error occurs
   */
  public java_cup.runtime.Symbol next_token() throws java.io.IOException {
    int zzInput;
    int zzAction;

    // cached fields:
    int zzCurrentPosL;
    int zzMarkedPosL;
    int zzEndReadL = zzEndRead;
    char [] zzBufferL = zzBuffer;
    char [] zzCMapL = ZZ_CMAP;

    int [] zzTransL = ZZ_TRANS;
    int [] zzRowMapL = ZZ_ROWMAP;
    int [] zzAttrL = ZZ_ATTRIBUTE;

    while (true) {
      zzMarkedPosL = zzMarkedPos;

      boolean zzR = false;
      for (zzCurrentPosL = zzStartRead; zzCurrentPosL < zzMarkedPosL;
                                                             zzCurrentPosL++) {
        switch (zzBufferL[zzCurrentPosL]) {
        case '\u000B':
        case '\u000C':
        case '\u0085':
        case '\u2028':
        case '\u2029':
          yyline++;
          yycolumn = 0;
          zzR = false;
          break;
        case '\r':
          yyline++;
          yycolumn = 0;
          zzR = true;
          break;
        case '\n':
          if (zzR)
            zzR = false;
          else {
            yyline++;
            yycolumn = 0;
          }
          break;
        default:
          zzR = false;
          yycolumn++;
        }
      }

      if (zzR) {
        // peek one character ahead if it is \n (if we have counted one line too much)
        boolean zzPeek;
        if (zzMarkedPosL < zzEndReadL)
          zzPeek = zzBufferL[zzMarkedPosL] == '\n';
        else if (zzAtEOF)
          zzPeek = false;
        else {
          boolean eof = zzRefill();
          zzEndReadL = zzEndRead;
          zzMarkedPosL = zzMarkedPos;
          zzBufferL = zzBuffer;
          if (eof) 
            zzPeek = false;
          else 
            zzPeek = zzBufferL[zzMarkedPosL] == '\n';
        }
        if (zzPeek) yyline--;
      }
      zzAction = -1;

      zzCurrentPosL = zzCurrentPos = zzStartRead = zzMarkedPosL;
  
      zzState = ZZ_LEXSTATE[zzLexicalState];


      zzForAction: {
        while (true) {
    
          if (zzCurrentPosL < zzEndReadL)
            zzInput = zzBufferL[zzCurrentPosL++];
          else if (zzAtEOF) {
            zzInput = YYEOF;
            break zzForAction;
          }
          else {
            // store back cached positions
            zzCurrentPos  = zzCurrentPosL;
            zzMarkedPos   = zzMarkedPosL;
            boolean eof = zzRefill();
            // get translated positions and possibly new buffer
            zzCurrentPosL  = zzCurrentPos;
            zzMarkedPosL   = zzMarkedPos;
            zzBufferL      = zzBuffer;
            zzEndReadL     = zzEndRead;
            if (eof) {
              zzInput = YYEOF;
              break zzForAction;
            }
            else {
              zzInput = zzBufferL[zzCurrentPosL++];
            }
          }
          int zzNext = zzTransL[ zzRowMapL[zzState] + zzCMapL[zzInput] ];
          if (zzNext == -1) break zzForAction;
          zzState = zzNext;

          int zzAttributes = zzAttrL[zzState];
          if ( (zzAttributes & 1) == 1 ) {
            zzAction = zzState;
            zzMarkedPosL = zzCurrentPosL;
            if ( (zzAttributes & 8) == 8 ) break zzForAction;
          }

        }
      }

      // store back cached position
      zzMarkedPos = zzMarkedPosL;

      switch (zzAction < 0 ? zzAction : ZZ_ACTION[zzAction]) {
        case 45: 
          { return symbol(DEC);
          }
        case 63: break;
        case 59: 
          { return symbol(RETURN);
          }
        case 64: break;
        case 5: 
          { return symbol(ID, yytext());
          }
        case 65: break;
        case 4: 
          { return symbol(MUL);
          }
        case 66: break;
        case 19: 
          { return symbol(LT);
          }
        case 67: break;
        case 38: 
          { return symbol(SHL);
          }
        case 68: break;
        case 56: 
          { return symbol(UNION);
          }
        case 69: break;
        case 28: 
          { return symbol(MUL_ASSIGN);
          }
        case 70: break;
        case 27: 
          { return symbol(DIV_ASSIGN);
          }
        case 71: break;
        case 26: 
          { return symbol(DOT);
          }
        case 72: break;
        case 10: 
          { return symbol(COMMA);
          }
        case 73: break;
        case 15: 
          { return symbol(RSQBRA);
          }
        case 74: break;
        case 13: 
          { return symbol(RCUBRA);
          }
        case 75: break;
        case 53: 
          { return symbol(VOID);
          }
        case 76: break;
        case 36: 
          { return symbol(AND_L);
          }
        case 77: break;
        case 7: 
          { return symbol(LPAREN);
          }
        case 78: break;
        case 61: 
          { return symbol(STRUCT);
          }
        case 79: break;
        case 24: 
          { return symbol(TILDE);
          }
        case 80: break;
        case 43: 
          { return symbol(SUB_ASSIGN);
          }
        case 81: break;
        case 55: 
          { return symbol(ELSE);
          }
        case 82: break;
        case 60: 
          { return symbol(SIZEOF);
          }
        case 83: break;
        case 21: 
          { return symbol(ADD);
          }
        case 84: break;
        case 42: 
          { return symbol(INC);
          }
        case 85: break;
        case 49: 
          { return symbol(INT);
          }
        case 86: break;
        case 40: 
          { return symbol(SHR);
          }
        case 87: break;
        case 18: 
          { return symbol(AND);
          }
        case 88: break;
        case 25: 
          { return symbol(NOT_L);
          }
        case 89: break;
        case 2: 
          { /*ignore*/
          }
        case 90: break;
        case 6: 
          { return symbol(CONSTINT, yytext());
          }
        case 91: break;
        case 3: 
          { return symbol(DIV);
          }
        case 92: break;
        case 54: 
          { return symbol(CHAR);
          }
        case 93: break;
        case 30: 
          { return symbol(IF);
          }
        case 94: break;
        case 9: 
          { return symbol(SEMI);
          }
        case 95: break;
        case 29: 
          { return symbol(CONSTSTR, yytext());
          }
        case 96: break;
        case 23: 
          { return symbol(MOD);
          }
        case 97: break;
        case 16: 
          { return symbol(OR);
          }
        case 98: break;
        case 31: 
          { return symbol(EQ);
          }
        case 99: break;
        case 44: 
          { return symbol{PTR};
          }
        case 100: break;
        case 41: 
          { return symbol(ADD_ASSIGN);
          }
        case 101: break;
        case 22: 
          { return symbol(SUB);
          }
        case 102: break;
        case 48: 
          { return symbol(CONSTCHAR, yytext());
          }
        case 103: break;
        case 47: 
          { return symbol(NE);
          }
        case 104: break;
        case 1: 
          { System.out.print((int)yytext[0]); yyerror("invalid character");
          }
        case 105: break;
        case 62: 
          { return symbol(CONTINUE);
          }
        case 106: break;
        case 51: 
          { return symbol(SHL_ASSIGN);
          }
        case 107: break;
        case 34: 
          { return symbol(XOR_ASSIGN);
          }
        case 108: break;
        case 8: 
          { return symbol(RPAREN);
          }
        case 109: break;
        case 14: 
          { return symbol(LSQBRA);
          }
        case 110: break;
        case 39: 
          { return symbol(GE);
          }
        case 111: break;
        case 12: 
          { return symbol(LCUBRA);
          }
        case 112: break;
        case 37: 
          { return symbol(LE);
          }
        case 113: break;
        case 58: 
          { return symbol(BREAK);
          }
        case 114: break;
        case 50: 
          { return symbol(FOR);
          }
        case 115: break;
        case 57: 
          { return symbol(WHILE);
          }
        case 116: break;
        case 32: 
          { return symbol(OR_ASSIGN);
          }
        case 117: break;
        case 46: 
          { return symbol(MOD_ASSIGN);
          }
        case 118: break;
        case 17: 
          { return symbol(XOR);
          }
        case 119: break;
        case 20: 
          { return symbol{GT};
          }
        case 120: break;
        case 33: 
          { return symbol(OR_L);
          }
        case 121: break;
        case 52: 
          { return symbol(SHR_ASSIGN);
          }
        case 122: break;
        case 11: 
          { return symbol(EVA);
          }
        case 123: break;
        case 35: 
          { return symbol(AND_ASSIGN);
          }
        case 124: break;
        default: 
          if (zzInput == YYEOF && zzStartRead == zzCurrentPos) {
            zzAtEOF = true;
            zzDoEOF();
              { return new java_cup.runtime.Symbol(sym.EOF); }
          } 
          else {
            zzScanError(ZZ_NO_MATCH);
          }
      }
    }
  }


}
