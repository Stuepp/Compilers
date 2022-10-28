# Compilers
  - transforma_romano -> terminar
  - Implementar foco:
    - -> Qual é o tipo de yyext?
    - -> Como botar o yyext na lista?
    - -> Trocar o nome de table nas funções para list
  - implementar extra:
    - -> Número real com qualquer representação
    - -> Números de telefone válidos no Brasil
    - -> Ocultador de Textos
    
    ----------------------
    Utilizar o sistema de árvore binária + pilha do trabalho de Compiladores para montar a estrutura do Compilador em Compiladores..
A lógica é para ficar mais simples de identificar que um {, (, [ não foram fechados,
pois eles crescem na pilha, e esse elemento da pilha referência eles.
Em vez da árvore pode manter uma lista, mas mantendo a lógica vai acabar por se gerar uma árvore mesmo.
Essa ideia é boa? Vai dar mais trabalho do que apenas implementar uma lista simples? Vale a pena o esforço?
