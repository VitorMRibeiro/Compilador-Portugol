BIN = bin

analisador: Portugol_Parser.y Portugol_Scanner.l tabelaSimbolos.c tabelaSimbolos.h
	bison -d Portugol_Parser.y
	flex Portugol_Scanner.l
	
	if [ ! -d "$(BIN)" ]; then  \
		mkdir bin;              \
	fi
	gcc -g lex.yy.c Portugol_Parser.tab.c TabelaSimbolos.c Portugol_Parser.tab.h TabelaSimbolos.h -o bin\analisador.exe
	
	rm Portugol_Parser.tab.h
	rm  Portugol_Parser.tab.c
	rm lex.yy.c

