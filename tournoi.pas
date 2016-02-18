UNIT tournoi;
// Comment aligner le classement et voir pour l'ordre décroissant
INTERFACE
USES
  crt,sysutils;

TYPE tabclassement = RECORD
  noms : ARRAY OF STRING;
  points : ARRAY OF INTEGER;
  butsp : ARRAY OF INTEGER;
  butsm : ARRAY OF INTEGER;
  END;


PROCEDURE tournois;
IMPLEMENTATION
//////////////////////////////////Welcome///////////////////////////////////////
PROCEDURE wel_tournoi;
BEGIN
  ClrScr;
	WRITELN('Bienvenue');
	WRITELN('Veuillez entrer le nombre d''equipes dans la compétition : ');
END;
/////////////////////////////////Entree noms////////////////////////////////////
PROCEDURE creanoms(VAR classement : tabclassement;x : INTEGER);
VAR
	i : INTEGER;
	entrenom : STRING;
BEGIN
	setlength(classement.noms,x);
	WRITELN('Veuillez entrer le noms de chaque equipes :');
	FOR i := 0 TO x-1 DO BEGIN
		READLN(entrenom);
		classement.noms[i] := entrenom;
	END;
END;
///////////////////////////Entree de score//////////////////////////////////////
PROCEDURE entreematchs(VAR classement : tabclassement;x : INTEGER);
VAR
  i,j,e1,e2 : INTEGER;
BEGIN
  setlength(classement.butsm,x);
  setlength(classement.butsp,x);
  setlength(classement.points,x);
    FOR i := 0 to x-1 DO BEGIN
      classement.butsp[i] := 0;
      classement.butsm[i] := 0;
      classement.points[i] := 0;
    END;
  For i := 0 to x-1 Do BEGIN
    FOR j := i+1 to x-1 DO begin
      WRITELN('Veuillez entrer le score du match : ',classement.noms[i],' - ',classement.noms[j],' :');
      WRITE('Nombre de buts marque par ',classement.noms[i],' : '); READLN(e1);
      WRITE('Nombre de buts marque par ',classement.noms[j],' : '); READLN(e2);
      WRITELN('');
      IF e1 > e2 THEN classement.points[i] := classement.points[i] + 3;
      IF e2 > e1 THEN classement.points[j] := classement.points[j] +3;
      IF e1 = e2 THEN BEGIN
        classement.points[i] := classement.points[i] + 1;
        classement.points[j] := classement.points[j] + 1;
      END;
      classement.butsm[i] := classement.butsm[i] + e1;
      classement.butsp[i] := classement.butsp[i]+ e2;
      classement.butsm[j] := classement.butsm[j]+ e2;
      classement.butsp[j] := classement.butsm[j]+ e1;
    END;
  END;
END;
////////////////////////////////Tri/////////////////////////////////////////////
FUNCTION partitionner(VAR classement : tabclassement; debut, fin: INTEGER): INTEGER;
VAR
    i, j, pivot, tmp,tmp2,tmp3,pivotm,pivotp : INTEGER;
    pivotn,tmp1 : STRING;
BEGIN
    pivot := classement.points[debut];
    pivotn := classement.noms[debut];
    pivotm := classement.butsm[debut];
    pivotp := classement.butsp[debut];
    i := debut + 1;
    j := fin;
    WHILE (i <= j) DO
    BEGIN
      //WHILE (j > debut) AND (classement.points[j] >= pivot) DO j := j-1;
      //WHILE (i <= fin) AND (classement.points[i] < pivot) DO i := i+1;
      WHILE (i <= fin) AND (classement.points[i] < pivot) DO i := i+1;
      WHILE (j > debut) AND (classement.points[j] >= pivot) DO j := j-1;
        IF (i<j) THEN
        BEGIN
            tmp := classement.points[i];
            tmp1 := classement.noms[i];
            tmp2 := classement.butsm[i];
            tmp3 := classement.butsp[i];
            classement.noms[i] := classement.noms[j];
            classement.points[i] := classement.points[j];
            classement.noms[j] := tmp1;
            classement.points[j] := tmp;
            classement.butsm[i] := classement.butsm[j];
            classement.butsm[j] := tmp2;
            classement.butsp[i] := classement.butsp[j];
            classement.butsp[j] := tmp3;
        END;
    END;
    classement.points[debut] := classement.points[j];
    classement.noms[debut] := classement.noms[j];
    classement.butsm[debut] := classement.butsm[j];
    classement.butsp[debut] := classement.butsp[j];
    classement.points[j] := pivot;
    classement.noms[j] := pivotn;
    classement.butsp[j] := pivotp;
    classement.butsm[j] := pivotm;
    partitionner := j;
END;

PROCEDURE triRapideRec(VAR classement : tabclassement; debut , fin : INTEGER);
VAR
  pivot : INTEGER;
begin
  IF (debut < fin) THEN
  begin
    pivot := partitionner(classement,debut,fin);
    triRapideRec(classement,debut,pivot-1);
    triRapideRec(classement,pivot+1,fin);
  end;
end;

procedure TriRapide(VAR classement : tabclassement);
begin
  triRapideRec(classement,0,length(classement.points)-1);
end;
/////////////////////////////Principal//////////////////////////////////////////
PROCEDURE tournois;
VAR
	x,i,j,l : INTEGER;
	classement : tabclassement;
BEGIN
	wel_tournoi;
	readln(x);
  creanoms(classement,x);
	ClrScr;
  entreematchs(classement,x);
  TriRapide(classement);
  WRITELN('  Equipes       Points       Buts');
  FOR i := 0 to x-1 DO BEGIN
    l := i+1;
    WRITE(l,'. ',classement.noms[i],'           ');
    WRITELN(classement.points[i],'        ',classement.butsm[i],' : ',classement.butsp[i]);
  END;
END;
END.
