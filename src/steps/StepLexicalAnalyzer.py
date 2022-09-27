from src.lexer import TreinoLexer
from antlr4 import Token
from antlr4.error.Errors import LexerNoViableAltException
from re import match

from .GenericStep import GenericStep

class StepLexicalAnalyzer(TreinoLexer, GenericStep):
    _step = 'Lexer'

    def handle(self):
        """ Executa o analisador léxico """
        while self.nextToken().type is not Token.EOF:
            pass

    def notifyListeners(self, e:LexerNoViableAltException):
        start = self._tokenStartCharIndex
        stop = self._input.index
        text = self._input.getText(start, stop)
        msg = f'{text} - simbolo nao identificado'
        if match(r'"[^"]+', text):
            msg = "cadeia literal nao fechada"
        self._output.write(f"Linha {self._tokenStartLine}: {msg}\n")
        raise Exception()