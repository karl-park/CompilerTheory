package tinyone.scanner;

public class TinyOneToken {
	public int kind;		// token 종류
	public int line;		// token 줄 번호
	public int col;			// token 토큰 컬럼
	public int val;			// token value (for number and charConst)
	public String string;	// token string
}
