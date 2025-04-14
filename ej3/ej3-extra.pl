:- use_module(library(clpfd)).  

% Ejercicio 3: Resolver el problema de criptarithmetic "FELIZ + FELIZ + DIA = MAMAS" usando CLP(FD).
resolver_cripto_pls(ListaDeVariables) :-
    ListaDeVariables = [F, E, L, I, Z, D, A, M,A2,S],

    % Restriccion (1): Todas las variables son diferentes y su dominio es 0..9
    ListaDeVariables ins 0..9,
    all_distinct(ListaDeVariables),
  
    % Restriccion(2): FELIZ + DIA + DEL = PADRE
    (F*10000 + E*1000 + L*100 + I*10 + Z) + (F*10000 + E*1000 + L*100 + I*10 + Z) + (D*100 + I*10 + A)  #= (M*10000 + A*1000 + M*100 + A2*10+S), 

    % Restriccion (3): Ninguno debe iniciar por cero
    F#\=0, 
    D#\=0, 
    M#\=0,

    label(ListaDeVariables). 