
% Bibliotecas HTTP
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_client)).
:- use_module(library(http/http_open)).
:- use_module(library(http/http_cors)).


% Bibliotecas JSON
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_json)).
:- use_module(library(http/json)).




%Servidor

startServer(Port) :-
    http_server(http_dispatch, [port(Port)]),
    asserta(port(Port)).

stopServer:-
    retract(port(Port)),
    http_stop_server(Port,_).




%idArmazem(<local>,<codigo>)
idArmazem('Arouca',1).
idArmazem('Espinho',2).
idArmazem('Gondomar',3).
idArmazem('Maia',4).
idArmazem('Matosinhos',5).

%Tempo entre cidades
%tmepo(armzem1, armazem2, tempo)
tempo(1,2,122).
tempo(1,3,122).
tempo(1,4,151).
tempo(1,5,147).


tempo(2, 1,116).
tempo(2, 3,55).
tempo(2, 4,74).
tempo(2, 5,65).

tempo(3,1,120).
tempo(3,2,50).
tempo(3,4,46).
tempo(3,5,46).


tempo(4,1, 149).
tempo(4,2,65).
tempo(4,3,46).
tempo(4,5,27).

tempo(5,1,141).
tempo(5,2,55).
tempo(5,3,48).
tempo(5,4,25).



%entrega(<idEntrega>,<data>,<massaEntrefa>,<armazemEntrega>,<tempoColoc>,<tempoRet>)
entrega(4439, 20221205, 200, 1, 8, 10).
entrega(4439, 20221205, 100, 2, 8, 10).
entrega(4439, 20221205, 400, 3, 8, 10).
entrega(4439, 20221205, 500, 4, 8, 10).

entrega(4439, 20221205, 200, 6, 8, 10).
entrega(4439, 20221205, 200, 7, 8, 10).
entrega(4438, 20221205, 150, 9, 7, 9).
entrega(4445, 20221205, 100, 3, 5, 7).
entrega(4443, 20221205, 120, 8, 6, 8).
entrega(4449, 20221205, 300, 11, 15, 20).


:- http_handler('/lapr5', responde_ola, []).

responde_ola(_Request) :-
        format('Content-type: text/plain~n~n'),
        format('Olá LAPR5!~n').


bestfs(WarehouseList, Final):- Orig is 5,
    bestfs2(WarehouseList, [Orig], Orig, FinalPath),
   append(FinalPath, [5],Final).


bestfs2([], Path, _, FinalPath):-  !,
    reverse(Path, FinalPath).

bestfs2(WarehouseList, Path, Orig, FinalPath):-
    findall((Distance,[NextWarehouse| Path]),
    (tempo(Orig,NextWarehouse,Distance),member(NextWarehouse, WarehouseList), \+ member(NextWarehouse,Path)),
    NewList),

    sort(NewList,NewListSort),

    NewListSort = [(_,[ThisWarehouse|_])|_],

    delete(WarehouseList, ThisWarehouse, ArmazensRestantes),
    bestfs2(ArmazensRestantes, [ThisWarehouse|Path], ThisWarehouse, FinalPath).




%HeuristicaMaiorMassa

bestfsWeight(WarehouseList, Date, Final):- Orig is 5,
    bestfs3(WarehouseList,Date, [Orig], FinalPath),
   append(FinalPath, [5],Final).


bestfs3([],_, Path, FinalPath):-  !,
    reverse(Path, FinalPath).

bestfs3(WarehouseList,Date, Path, FinalPath):-
    findall((Weight,[Warehouse| Path]),

     (idArmazem(_,Warehouse),entrega(_,Date,Weight,Warehouse,_,_),member(Warehouse, WarehouseList)),
    NewList),

    sort(NewList,NewListSort),



    reverse(NewListSort, ReverseList),
    ReverseList = [(_,[ThisWarehouse|_])|_],

    delete(WarehouseList, ThisWarehouse, ArmazensRestantes),
    bestfs3(ArmazensRestantes,Date, [ThisWarehouse|Path], FinalPath).


%HeuristicaWeightAndDistance

bestfsW(WarehouseList,Date, Final):- Orig is 5,
    bestfsW1(WarehouseList,Date, [Orig], Orig, FinalPath),
   append(FinalPath, [5],Final).


bestfsW1([],_, Path, _, FinalPath):-  !,
    reverse(Path, FinalPath).

bestfsW1(WarehouseList,Date, Path, Orig, FinalPath):-

    findall((Result,[NextWarehouse| Path]),
     (member(NextWarehouse, WarehouseList),tempo(Orig,NextWarehouse,Distance),  idArmazem(_,NextWarehouse), entrega(_,Date,Weight,NextWarehouse,_,_)
   , Result is Weight/Distance),
    NewList),

    sort(NewList,NewListSort),


    reverse(NewListSort, ReverseList),

    ReverseList = [(_,[ThisWarehouse|_])|_],

    delete(WarehouseList, ThisWarehouse, ArmazensRestantes),
    bestfsW1(ArmazensRestantes,Date, [ThisWarehouse|Path], ThisWarehouse, FinalPath).



