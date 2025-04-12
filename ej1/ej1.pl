% Hechos
hombre(juan).
mujer(maria).

% Regla
es_humano(X) :- hombre(X).
es_humano(X) :- mujer(X).
