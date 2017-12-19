BIN = bin

analisador: Portugol_Parser.y Portugol_Scanner.l tabelaSimbolos.c tabelaSimbolos.h arvoreSintatica.h arvoreSintatica.c AnalisadorSemantico.c
	bison -d Portugol_Parser.y
	flex Portugol_Scanner.l
	
	if [ ! -d "$(BIN)" ]; then  \
		mkdir bin;              \
	fi
	gcc -g lex.yy.c AnalisadorSemantico.c Portugol_Parser.tab.c TabelaSimbolos.c Portugol_Parser.tab.h TabelaSimbolos.h arvoreSintatica.h arvoreSintatica.c -o bin\analisador
	
	rm Portugol_Parser.tab.h
	rm  Portugol_Parser.tab.c
	rm lex.yy.c

