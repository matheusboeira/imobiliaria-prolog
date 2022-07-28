:- dynamic list_set/2.

% ------------------------------------------------------------------------------------------------
% Profissões -> (Profissão).
% ------------------------------------------------------------------------------------------------
career('Veterinario').
career('Medico').
career('Militar').
career('Advogado').
career('Professor').

% ------------------------------------------------------------------------------------------------
% Clientes -> (Código, Idade, Profissão).
% ------------------------------------------------------------------------------------------------
client(1010, 55, career('Veterinario')).
client(1011, 53, career('Medico')).
client(1012, 40, career('Militar')).
client(1013, 65, career('Advogado')).
client(2010, 60, career('Advogado')).
client(2011, 45, career('Militar')).
client(2012, 39, career('Veterinario')).
client(3010, 25, career('Professor')).
client(3011, 35, career('Professor')).
client(3012, 47, career('Medico')).

% ------------------------------------------------------------------------------------------------
% Vendedores -> (Nome).
% ------------------------------------------------------------------------------------------------
seller('Maria').
seller('Paulo').
seller('Ana').
seller('Jose').
seller('Lucas').
seller('Marisa').
seller('Rosa').
seller('Miguel').

% ------------------------------------------------------------------------------------------------
% Imobiliarias -> (Imobiliária).
% ------------------------------------------------------------------------------------------------
agency_in('Alegrete').
agency_in('Baita Chao').
agency_in('Ibirapuita').

% ------------------------------------------------------------------------------------------------
% Tipos de Imoveis -> (Tipo).
% ------------------------------------------------------------------------------------------------
type('Casa').
type('Apartamento').

% ------------------------------------------------------------------------------------------------
% Imoveis para locação -> (Tipo, Quartos, Valor).
% ------------------------------------------------------------------------------------------------
for_sale(type('Casa'), 3, 300_000).
for_sale(type('Apartamento'), 1, 120_000).
for_sale(type('Apartamento'), 3, 650_000).
for_sale(type('Apartamento'), 1, 145_000).
for_sale(type('Apartamento'), 2, 160_000).
for_sale(type('Apartamento'), 2, 300_000).
for_sale(type('Apartamento'), 3, 500_000).
for_sale(type('Apartamento'), 1, 130_000).
for_sale(type('Casa'), 1, 220_000).
for_sale(type('Casa'), 2, 250_000).
for_sale(type('Apartamento'), 2, 140_000).
for_sale(type('Casa'), 3, 700_000).
for_sale(type('Apartamento'), 2, 250_000).
for_sale(type('Casa'), 2, 260_000).
for_sale(type('Casa'), 1, 150_000).

% ------------------------------------------------------------------------------------------------
% Vendas -> (Imobiliaria, Vendedor, Cliente, Imóvel).
% ------------------------------------------------------------------------------------------------
sale(agency_in('Alegrete'), seller('Maria'), client(1010, 55, career('Veterinario')), for_sale(type('Casa'), 3, 300_000)).
sale(agency_in('Alegrete'), seller('Maria'), client(1010, 55, career('Veterinario')), for_sale(type('Apartamento'), 1, 120_000)).
sale(agency_in('Alegrete'), seller('Miguel'), client(1013, 65, career('Advogado')), for_sale(type('Apartamento'), 3, 650_000)).
sale(agency_in('Alegrete'), seller('Miguel'), client(1013, 65, career('Advogado')), for_sale(type('Apartamento'), 1, 145_000)).
sale(agency_in('Alegrete'), seller('Miguel'), client(1013, 65, career('Advogado')), for_sale(type('Apartamento'), 2, 160_000)).
sale(agency_in('Alegrete'), seller('Rosa'), client(1012, 40, career('Militar')), for_sale(type('Apartamento'), 2, 300_000)).
sale(agency_in('Alegrete'), seller('Maria'), client(1011, 53, career('Medico')), for_sale(type('Apartamento'), 3, 500_000)).
sale(agency_in('Ibirapuita'), seller('Ana'), client(3010, 25, career('Professor')), for_sale(type('Apartamento'), 1, 130_000)).
sale(agency_in('Ibirapuita'), seller('Jose'), client(3011, 35, career('Professor')), for_sale(type('Casa'), 1, 220_000)).
sale(agency_in('Ibirapuita'), seller('Lucas'), client(3012, 47, career('Medico')), for_sale(type('Casa'), 2, 250_000)).
sale(agency_in('Ibirapuita'), seller('Lucas'), client(3012, 47, career('Medico')), for_sale(type('Apartamento'), 2, 140_000)).
sale(agency_in('Baita Chao'), seller('Paulo'), client(2010, 60, career('Advogado')), for_sale(type('Casa'), 3, 700_000)).
sale(agency_in('Baita Chao'), seller('Marisa'), client(2011, 45, career('Militar')), for_sale(type('Apartamento'), 2, 250_000)).
sale(agency_in('Baita Chao'), seller('Paulo'), client(2012, 39, career('Veterinario')), for_sale(type('Casa'), 2, 260_000)).
sale(agency_in('Baita Chao'), seller('Paulo'), client(2012, 39, career('Veterinario')), for_sale(type('Casa'), 1, 150_000)).

