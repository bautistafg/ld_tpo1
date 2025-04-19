:- use_module(library(clpfd)).
:- use_module(library(pairs)).

%ejercicio2
camaradas(Pares, Resultado) :-
    %Este predicado asigna en Pares tres listas con pares entre el número que se le asigna a cada nombre, ciudad y profesión, es decir, la ciudad y profesión que posee cada uno de los nombres está indicado por si estos poseen el mismo número, a su vez, Resultado da únicamente la lista de números que se asignan a cada nombre, profesión y ciudad.

    %Creo una lista con todos los datos:
    Tabla = [Nombres, Ciudades, Profesiones],

    %Creo las variables de los nombres, sus respectivas instancias y creo una lista de pares ordenados relacionandolos
    Nombres = [Green, Brown, Peters, Harper, Nash],
    NombresN = [green, brown, peters, harper, nash],
    pairs_keys_values(ParesNombres, Nombres, NombresN),

    %Creo las variables de las ciudades, sus respectivas instancias y creo una lista de pares ordenados relacionandolos
    Ciudades = [Greenfield, Brownsville, Petersburg, Harpers_Ferry, Nashville],
    CiudadesN = [greenfield, brownsville, petersburg, harpers_Ferry, nashville],
    pairs_keys_values(ParesCiudades, Ciudades, CiudadesN),

    %Creo las variables de las profesiones, sus respectivas instancias y creo una lista de pares ordenados relacionandolos
    Profesiones = [Grabador, Proyectista, Biologo, Herrero, Neurologo],
    ProfesionesN = [grabador, proyectista, biologo, herrero, neurologo],
    pairs_keys_values(ParesProfesiones, Profesiones, ProfesionesN),

    %Agrupo las listas de pares que cree
    Pares = [ParesNombres, ParesCiudades, ParesProfesiones],

    %Restringo que en Nombres, Ciudades y Profesiones no pueden repetirse elementos:
    all_distinct(Nombres),
    all_distinct(Ciudades),
    all_distinct(Profesiones),

    %Concateno todas las listas en una sola lista y restringo cada una en un número del 1 al 5, para luego aplicar las restricciones
    append(Tabla, Resultado),
    Resultado ins 1..5,
    
    %Restringo las iniciales y nombres parecidos
    Green #\= Greenfield, Green #\= Grabador, Greenfield #\= Grabador,
    Brown #\= Brownsville, Brown #\= Biologo, Brownsville #\= Biologo,
    Peters #\= Petersburg, Peters #\= Proyectista, Petersburg #\= Proyectista,
    Harper #\= Harpers_Ferry, Harper #\= Herrero, Harpers_Ferry #\= Herrero,
    Nash #\= Nashville, Nash #\= Neurologo, Nashville #\= Neurologo,

    %El biologo no vive en Petersburg
    Biologo #\= Petersburg,

    %Brown no es herrero ni proyectista, tampoco vive en Petersburg ni en Harpers Ferry
    Brown #\= Herrero,
    Brown #\= Proyectista,
    Brown #\= Petersburg,
    Brown #\= Harpers_Ferry,

    %El señor Harper vive en Nashville y no es ni biologo ni grabador
    Harper #= Nashville,
    Harper #\= Biologo,
    Harper #\= Grabador,

    %Green no es residente de Brownsville, como tampoco Nash, quien no es ni biologo ni herrero
    Green #\= Brownsville,
    Nash #\= Brownsville,
    Nash #\= Biologo,
    Nash #\= Herrero.

ejercicio2 :-
    %Este predicado imprime la ciudad en la que vive Nash, lo que sería la respuesta a la pregunta del enunciado.

    %Comienza buscando la lista con las profesiones y ciudades correspondientes con cada nombre.
    camaradas(Pares, Resultado),

    %
    label(Resultado),

    %Obtiene de la lista resultante la posición 1, lo que debolvería la lista con los pares Número-nombre
    nth1(1, Pares, ListaNombres),

    %Obtiene de la lista resultante la posición 2, lo que debolvería la lista con los pares Número-ciudad
    nth1(2, Pares, ListaCiudades),

    %Busca N-nash como miembro de la lista de nombres, lo que instancia el N buscando el número que se le asigno a Nash
    member(N-nash, ListaNombres),

    %Busca N-Ciudad como miembro de la lista de ciudades, habiendo encontrado el N correspondiente a Nash, instancia la ciudad correspondiente buscandola en la lista de ciudades
    member(N-CiudadNash, ListaCiudades),

    %Imprime por pantalla la ciudad de Nash
    format('La ciudad de Nash es: ~w~n', [CiudadNash]).