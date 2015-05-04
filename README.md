##Java-scanner For the Language, TinyOne

Compiler를 크게 두 부분으로 나누면, *Front-end*와 *Back-end*가 있을 것입니다.
그 중, Front-end 부분에는 *Parser*와 *Scanner*가 있습니다.
**Parser는 Syntax Analyzing**을 담당하며, Scanner는 **Lexical Analyzing**을 담당합니다.

**"Java-Scanner for TinyOne"**은 가상의 언어 *TinyOne*에 대하여,
Lexical Analyzing을 통하여 **Token**을 생성해줍니다.

여기서 생성된 Token은, Parser에 의해 Parsing tree 등으로 구문 분석에 이용될 것 입니다.