% ------------------------------------------------------------------------------------------------
% REGRAS
% ------------------------------------------------------------------------------------------------
% 2.1: Listar o código de cada cliente da imobiliária. [OK].
% ------------------------------------------------------------------------------------------------
list_clients :-
    write('\nClientes cadastrados: '),
    findall(Code, client(Code, _, _), Codes),
    writeln(Codes).

% ------------------------------------------------------------------------------------------------
% 2.2: Listar os dados de um determinado cliente. [OK].
% ------------------------------------------------------------------------------------------------
list_client(Code) :-
    client(Code, Age, career(Career)),
    writef('\nCodigo: %d\nIdade: %d\nProfissao: %w\n', [Code, Age, Career]).

% ------------------------------------------------------------------------------------------------
% 2.3: Listar todos os tipos de imóveis vendidos por uma determinada imobiliária. [OK].
% ------------------------------------------------------------------------------------------------
list_types_by_agency(Agency) :-
    findall(Type, sale(agency_in(Agency), _, _, for_sale(type(Type), _, _)), NonUniqueTypes),
    list_to_set(NonUniqueTypes, Types),
    (  Types == [] ->
        false ;
        writef('\nImoveis vendidos pela imobiliaria de %w: %w\n', [Agency, Types])
    ).

% ------------------------------------------------------------------------------------------------
% 2.4: Listar todos os clientes de uma determinada profissão. [OK].
% ------------------------------------------------------------------------------------------------
list_client_by_career(Career) :-
    findall(Code, client(Code, _, career(Career)), Codes),
    ( Codes == [] ->
        false ;
        forall(member(Code, Codes), list_client(Code))
    ).

% ------------------------------------------------------------------------------------------------
% 2.5: Listagem do valor médio de todas as imobiliárias. [OK].
% ------------------------------------------------------------------------------------------------
average_value_by_agency(Agency) :-
    findall(Value, sale(agency_in(Agency), _, _, for_sale(_, _, Value)), Values),
    ( Values == [] ->
        false ;
        sum_list(Values, Sum),
        length(Values, Length),
        Average is (Sum div Length),
        writef('Valor medio de imoveis vendidos pela imobiliaria \'%w\': ', [Agency]),
        format('R$ ~2f\n', [Average])
    ).

list_average_agencies :-
    nl, forall(agency_in(Agency), average_value_by_agency(Agency)).

% ------------------------------------------------------------------------------------------------
% 2.6: Alterar informação de um determinado cliente. [NÃO TÁ FUNCIONANDO AINDA].
% ------------------------------------------------------------------------------------------------
change_client(Code, NewAge, NewCareer) :-
    client(Code, _, _),
    retract(client(Code, _, _)),
    assert(client(Code, NewAge, career(NewCareer))).

% ------------------------------------------------------------------------------------------------
% 2.7: Listar imobiliárias com maior valor de vendas em ordem decrescente. [OK].
% ------------------------------------------------------------------------------------------------
list_agency_by_value_sold :-
    findall(Agency-Value, sale(agency_in(Agency), _, _, for_sale(_, _, Value)), Sum),
    keysort(Sum, KeySorted),
    group_pairs_by_key(KeySorted, Grouped),
    pairs_keys_values(Grouped, Keys, Values),
    maplist(sumlist, Values, SumResult),
    pairs_keys_values(Result, SumResult, Keys),
    sort(0, @>, Result, Sorted),
    write('\n'),
    forall(member(Value-Agency, Sorted), format('~w: R$ ~2f\n', [Agency, Value])).

% ------------------------------------------------------------------------------------------------
% 2.8: Listar vendedores em ordem crescente de valor de vendas. [OK].
% ------------------------------------------------------------------------------------------------
list_sellers_by_value_sold :-
    findall(Seller-Value, sale(_, seller(Seller), _, for_sale(_, _, Value)), Sum),
    keysort(Sum, KeyAgregated),
    group_pairs_by_key(KeyAgregated, Grouped),
    pairs_keys_values(Grouped, Keys, Values),
    maplist(sumlist, Values, SumResult),
    pairs_keys_values(Result, SumResult, Keys),
    sort(0, @<, Result, Sorted),
    write('\n'),
    forall(member(Value-Seller, Sorted), format('~w: R$ ~2f\n', [Seller, Value])).
