package tinyone.scanner;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.util.Arrays;
import java.util.logging.Logger;

public class TinyOneScanner {
	private static final Logger logger = Logger.getLogger(TinyOneScanner.class.getName());
	
	
	private static final char eofCh = '\u0080';
	private static final char eol = '\n';
	private static final int  // token codes
		none      = 0,		identifier  = 1,		number    = 2,		charCon   = 3,
		plus      = 4,		minus     = 5,			times     = 6,			slash     = 7,
		rem       = 8,		eql       = 9,			neq       = 10,			lss       = 11,
		leq       = 12,		gtr       = 13,			geq       = 14,			assign    = 15,
		semicolon = 16,	comma     = 17,		period    = 18,		lpar      = 19,
		rpar      = 20,		lbrack    = 21,			rbrack    = 22,			lbrace    = 23,
		rbrace    = 24,		begin_ = 25,			double_= 26,			else_= 27,
		end_= 28,			eof=29,		if_= 30,	integer_= 31,  		new_= 32,
		nextDouble_= 33,	nextInteger_= 34,		nextLine_= 35,
		print_= 36,			print_line_= 37,		program_= 38,		string_= 39,
		while_= 40,		increment_ = 41,		decrement_ = 42,		err = -1;
	
	private static final String key[] = { // sorted list of keywords
		"begin", "double", "else", "end", "if", "integer",
		"new", "nextDouble","nextInteger","nextLine","print", "print_line",
		"program", "string", "while"
	};
	private static final int keyVal[] = {
		begin_, double_, else_, end_, if_, integer_,
		new_, nextDouble_,nextInteger_,nextLine_,print_, print_line_,
		program_, string_, while_
	};
	private static char ch;
	public  static int col;
	public  static int line;
	private static int pos;
	private static Reader in;
	private static char[] lex;

	private static void nextCh() {
		try {
			ch = (char)in.read(); col++; pos++;
			if (ch == eol) {line++; col = 0;}
			else if (ch == '\uffff') ch = eofCh;
		} catch (IOException e) {
			ch = eofCh;
		}
	}
	
	public static void init(Reader r) {
		in = new BufferedReader(r);
		lex = new char[64];
		line = 1; col = 0;
		nextCh();
	}

	public static TinyOneToken next() {
		while (ch <= ' ') nextCh(); // skip blanks, tabs, eols
		
		TinyOneToken t = new TinyOneToken();
		t.line = line;
		t.col = col;
		
		switch (ch) {
			case 'a': case 'b': case 'c':	case 'd': case 'e': case 'f':
			case 'g': case 'h': case 'i': 	case 'j': case 'k': case 'l':
			case 'm': case 'n': case 'o':	case 'p': case 'q': case 'r':
			case 's': case 't': case 'u':	case 'v': case 'w': case 'x':
			case 'y': case 'z': case 'A': 	case 'B': case 'C':
			case 'D': case 'E': case 'F':	case 'G': case 'H': case 'I':
			case 'J': case 'K': case 'L':	case 'M': case 'N': case 'O':
			case 'P': case 'Q': case 'R':	case 'S': case 'T': case 'U':
			case 'V': case 'W': case 'X':	case 'Y': case 'Z':
				readName(t); break;
				
				
			case '0': case '1': case '2':	case '3': case '4': case '5':
			case '6': case '7': case '8':	case '9':	
				readNumber(t); break;
				
				
			case ';': nextCh(); t.kind = semicolon; break;
			case '.': nextCh(); t.kind = period; break;
			case eofCh: t.kind = eof; break;
			
			case ',': nextCh(); t.kind = comma; break;
					
			
			case '=': nextCh();				
				if (ch == '=') { nextCh(); t.kind = eql; }
				else{ t.kind = assign;}
				break;
			case '+': nextCh();				
				if (ch == '+') { nextCh();	t.kind = increment_;}				
				else{ t.kind = plus;}
				break;
			
			case '-': nextCh();				
				if (ch == '-') { nextCh(); t.kind = decrement_; }
				else{ t.kind = minus;}
				break;
			
			case '*': nextCh(); t.kind = times; break;
			
			case '!': nextCh();				
				if (ch == '=') { nextCh(); t.kind = neq; }
				else{ t.kind = err;}
				break;
			
			case '<': nextCh();				
				if (ch == '=') { nextCh(); t.kind = leq; }
				else{ t.kind = lss;}
				break;
				
			case '>': nextCh();				
				if (ch == '=') { nextCh(); t.kind = geq; }
				else{ t.kind = gtr;}
				break;
				
			case '"': readCharCon(t); break;	
				
			
			case '[': nextCh(); t.kind = lbrack; break;
			case '{': nextCh(); t.kind = lbrace; break;
			case '(': nextCh(); t.kind = lpar; break;
			
			
			case ']': nextCh(); t.kind = rbrack; break;
			case '}': nextCh(); t.kind = rbrace; break;
			case ')': nextCh(); t.kind = rpar; break;
			
			
				
			
			case '/': nextCh();
				if (ch == '/'){
					do nextCh(); while (ch != '\n' && ch != eofCh);
					t = next();
				}else t.kind = slash;
				break;				
				
			
			default: nextCh(); t.kind = none; break;
		}
		
		return t;
	}
	
	private static void readName(TinyOneToken t){

		StringBuilder sb = new StringBuilder();
        do {
            sb.append(ch);
            nextCh();
        } while (isLetter(ch) || isDigit(ch) || ch == '_');
        
        t.string = sb.toString();
        t.kind = keywordKind(t.string);
        t.val= keywordKind(t.string);
	}
	
	private static void readNumber(TinyOneToken t){
		StringBuilder sb = new StringBuilder();
        do {
            sb.append(ch);
            nextCh();
        } while (isDigit(ch));
        
        t.string = sb.toString();
        t.kind = number;
        
        try {
            t.val = Integer.valueOf(t.string);
        } catch (StackOverflowError e) {
            System.out.println("Number to big: " + t.string);
        }
	}
	
	private static boolean isLetter(char c){
        return ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z');
    }

	private static boolean isDigit(char c){
        return '0' <= c && c <= '9';
    }
	
	private static int keywordKind(String str){
		
		int flag = Arrays.binarySearch(key, str);
		
		return (Integer) ((flag>=0) ? keyVal[flag] : identifier);
    }
	
	private static void readCharCon(TinyOneToken t){
		StringBuilder sb = new StringBuilder();
        do {
            sb.append(ch);
            nextCh();
        } while (!isQuote(ch));
        sb.append(ch);
        nextCh();
        
        
        t.string = sb.toString();
        t.kind = charCon;        
       
	}
	
	private static boolean isQuote(char c){
		return (c == '\'' ||  c == '\"');
	}

}