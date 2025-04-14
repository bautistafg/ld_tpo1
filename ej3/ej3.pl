:- use_module(library(clpfd)).  

% Ejercicio 3: Resolver el problema de criptarithmetic "FELIZ + DIA + DEL = PADRE" usando CLP(FD).
resolver_cripto(ListaDeVariables) :-
    ListaDeVariables = [F, E, L, I, Z, D, A, P, R],

    % Restriccion (1): Todas las variables son diferentes y su dominio es 0..9
    ListaDeVariables ins 0..9,
    all_distinct(ListaDeVariables),
  
    % Restriccion(2): FELIZ + DIA + DEL = PADRE
    (F*10000 + E*1000 + L*100 + I*10 + Z) + (D*100 + I*10 + A) +(D*100 + E*10 + L) #= (P*10000 + A*1000 + D*100 + R*10 + E),

    % Restriccion (3): Ninguno debe iniciar por cero
    F#\=0, 
    D#\=0,
    P#\=0,

    label(ListaDeVariables). 