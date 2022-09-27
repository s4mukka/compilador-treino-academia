from abc import ABC, abstractmethod

class GenericStep(ABC):
    def __init__(self):
        self._next_step: GenericStep = None
        self._step = ''
    
    def set_next_step(self, next_step):
        self._next_step = next_step
    
    def next_step(self):
        print('STEP:',self._step)
        self.handle()
        return self._next_step
    
    @abstractmethod
    def handle(self):
        raise NotImplementedError("Faltou implementar aqui...")