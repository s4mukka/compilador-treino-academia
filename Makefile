ifeq ($(shell uname), Linux)
	PATHSEP=/
else
	PATHSEP=\\
endif

PWD=$(shell pwd)
RA_GROUP="769806,769769"
ANTLRLEXFILE=Treino
ANTLRDIR=$(PWD)$(PATHSEP)jar$(PATHSEP)antlr-4.10.1-complete.jar
CORRETORDIR=$(PWD)$(PATHSEP)jar$(PATHSEP)corretor-automatico.jar
TEMPDIR=$(PWD)$(PATHSEP)temp
T?=t1

run: lexer
	python -m src.main "entrada.txt" "saida.txt"

lexer: clean
	java -Xmx500M -cp "$(ANTLRDIR)" org.antlr.v4.Tool\
		-Dlanguage=Python3 "$(PWD)$(PATHSEP)antlr$(PATHSEP)$(ANTLRLEXFILE).g4"\
		-visitor\
		-o "$(PWD)$(PATHSEP)src$(PATHSEP)lexer"

clean:
	rm -rf "$(PWD)$(PATHSEP)src$(PATHSEP)lexer$(PATHSEP)$(ANTLRLEXFILE)Lexer.py"\
		"$(PWD)$(PATHSEP)src$(PATHSEP)lexer$(PATHSEP)$(ANTLRLEXFILE)Listener.py"\
		"$(PWD)$(PATHSEP)src$(PATHSEP)lexer$(PATHSEP)$(ANTLRLEXFILE)Parser.py"\
		"$(PWD)$(PATHSEP)src$(PATHSEP)lexer$(PATHSEP)$(ANTLRLEXFILE)Lexer.tokens"\
		"$(PWD)$(PATHSEP)src$(PATHSEP)lexer$(PATHSEP)$(ANTLRLEXFILE)Lexer.interp"\
		"$(PWD)$(PATHSEP)src$(PATHSEP)lexer$(PATHSEP)$(ANTLRLEXFILE).tokens"\
		"$(PWD)$(PATHSEP)src$(PATHSEP)lexer$(PATHSEP)$(ANTLRLEXFILE).interp"\
		"$(PWD)$(PATHSEP)temp"

test: lexer
	java -jar "$(CORRETORDIR)" "python -m src.main" gcc\
		"$(PWD)$(PATHSEP)temp" "$(PWD)$(PATHSEP)casos-de-teste"\
		"$(RA_GROUP)" "$(T)"
