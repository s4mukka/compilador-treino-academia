import sys
from antlr4 import FileStream, CommonTokenStream
from src.steps import StepLexicalAnalyzer, StepSemanticAnalyzer, StepSyntaticAnalyzer

if __name__ == "__main__":
    try:
        entrada = str(sys.argv[1])
        saida = str(sys.argv[2])

        input = FileStream(entrada, encoding='utf-8')
        output = open(saida, 'w')

        # Instancia as classes
        lexer = StepLexicalAnalyzer(input, output)
        stream = CommonTokenStream(lexer)
        parser = StepSyntaticAnalyzer(stream, output)

        lexer.set_next_step(parser)
        parser.set_next_step(None)
        tree = parser.handle()
        visitor = StepSemanticAnalyzer(tree, output)
        visitor.handle()
        # step = lexer.next_step()
        # while (step := step.next_step()) is not None:
            # pass

        output.close()
    except Exception:
        output.write('Fim da compilacao\n')
