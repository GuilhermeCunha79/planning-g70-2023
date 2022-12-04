% SharedMethods




% calcula a tara do camiao dado 

calcula_Tara_Camioes(Nome, Lista_Cargas, Lista_Tara_Carga):- 
carateristicasCam(Nome,Tara_Camiao,_,_,_,_), 
calcula_Tara(Tara_Camiao,Lista_Cargas,Lista_Tara_Carga).

% calcula a Lista de Tara e Carga dada pela soma da Carga mais a tara
calcula_Tara(Tara_Camiao,[],[Tara_Camiao]):-!.

calcula_Tara(Tara_Camiao, [Carga_Camiao|Lista_Cargas], [Carga_Tara|Lista_Tara_Carga]):- 
calcula_Tara(Tara_Camiao,Lista_Cargas, Lista_Tara_Carga), 
Carga_Tara is Carga_Camiao + Tara_Camiao.

% calcula a carga dada uma lista de armazens tendo em conta as entregas da data dada e soma as suas massas 
carga(_, [], [], 0):-!.
carga(Data, [Armazem_Entrega|Lista_Armazens], [Carga_Camiao|Lista_Cargas], Carga_Camiao):-
carga(Data, Lista_Armazens, Lista_Cargas, Carga_Camiao1), 
entrega(_,Data,Massa_Entrega,Armazem_Entrega,_,_), Carga_Camiao is Massa_Entrega + Carga_Camiao1.



% calcula o tempo necessario para fazer viagens entre trechos de armazens dada uma lista de armazens, para isso calcula a tara a carga a capacidade total e tem em conta as cargas das baterias e os dados do camiao
calcula_tempo(Lista_Armazens,Total_Tempo,Data, Camiao):-
        idArmazem('Matosinhos',ID),
        append([ID|Lista_Armazens],[ID],Rota),
        carga(Data, Lista_Armazens, Lista_Cargas,_), 
        calcula_Tara_Camioes(Camiao,Lista_Cargas, Lista_Tara_Carga),
        carateristicasCam(Camiao,Tara_Camiao,Capacidade_Carga,Carga_Baterias,_,Tempo_Carregamento), 
        Capacidade_Total is Tara_Camiao + Capacidade_Carga,
        tempo(Rota, Lista_Tara_Carga,Capacidade_Total,Carga_Baterias,Carga_Baterias,Tempo_Carregamento,Data,Total_Tempo),!.

% predicado base em que dados 2 armazens calcula o tempo tendo em conta a carga, a bateria gasta, a bateria restante e o tempo exta  

tempo([Armazem1,Armazem2],[Carga_Camiao1],Capacidade_Total,Carga_Baterias, Carga_Maxima_Baterias,_,_,Total_Tempo):-
                                                                                                dadosCam_t_e_ta(_, Armazem1, Armazem2, Tempo_Rota_Maximo, Energia_Gasta_Maxima, Tempo_Adicional),
                                                                                                % calcula a energia da rota para a carga do atual camiao
                                                                                                Energia_Rota is Energia_Gasta_Maxima*Carga_Camiao1/Capacidade_Total,
                                                                                                % calcula o tempo da rota para a carga atual do camiao
                                                                                                Tempo_Rota is Tempo_Rota_Maximo*Carga_Camiao1/Capacidade_Total,
                                                                                                % a energia das baterias que resta Ã© a carga das baterias antes menos a energia gasta 
                                                                                                Energia_Baterias_Restante is Carga_Baterias - Energia_Rota,
                                                                                                % se a eergia restante for menor que 20% o tempo adicional preciso serÃ¡ o tempo adicional do camiao senao e 0
                                                                                                ((Energia_Baterias_Restante < (Carga_Maxima_Baterias * 0.2), Tempo_Adicional_Preciso is Tempo_Adicional,!);
                                                                                                (Tempo_Adicional_Preciso is 0)),
                                                                                                % o tempo total Ã© a soma do tempo da rota com o tempo adicional preciso
                                                                                                Total_Tempo is Tempo_Rota + Tempo_Adicional_Preciso.



% o segundo predicado vai calcular o tempo dada uma lista de armazens tendo em conta o tempo de descarga das entregas, a necessidade de carregar as baterias, a carga do camiao a sua energia 

