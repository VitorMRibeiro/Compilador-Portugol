analisador: Portugol_Parser.y Portugol_Scanner.l
			bison -d Portugol_Parser.y
			flex Portugol_Scanner.l
			gcc lex.yy.c Portugol_Parser.tab.c tabelaSimbolos.c Portugol_Parser.tab.h TabelaSimbolos.h -o analisador.exe