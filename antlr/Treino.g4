grammar Treino;

PALAVRAS_CHAVES : 'personal' | 'cliente' | 'academia' | 'tipo' | 'objetivo' | 'treino';

TIPO : 'ABC' | 'ABCD' | 'ABCDE';

OBJETIVO : 'emagrecimento' | 'hipertrofia';

TREINO: 'peito' | 'costa' | 'biceps' | 'triceps' | 'perna' | 'ombro';

PEITO: 'supino_reto' | 'supino_inclinado' | 'crucifixo_declinado';
COSTA: 'puxador_supinado' | 'remada_curvada' | 'remada_baixa';
BICEPS: 'rosca_direta' | 'rosca_unilateral' | 'rosca_martelo';
TRICEPS: 'triceps_testa' | 'triceps_pulley' | 'triceps_corda';
PERNA: 'extensora' | 'abdutor' | 'leg_press';
OMBRO: 'elevacao_lateral' | 'elevacao_frontal' | 'encolhimento';
ABDOMINAL: 'abdominal_canivete' | 'abdominal_infra' | 'prancha';
CARDIO: 'esteira' | 'bicicleta' | 'eliptico';

NUMERO: [0-9]+;

SERIE: NUMERO 'x' NUMERO ('\''|'"')? | NUMERO ('\''|'"');

ABRE_COLCHETES : '[';
FECHA_COLCHETES : ']';
CADEIA: '"' ~('"'|'\r'|'\n')* '"';
COMENTARIO: '--' ~('\r'|'\n')* -> skip;
SEPARADOR: ';' | ',';
DOIS_PONTOS: ':';

WB: ([ \t\r\n]) -> skip;

programa:
    cabecalho* treino*;

cabecalho:
    'personal:' CADEIA |
    'cliente:' CADEIA |
    'academia:' CADEIA |
    'tipo:' TIPO |
    'objetivo:' OBJETIVO
    ;

treino:
    'treino' TREINO (',' TREINO)* ABRE_COLCHETES exercicio* FECHA_COLCHETES;

exercicio:
    (PEITO | COSTA | BICEPS | TRICEPS | PERNA | OMBRO | ABDOMINAL | CARDIO) ':' SERIE ';';