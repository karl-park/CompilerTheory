package tinyone.scanner;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;

public class TinyOneScannerTest {
	private static final int  // token codes
		none      = 0,
		identifier     = 1,
		number    = 2,
		charCon   = 3,
		plus      = 4,
		minus     = 5,
		times     = 6,
		slash     = 7,
		rem       = 8,
		eql       = 9,
		neq       = 10,
		lss       = 11,
		leq       = 12,
		gtr       = 13,
		geq       = 14,
		assign    = 15,
		semicolon = 16,
		comma     = 17,
		period    = 18,
		lpar      = 19,
		rpar      = 20,
		lbrack    = 21,
		rbrack    = 22,
		lbrace    = 23,
		rbrace    = 24,		
		begin_ = 25,
		double_= 26,
		else_= 27,
		end_= 28,
		eof = 29,
		if_= 30,
		integer_= 31,
		new_= 32,
		nextDouble_= 33,
		nextInteger_= 34,
		nextLine_= 35,
		print_= 36,
		print_line_= 37,
		program_= 38,
		string_= 39,
		while_= 40,		
		increment_ = 41,
		decrement_ = 42,

		err = -1;

	private static String[] tokenName = {
		"none",
		"identifier",
		"number ",
		"char   ",
		"+",
		"-",
		"*",
		"/",
		"%",
		"==",
		"!=",
		"<",
		"<=",
		">",
		">=",
		"=",
		"terminator;",
		",",
		".",
		"lpar(",
		"rpar)",
		"lbrak[",
		"rbrak]",
		"lbrace{",
		"rbrace}",
		
		"begin", "double", "else", "end","eof", "if", "integer",
		"new", "nextDouble","nextInteger","nextLine","print", "print_line",
		"program", "string", "while","increment","decrement","ERR"
	};

	public static void main(String args[]) {
		TinyOneToken t;
		Scanner scan = new Scanner(System.in);
	
		System.out.print("Please Type the File name : ");
		String sourceFile = "";
		sourceFile = scan.nextLine();		
		
		try {
			TinyOneScanner.init(new InputStreamReader(new FileInputStream(sourceFile)));
			
			System.out.println("token\t\tstring");
			System.out.println("---------------------------------");
			
			do {
				t = TinyOneScanner.next();					
				
				System.out.print( t.kind >= 0 ? tokenName[t.kind] : "ERR");
				switch (t.kind) {
					case none:   System.out.println("\t\twhite spaces"); break;
					case identifier:   System.out.println("\t"+t.string); break;
					case number:  System.out.println("\t\t"+t.val); break;
					case charCon: System.out.println("\t\t"+t.string); break;
					
					case plus      : System.out.println("\t\t"+tokenName[t.kind]); break;
					case minus     : System.out.println("\t\t"+tokenName[t.kind]); break;
					case times     : System.out.println("\t\t"+tokenName[t.kind]); break;
					case slash     : System.out.println("\t\t"+tokenName[t.kind]); break;
					case rem       : System.out.println("\t\t"+tokenName[t.kind]); break;
					case eql       : System.out.println("\t\t"+tokenName[t.kind]); break;	
					
					case neq           : System.out.println("\t\t"+tokenName[t.kind]); break;
					case lss            : System.out.println("\t\t"+tokenName[t.kind]); break;
					case leq            : System.out.println("\t\t"+tokenName[t.kind]); break;
					case gtr            : System.out.println("\t\t"+tokenName[t.kind]); break;
					case geq           : System.out.println("\t\t"+tokenName[t.kind]); break;
					case assign       : System.out.println("\t\t"+tokenName[t.kind]); break;						
					case semicolon  : System.out.println("\t"+tokenName[t.kind]); break;
					case comma 		: System.out.println("\t\t"+tokenName[t.kind]); break;
					case period        : System.out.println("\t\t"+tokenName[t.kind]); break;
					case lpar           : System.out.println("\t\t"+tokenName[t.kind]); break;
					case rpar           : System.out.println("\t\t"+tokenName[t.kind]); break;
					case lbrack        : System.out.println("\t\t"+tokenName[t.kind]); break;
					case rbrack            : System.out.println("\t\t"+tokenName[t.kind]); break;
					case lbrace            : System.out.println("\t\t"+tokenName[t.kind]); break;
					case rbrace            : System.out.println("\t\t"+tokenName[t.kind]); break;
					
					case begin_           : System.out.println("\t\t"+tokenName[t.kind]); break;
					case double_             : System.out.println("\t\t"+tokenName[t.kind]); break;
					case else_            : System.out.println("\t\t"+tokenName[t.kind]); break;
					case end_               : System.out.println("\t\t"+tokenName[t.kind]); break;
					case eof				: System.out.println("\t\t"+tokenName[t.kind]); break;
					case if_           : System.out.println("\t\t"+tokenName[t.kind]); break;
					case integer_          : System.out.println("\t\t"+tokenName[t.kind]); break;
					case new_             : System.out.println("\t\t"+tokenName[t.kind]); break;
					case nextDouble_           : System.out.println("\t\t"+tokenName[t.kind]); break;
					
					case nextInteger_                  : System.out.println("\t"+tokenName[t.kind]); break;
					case nextLine_               : System.out.println("\t"+tokenName[t.kind]); break;
					case print_                    : System.out.println("\t\t"+tokenName[t.kind]); break;
					
					case print_line_                  : System.out.println("\t"+tokenName[t.kind]); break;
					case program_               : System.out.println("\t\t"+tokenName[t.kind]); break;
					case string_                    : System.out.println("\t\t"+tokenName[t.kind]); break;
					
					case while_                  : System.out.println("\t\t"+tokenName[t.kind]); break;
					case increment_               : System.out.println("\t"+tokenName[t.kind]); break;
					case decrement_                    : System.out.println("\t"+tokenName[t.kind]); break;
					
					
					default: System.out.println(); break;
				}
			} while (t.kind != eof);
			
			System.out.println("---------------------------------");
			System.out.println("Scanning Completed.");
			
		} catch (IOException e) {
			System.out.println("We can not open the file : " + sourceFile);
		}	
	}

}