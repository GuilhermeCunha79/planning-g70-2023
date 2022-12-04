:-consult(shared).
:-consult(baseConhecimento).

%Us1

todosTrajetorias(ListaP,Tempo,Data,Camiao):- findall(ID, entrega(_,Data,_,ID,_,_),Lista),
					      permutation(Lista,ListaP),
					      calcula_tempo(ListaP,Tempo,Data, Camiao);true.
                    	




