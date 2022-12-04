%Us1

/*Procura pelo ID na lista de armazéns*/
armazens(L,Data):- findall(Id, entrega(_,Data,_,Id,_,_), L). 

/*Adiciona Matosinhos ao inicio e ao fim da lista de sequência de armazéns*/
adicionarMatosinhos(WI, WF):- matosinhos(Id), append([Id|WI],[Id],WF).

/*Possiveis caminhos, permutando uma lista de viagens*/
viagens(LV,Data):- armazens(LW,Data), findall(Viagem, permutation(LW, Viagem), LV).

viagensCompleta([],[]).
viagensCompleta([V|LV],[R|WF]):- adicionarMatosinhos(V, R), write(R), nl, viagensCompleta(LV, WF).

/*Para a data apresentada, calcula as viagens possíveis*/
viagemFinal(WF,Data):-viagens(LV,Data), viagensCompleta(LV, WF).

/*matosinhos*/
matosinhos(5).
