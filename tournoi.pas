UNIT

INTERFACE

USES

TYPE tabdyni = ARRAY OF STRING;
     tabdyns = ARRAY OF INTEGER;

VAR t1 : tabdyns;
    t2 : tabdyni;

FUNCTION result(VAR t1:tabdyn1; t2:tabdyn2);
    var i, x : integer;

        begin
          If t2[0] > t2[1] then
            writeln(t1[0],'vainqueur')
            if  t2[0] < t2[1] then
              writeln(t1[1],'vainqueur')
              else writeln('Match nul');

        end;

PROCEDURE wel_tournoi;
BEGIN
	WRITELN('Bienvenue');
	WRITE('Veuillez entrer le nombre d''equipes dans la compétition : ');
END;
FUNCTION creanoms(x : INTEGER) : tabdyns;
VAR
	i : INTEGER
	entrenom : STRING;
BEGIN
	length(noms,x);
	WRITELN('Veuillez entrer le noms de chaque equipes :');
	FOR i := 0 TO x-1 DO BEGIN
		READLN(entrenom);
		noms[i] := entrenom;
	END;
	creanoms := noms;
END;

PROCEDURE tournois;
VAR
	x,i : INTEGER;
	noms : tabdyns;
BEGIN
	wel_tournois;
	readln(x);
	noms := creanoms(x);
	FOR i := 0 TO x-1 DO WRITELN(noms[i]);
END;
