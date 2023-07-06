/* Facts */
male(adam).
male(fred).
male(gideon).
male(bob).
male(james).
male(simon).
male(john).

female(eve).
female(jane).
female(maggie).
female(ann).
female(mary).

parent_of(adam, jane).
parent_of(adam, gideon).
parent_of(eve, jane).
parent_of(eve, gideon).
parent_of(fred,ann).
parent_of(jane, ann).

parent_of(gideon,james).
parent_of(maggie, james).

parent_of(ann, simon).
parent_of(bob, simon).

parent_of(mary, john).
parent_of(james, john).

/* Rules */
father_of(X,Y):- male(X),
    parent_of(X,Y).

mother_of(X,Y):- female(X),
    parent_of(X,Y).

grandfather_of(X,Y):- male(X),
    parent_of(X,Z),
    parent_of(Z,Y).

grandmother_of(X,Y):- female(X),
    parent_of(X,Z),
    parent_of(Z,Y).

sister_of(X,Y):- %(X,Y or Y,X)%
    female(X),
    father_of(F, Y), father_of(F,X),X \= Y.

sister_of(X,Y):- female(X),
    mother_of(M, Y), mother_of(M,X),X \= Y.

aunt_of(X,Y):- female(X),
    parent_of(Z,Y), sister_of(Z,X),!.

brother_of(X,Y):- %(X,Y or Y,X)%
    male(X),
    father_of(F, Y), father_of(F,X),X \= Y.

brother_of(X,Y):- male(X),
    mother_of(M, Y), mother_of(M,X),X \= Y.

uncle_of(X,Y):-
    parent_of(Z,Y), brother_of(Z,X).

ancestor_of(X,Y):- parent_of(X,Y).
/*Multiple generation ancestors*/
ancestor_of(X,Y):- parent_of(X,Z),
    ancestor_of(Z,Y).
