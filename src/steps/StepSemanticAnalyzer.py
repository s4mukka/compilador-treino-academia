from typing import List, TextIO
from src.lexer import TreinoVisitor, TreinoParser

from .GenericStep import GenericStep

class StepSemanticAnalyzer(TreinoVisitor, GenericStep):
    _step = 'Parser'

    def __init__(self, tree, output: TextIO):
        self._tree = tree
        self._output = output
        self._tipo = None
        self._objetivo = None

    def handle(self):
        """ Executa o analisador sintático """
        self.visit(self._tree)

    def handle_error(self, line, msg):
        self._output.write(f'Linha {line}: {msg}\n')
        raise Exception()

    def visitPrograma(self, programa: TreinoParser.ProgramaContext):
        self.cabecalho_validate(programa.cabecalho())
        self.treino_validate(programa.treino())

    def cabecalho_validate(self, cabecalho: List[TreinoParser.CabecalhoContext]):
        template = ['personal', 'cliente', 'academia', 'tipo', 'objetivo']
        for declaration in cabecalho:
            text = declaration.start.text.replace(':','')
            if text in template:
                template.remove(text)
                if declaration.TIPO():
                    self._tipo = declaration.TIPO().getText()
                elif declaration.OBJETIVO():
                    self._objetivo = declaration.OBJETIVO().getText()
            else:
                self.handle_error(declaration.start.line, f'{text} ja declarado no cabecalho anteriormente')
        for missed in template:
            self.handle_error(0, f'{missed} nao declarado no cabecalho')

    def treino_validate(self, treino: List[TreinoParser.TreinoContext]):
        for i, training in enumerate(treino):
            if (i + 1) > len(self._tipo):
                self.handle_error(training.start.line, f'quantidade de treinos excedido')
