:-consult(shared).
:-consult(baseConhecimento).
% Us2


% calcula a melhor soluçao de viagem tendo em conta o melhor tempo
melhorTempoViagem(Lista,Tempo,Data, Camiao):- get_time(Ti),
                                    (run(Data, Camiao);true),tempo_menor(Lista,Tempo),
                                    get_time(Tf),
                                    TSolucao is Tf-Ti,
                                    write(TSolucao),nl.

run(Data, Camiao):- retractall(tempo_menor(_,_)), 
                    assertz(tempo_menor(_,1000000)),
                    findall(ID, entrega(_,Data,_,ID,_,_),ListaArmazens),
                    permutation(ListaArmazens,ListaArmazensPerm),
                    calcula_tempo(ListaArmazensPerm,Tempo,Data, Camiao),
                    atualiza(ListaArmazensPerm,Tempo),
                    fail.

atualiza(ListaArmazensPerm,Tempo):-tempo_menor(_,Tempo_Minimo),
                ((Tempo<Tempo_Minimo,!,retract(tempo_menor(_,_)),
                assertz(tempo_menor(ListaArmazensPerm,Tempo)));true).







