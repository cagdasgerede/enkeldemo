grammar Enkel;

// parser rules
compilationUnit : ( variable | print )* EOF;
variable : VARIABLE ID EQUALS value;
print : PRINT ID ;
value : NUMBER | STRING ;


// lexer rules
VARIABLE : 'var' ;
EQUALS : '=' ;
PRINT : 'print' ;
NUMBER : [0-9]+ ;
STRING: '"'.*?'"' ;
ID : [a-zA-Z0-9]+ ;
COMMENT : '//' ~('\n')* '\n' -> skip;
WS : [ \n\t\r]+ -> skip;
