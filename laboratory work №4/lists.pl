% task 4.1 - чтение и вывод списка

% аналог append
appendList([],X,X).
appendList([H|T1],X,[H|T2]):-appendList(T1,X,T2).

% чтение списка

% размер поступает как аргумент
readList(N,L):-	writeln("set the list: "),readList(N,0,[],L).

% размер вводится самостоятельно
readList(L):-	write("set the list size: "),read(N),
		writeln("set the list: "),readList(N,0,[],L).

readList(0,_,_,[]):-fail,!.
readList(N,N,CurList,CurList):-!.
readList(N,CurN,CurList,L):-	NewN is CurN+1,read(Y),
				appendList(CurList,[Y],NewList),
				readList(N,NewN,NewList,L).
% вывод списка
writeList([]):-!.
writeList([H|T]):-writeln(H),writeList(T).

% task 4.2 - сумма элементов списка (через рекурсию вниз)
% *+ проверка на правильность заданного значения*
sum_list_down([],CurSum,CurSum):-!.
sum_list_down([H|T],CurSum,Sum):-	NewSum is CurSum+H,
					sum_list_down(T,NewSum,Sum).
sum_list_down(List,Sum):-	readList(List),
				sum_list_down(List,0,Sum).

% task 4.3 - сумма элементов списка (через рекурсию вверх)
% *+ проверка на правильность заданного значения*
sum_list_up([],_):-fail,!.
sum_list_up([H],H):-!.
sum_list_up([H|T],Sum):-	sum_list_up(T,CurSum),
				Sum is CurSum+H.

% task 4.4 - если инициализирован Elem, то Num - номер первого вхождения
% если инициализирован Num, то Elem - элемент с этим номером
% *+ проверка на правильность заданных значений*
list_el_numb([],_,_,_):-fail,!.
list_el_numb([H|_],H,CurNum,CurNum):-!.
list_el_numb([_|T],Elem,CurNum,Num):-	NewNum is CurNum+1,
					list_el_numb(T,Elem,NewNum,Num).
list_el_numb(List,Elem,Num):-list_el_numb(List,Elem,1,Num).

% task 4.*4 - чтение списка, чтение элемента
% найти номер первого вхождения элемента в список
% *+ проверка на правильность*
predicate4:-	readList(List),
		write("set the item: "),read(Item),
		(list_el_numb(List,Item,Number) ->
		write("first item number: "),write(Number);
		write("sorry: item isn't in the list!")).

% task 4.5 - чтение списка, чтение номера элемента
% найти элемент в списке по заданному номеру
% *+ проверка на правильность*
predicate5:-	readList(List),
		write("set the number: "),read(Number),
		(list_el_numb(List,Item,Number) ->
		write("item by number: "),write(Item);
		write("sorry: item with this number isn't in the list!")).

% task 4.6 - найти минимальный элемент списка (через рекурсию вверх)
% *+ проверка на правильность*
min_list_up([],_):-fail,!.
min_list_up([H],H):-!.
min_list_up([H|T],Min):-	min_list_up(T,CurMin),
				(H<CurMin -> Min=H;Min=CurMin).

% task 4.7 - найти минимальный элемент списка (через рекурсию вниз)
% *+ проверка на правильность*
min_list_down([],CurMin,CurMin):-!.
min_list_down([H|T],CurMin,Min):-	(H<CurMin -> NewMin=H;NewMin=CurMin),
					min_list_down(T,NewMin,Min).
min_list_down([H|T],Min):-min_list_down(T,H,Min).

% task 4.8 - чтение списка, найти минимальный элемент
predicate8:-	readList(List),
		(min_list_up(List,Min) ->
		write("min = "),write(Min)).

% task 4.9 - проверить, есть ли в списке заданный элемент
member([X|_],X):-!.
member([_|T],X):-member(T,X).

% task 4.10 - перевернуть список
reverse([],CurList,CurList):-!.
reverse([H|T],CurList,InvList):-reverse(T,[H|CurList],InvList).
reverse(List,InvList):-reverse(List,[],InvList).

% task 4.11 - проверить, встречаются ли элементы Sublist в List в том же порядке
list_same_order([],_):-!.
list_same_order([H|T1],[H|T2]):-list_same_order(T1,T2),!.	
list_same_order(Sublist,[_|T]):-list_same_order(Sublist,T).

% task 4.12 - удалить элемент с заданным номером
list_delete_item([_|T],CurList,ResList,CurN,CurN):-	appendList(CurList,T,ResList),!.
list_delete_item([H|T],CurList,ResList,CurN,N):-	appendList(CurList,[H],NewList),
							NewN is CurN+1,
							list_delete_item(T,NewList,ResList,NewN,N).
list_delete_item(List,ResList,N):-list_delete_item(List,[],ResList,1,N).

% task 4.13 - удалить все элементы равные данному
list_delete_equal([],CurList,CurList,_):-!.
list_delete_equal([H|T],CurList,ResList,H):-	list_delete_equal(T,CurList,ResList,H),!.
list_delete_equal([H|T],CurList,ResList,X):-	appendList(CurList,[H],NewList),
						list_delete_equal(T,NewList,ResList,X).	
list_delete_equal(List,ResList,X):-list_delete_equal(List,[],ResList,X).

% task 4.14 - проверить, встречаются ли все элементы только один раз
unique([]):-!.
unique([H|T]):-	not(member(T,H)),
		unique(T).

% task 4.15 - убрать повторяющиеся элементы из списка
% unique_list([],CurList,CurList):-!.
% unique_list([H|T],CurList,ResList):-	(not(member(CurList,H)) ->
%					appendList(CurList,[H],NewList);NewList=CurList),
%					unique_list(T,NewList,ResList).
% unique_list(List,ResList):-unique_list(List,[],ResList).

unique_list([],[]):-!.
unique_list([H|T],ResList):-	list_delete_equal(T,NewList,H),
				unique_list(NewList,CurList),
				appendList([H],CurList,ResList).