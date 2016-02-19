UNIT tournoi;
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
//////////////////////////////////Affichage/////////////////////////////////////
PROCEDURE wel_tournoi;
BEGIN
  ClrScr;
	WRITELN('Bienvenue');
	WRITELN('Veuillez entrer le nombre d''equipes dans la compétition : ');
END;
PROCEDURE tournoisfoot;
BEGIN
  ______                                                  __                 ___               __    __                ___    ___
 /\__  _\                                      __        /\ \              /'___\             /\ \__/\ \              /\_ \  /\_ \
 \/_/\ \/   ___   __  __  _ __    ___     ___ /\_\       \_\ \     __     /\ \__/  ___     ___\ \ ,_\ \ \____     __  \//\ \ \//\ \    
    \ \ \  / __`\/\ \/\ \/\`'__\/' _ `\  / __`\/\ \      /'_` \  /'__`\   \ \ ,__\/ __`\  / __`\ \ \/\ \ '__`\  /'__`\  \ \ \  \ \ \
     \ \ \/\ \L\ \ \ \_\ \ \ \/ /\ \/\ \/\ \L\ \ \ \    /\ \L\ \/\  __/    \ \ \_/\ \L\ \/\ \L\ \ \ \_\ \ \L\ \/\ \L\.\_ \_\ \_ \_\ \_
      \ \_\ \____/\ \____/\ \_\ \ \_\ \_\ \____/\ \_\   \ \___,_\ \____\    \ \_\\ \____/\ \____/\ \__\\ \_,__/\ \__/.\_\/\____\/\____\
       \/_/\/___/  \/___/  \/_/  \/_/\/_/\/___/  \/_/    \/__,_ /\/____/     \/_/ \/___/  \/___/  \/__/ \/___/  \/__/\/_/\/____/\/____/
END;

Procedure afficlass;
BEGIN
  ____    ___                                                              __
/\  _`\ /\_ \                                                            /\ \__
\ \ \/\_\//\ \      __      ____    ____     __    ___ ___      __    ___\ \ ,_\
\ \ \/_/_\ \ \   /'__`\   /',__\  /',__\  /'__`\/' __` __`\  /'__`\/' _ `\ \ \/
 \ \ \L\ \\_\ \_/\ \L\.\_/\__, `\/\__, `\/\  __//\ \/\ \/\ \/\  __//\ \/\ \ \ \_
  \ \____//\____\ \__/.\_\/\____/\/\____/\ \____\ \_\ \_\ \_\ \____\ \_\ \_\ \__\
   \/___/ \/____/\/__/\/_/\/___/  \/___/  \/____/\/_/\/_/\/_/\/____/\/_/\/_/\/__/

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
      WHILE (i <= fin) AND (classement.points[i] >= pivot) DO i := i+1;
      WHILE (j > debut) AND (classement.points[j] < pivot) DO j := j-1;
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
//////////////////////////////Égalité///////////////////////////////////////////
PROCEDURE changeOrdre(VAR classement :tabclassement;i,j : INTEGER);
VAR
  tmp3 : STRING;
  tmp1,tmp2,tmp : INTEGER;
BEGIN
  tmp := classement.points[i];
  tmp3 := classement.noms[i];
  tmp1 := classement.butsm[i];
  tmp2 := classement.butsp[i];
  classement.noms[i] := classement.noms[j];
  classement.points[i] := classement.points[j];
  classement.noms[j] := tmp3;
  classement.points[j] := tmp;
  classement.butsm[i] := classement.butsm[j];
  classement.butsm[j] := tmp1;
  classement.butsp[i] := classement.butsp[j];
  classement.butsp[j] := tmp2;
END;

PROCEDURE casEgalite(VAR classement : tabclassement;x : INTEGER);
VAR
  i,diff1,diff2,j,buts1,buts2,oa1, oa2,l,len: INTEGER;
  tmp11,tmp21,t1,t2 : STRING;
BEGIN
  l := 0;
  FOR i := 0 to x-2 DO BEGIN
    j := i+1;
    t1 := classement.noms[i];
    t2 := classement.noms[j];
    IF (length(t1) > length(t2)) THEN len := length(t2)
    ELSE len := length(t1);

    IF (classement.points[i] = classement.points[j]) THEN BEGIN
      diff1 := classement.butsm[i] - classement.butsp[i];

      diff2 := classement.butsm[j] - classement.butsp[j];
      buts1 := classement.butsm[i];
      buts2 := classement.butsm[j];
      IF diff2 > diff1 THEN changeOrdre(classement,i,j)
      ELSE IF buts2 > buts1 THEN changeOrdre(classement,i,j)
      ELSE BEGIN
        REPEAT
          tmp11 := classement.noms[i];
          tmp21 := classement.noms[j];
          oa1 := ord(tmp11[l]);
          oa2 := ord(tmp21[l]);
          IF (oa1 >= 65) and (oa1 <= 90) THEN oa1 := oa1 - 64
          ELSE oa1 := oa1 - 96;
          IF (oa2 >= 65) and (oa2 <= 90) THEN oa2 := oa2 - 64
          ELSE oa2 := oa2 - 96;
          l := l+1;
        UNTIL ((oa1 <> oa2) or (l = len));
      IF oa1 > oa2 THEN changeOrdre(classement,i,j);
      END;
      END;
    END;
  END;
//////////////////////////////Affichage/////////////////////////////////////////
PROCEDURE modifEspaces(VAR classement : tabclassement; x : INTEGER;VAR u : INTEGER);
VAR
  i,lmax,ltmp,j : INTEGER;
  nomss : STRING;
BEGIN
  lmax := length(classement.noms[0]);
  FOR i := 0 to x-1 DO BEGIN
    nomss := classement.noms[i];
    IF (lmax < length(classement.noms[i])) THEN lmax := length(classement.noms[i]);
  END;
  WRITELN(lmax);
  FOR i := 0 to x-1 do BEGIN
    nomss := classement.noms[i];
    IF lmax = length(nomss) THEN nomss := nomss+'     '
    ELSE IF (lmax-length(nomss)) = 1 THEN nomss := nomss+'      '
    ELSE BEGIN
      ltmp := (lmax - length(nomss));
      FOR j := 1 to ltmp+5 DO  nomss := nomss + ' ';
    END;
    classement.noms[i] := nomss;
  END;
    u := lmax -5;
END;
/////////////////////////////Principal//////////////////////////////////////////
PROCEDURE tournois;
VAR
	x,i,j,l,u : INTEGER;
  esp : STRING;
	classement : tabclassement;
BEGIN

  esp :='';
	wel_tournoi;
	readln(x);
  creanoms(classement,x);
	ClrScr;
  entreematchs(classement,x);
  TriRapide(classement);
  casEgalite(classement,x);
  modifEspaces(classement,x,u);
  FOR i := 1 to u DO esp := esp + ' ';
  WRITELN('   Equipes',esp,'Points    Buts');
  FOR i := 0 to x-1 DO BEGIN
    l := i+1;
    WRITE(l,'. ',classement.noms[i]);
    WRITELN(classement.points[i],'      ',classement.butsm[i],' : ',classement.butsp[i]);
  END;
END;
END.