tempo([Armazem1,Armazem2,Armazem3|Rota],[Carga_Camiao1,Carga_Camiao2|Lista_Tara_Carga], Capacidade_Total,Carga_Baterias,Carga_Maxima_Baterias, Tempo_Carregamento,Data,Total_Tempo):-
                                                % faz a busca dos dados da viagem entre dois armazens
                                                dadosCam_t_e_ta(_, Armazem1, Armazem2, Tempo_Rota_Maximo, Energia_Gasta_Maxima, Tempo_Adicional),
                                                % calculao tempo de rota para a carga atual
                                                Tempo_Rota is Tempo_Rota_Maximo*Carga_Camiao1/Capacidade_Total,
                                                % calcula a energia da rota para carga atual
                                                Energia_Rota is Energia_Gasta_Maxima*Carga_Camiao1/Capacidade_Total,
                                                % calcula a energia restante das baterias atraves da subtracao da energia antes e a que gastou
                                                Energia_Baterias_Restante is Carga_Baterias - Energia_Rota,
                                                % caso a baterias restante seja menor que 20% terÃ¡ que carregar as baterias atÃ© 20% sendo o tempo adicional preciso o tempo adicional ou seja o tempo que demora a carregar ate 20
                                                (( Energia_Baterias_Restante < (Carga_Maxima_Baterias*0.2), 
                                                Energia_Chegada_Armazem is (Carga_Maxima_Baterias * 0.2), 
                                                Tempo_Adicional_Preciso is Tempo_Adicional,!);
                                                % caso nao seja menor que 20 a energia serÃ¡ igual a rsetante e o tempo adicional preciso nao sera nenhum
                                                (Energia_Chegada_Armazem is Energia_Baterias_Restante, Tempo_Adicional_Preciso is 0)),
                                                % busca o tempo de descarga da entrega no dado armazem e data, e os dados do camiao entre o armazem em que chegou e o proximo
                                                entrega(_,Data,_,Armazem2,_,Tempo_Descarregamento_Entregas),
                                                dadosCam_t_e_ta(_, Armazem2, Armazem3, _,  Energia_Max_Proximo_Armazem,_),
                                                % calcula a energia para chegar ao rpoximo armazem tendo em conta a carga 
                                                Energia_Proximo_Armazem is Energia_Max_Proximo_Armazem * Carga_Camiao2 / Capacidade_Total,
                                                
                                                %  Se o armazem 3 for matosinhos ou seja o ultimo armazem onde tem que ir, e a energia de chegada menos a do proximo for menor que 20
                                                idArmazem('Matosinhos',ID),
                                                ((Armazem3 == ID, Energia_Chegada_Armazem - Energia_Proximo_Armazem < (Carga_Maxima_Baterias * 0.2), 
                                                % a quantidade de carregamento sera 20% - a energia de chegada menos a energia do proximo armazem ou seja Ã© a energia que necessia carregar ate chegar a 20%
                                                Quantidade_Carregamento is ((Carga_Maxima_Baterias * 0.2) - (Energia_Chegada_Armazem - Energia_Proximo_Armazem)), 
                                                % o tempo que demora a carregar vai ser a quantidade que carregamento * o tempo que demora a carregar 60% a dividir por 60% da carga maxima das baterias
                                                Tempo_Carregar_Baterias is Quantidade_Carregamento * Tempo_Carregamento/(Carga_Maxima_Baterias * 0.6),
                                                % a bateria necessaria seguinte sera entao a quantidade de carregamento mais a energia de chegada ao armazem
                                                Bateria_Seguinte_Carga is Quantidade_Carregamento + Energia_Chegada_Armazem,!);
                                                
                                                
                                                % se o proximo armazem no for matosinhos e a sua energia for maior que a energia com que chegou 
                                                (((Energia_Proximo_Armazem>Energia_Chegada_Armazem,
                                                % a bateria seguinte tera que ser 80%
                                                Bateria_Seguinte_Carga is (Carga_Maxima_Baterias * 0.8), 
                                                % o tempo que demorara a carregar as baterias ser o que falta para carregar ate aos 80% * tempo de carregamento de 60% sobre a carga de 60%
                                                Tempo_Carregar_Baterias is ((Carga_Maxima_Baterias * 0.8) - Energia_Chegada_Armazem)*Tempo_Carregamento/(Carga_Maxima_Baterias * 0.6),!);
                                                
                                                % Se a que temos na chegada menos a energia para chegar ao proximo armazem for menor que 20%, iremos carregar atÃ© ao 80%
                                                ((Energia_Chegada_Armazem-Energia_Proximo_Armazem<(Carga_Maxima_Baterias * 0.2), 
                                                % bateria sera 80%
                                                Bateria_Seguinte_Carga is (Carga_Maxima_Baterias * 0.8), 
                                                % o tempo que demorara a carregar as baterias ser o que falta para carregar ate aos 80% * tempo de carregamento de 60% sobre a carga de 60%
                                                Tempo_Carregar_Baterias is ((Carga_Maxima_Baterias * 0.8) - Energia_Chegada_Armazem)*Tempo_Carregamento/(Carga_Maxima_Baterias * 0.6),!);

                                                % Senao a bateria seguinte sera a energia que restou e o tempo de carregar nao sera nenhum
                                                (Bateria_Seguinte_Carga is Energia_Baterias_Restante, 
                                                Tempo_Carregar_Baterias is 0))))),

                                                % se o tempo de carregar as baterias for maior que o tempo de desarregamento da mercadoria entao o tempo de espera sera o tempo de carregar as baterias
                                                ((Tempo_Carregar_Baterias > Tempo_Descarregamento_Entregas, Tempo_Espera is Tempo_Carregar_Baterias,!);
                                                % senao sera o tempo de descarregar a mercadoria
                                                (Tempo_Espera is Tempo_Descarregamento_Entregas)),

                                                % apos os calculos retorna a chamar o metodo recursivamente enviaando os proximos valores da lista
                                                tempo([Armazem2,Armazem3|Rota],[Carga_Camiao2|Lista_Tara_Carga], Capacidade_Total, Bateria_Seguinte_Carga, Carga_Maxima_Baterias ,Tempo_Carregamento, Data, Total_Tempo1),
                                                
                                                % calcula o tempo total somando o tempo anterior aos tempos calculados 
                                                Total_Tempo is Total_Tempo1 + Tempo_Rota + Tempo_Adicional_Preciso + Tempo_Espera.


