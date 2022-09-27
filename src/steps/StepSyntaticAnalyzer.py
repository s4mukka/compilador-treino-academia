from src.lexer import TreinoParser
from antlr4 import Token
from antlr4.error.Errors import RecognitionException
from re import match

from .GenericStep import GenericStep

class StepSyntaticAnalyzer(TreinoParser, GenericStep):
    _step = 'Parser'

    def handle(self):
        """ Executa o analisador sintático """
        return self.programa()

    def notifyErrorListeners(self, msg:str, offendingToken:Token = None, e:RecognitionException = None):
        if offendingToken is None:
            offendingToken = self.getCurrentToken()
        self._syntaxErrors += 1
        line = offendingToken.line
        msg = f'erro sintatico proximo a {offendingToken.text}'
        self._output.write(f"Linha {line}: {msg}\n")
        raise Exception()
