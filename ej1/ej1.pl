:- use_module(library(clpfd)).

% metodo principal para encontrar solución al problema proporcionado
resolver_ajedrez(Posiciones) :- 
% 1. se representan las posiciones de las piezas dividiendo en filas y columnas
    PosicionesPiezas = [FilaReina, ColReina, FilaAlfil, ColAlfil, FilaCaballo, ColCaballo, FilaTorre, ColTorre], 
    PosicionesPiezas ins 1..8, %tanto filas como columnas van del 1 al 8
% 2. linealizo las posiciones para simplificar el proceso de establecer que las piezas no puedan estar en una misma posicion
    PosicionesLinealizadas = [PosReina, PosAlfil, PosCaballo, PosTorre], 
    PosicionesLinealizadas ins 1..64,
    % por cada pieza (fila,columna) obtengo su equivalente en un numero del 1 al 64
    % que representa la posicion en la que se encuentra de manera linealizada
    PosReina   #= (FilaReina - 1) * 8 + ColReina, 
    PosAlfil   #= (FilaAlfil - 1) * 8 + ColAlfil,
    PosCaballo #= (FilaCaballo - 1) * 8 + ColCaballo,
    PosTorre   #= (FilaTorre - 1) * 8 + ColTorre,
    all_different(PosicionesLinealizadas), % aca se garantiza que sean distintas
% 3. las casillas marcadas en el inciso las guardo en una lista.
% cada casilla marcada indica su fila, columna y numero de piezas que la atacan
% (fila,columna,nro. de piezas)
    CasillasMarcadas = [
        casilla(1, 4, 2),
        casilla(2, 1, 2), casilla(2, 5, 4),
        casilla(4, 1, 2), casilla(4, 5, 3), casilla(4, 7, 2),
        casilla(5, 2, 2), casilla(5, 4, 2),
        casilla(6, 1, 2), casilla(6, 3, 2), casilla(6, 7, 2),
        casilla(8, 5, 2)
    ],
% 4. aplico las restricciones de ataque en un modulo auxiliar
    aplicar_restricciones_ataque(CasillasMarcadas, FilaReina, ColReina, FilaAlfil, ColAlfil, FilaCaballo, ColCaballo, FilaTorre, ColTorre),
% 5. hago labelling para obtener los valores exactos de la lista de posiciones 
    labeling([], PosicionesPiezas),
% 6. finalmente represento los valores de manera entendible 
    Posiciones = [reina(FilaReina, ColReina), alfil(FilaAlfil, ColAlfil), caballo(FilaCaballo, ColCaballo), torre(FilaTorre, ColTorre)].

% metodo auxiliar que se encarga de verificar las restricciones de ataque
aplicar_restricciones_ataque([], _, _, _, _, _, _, _, _). % caso base, ya se recorrio toda la lista de casillas
aplicar_restricciones_ataque([casilla(Fila, Col, NumAtaques) | Resto], % paso recursivo
                             FilaReina, ColReina,
                             FilaAlfil, ColAlfil,
                             FilaCaballo, ColCaballo,
                             FilaTorre, ColTorre) :-

    
    [AtacaReina, AtacaAlfil, AtacaCaballo, AtacaTorre] ins 0..1, % variables booleanas que indican si la casilla es atacada o no por la pieza
    


    % logica para la reina. ataca si está en la misma fila, columna o diagonal
    ( (FilaReina #\= Fila #\/ ColReina #\= Col)
      #/\ ( (FilaReina #= Fila) #\/ (ColReina #= Col) #\/ (abs(FilaReina - Fila) #= abs(ColReina - Col)) )
    ) #<==> AtacaReina,

    % logica para el alfil: ataca si está en una diagonal 
    ( (FilaAlfil #\= Fila #\/ ColAlfil #\= Col)
      #/\ (abs(FilaAlfil - Fila) #= abs(ColAlfil - Col))
    ) #<==> AtacaAlfil,

    % logica para el caballo: ataca si se encuentra a 2x1 o 1x2 casillas de distancia
    ( (FilaCaballo #\= Fila #\/ ColCaballo #\= Col)
      #/\ ( (abs(FilaCaballo - Fila) #= 2 #/\ abs(ColCaballo - Col) #= 1)
          #\/ (abs(FilaCaballo - Fila) #= 1 #/\ abs(ColCaballo - Col) #= 2) )
    ) #<==> AtacaCaballo,

    % logica para la torre: ataca si está en la misma fila o columna
    ( (FilaTorre #\= Fila #\/ ColTorre #\= Col)
      #/\ ( (FilaTorre #= Fila) #\/ (ColTorre #= Col) )
    ) #<==> AtacaTorre,

    % la suma de los ataques debe coincidir con el numero de ataques correspondientes a esa casilla: ni mas ni menos.
    sum([AtacaReina, AtacaAlfil, AtacaCaballo, AtacaTorre], #=, NumAtaques),

    % llamado recursivo.
    aplicar_restricciones_ataque(Resto, FilaReina, ColReina, FilaAlfil, ColAlfil, FilaCaballo, ColCaballo, FilaTorre, ColTorre).
