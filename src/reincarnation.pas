UNIT reincarnation;

INTERFACE
USES
  crt,sysutils;
TYPE
  tabIntdyn = ARRAY OF INTEGER;
  tabStrdyn = ARRAY OF STRING;
PROCEDURE recin;

IMPLEMENTATION

//////////////////////////////////Calcul////////////////////////////////////////
FUNCTION entree_nom(nom : STRING) : INTEGER;
VAR
  i,l,u : INTEGER;
BEGIN
  u := 0;
  l := length(nom);

  FOR i := 1 to l DO BEGIN
    IF (ord(nom[i]) < 65) or (ord(nom[i]) > 90) THEN BEGIN
      WRITELN('Erreur : Le nom entree "',nom,'" n''est pas exclusivement des lettres majuscules');
      halt;
      END
    ELSE BEGIN
      u := u + ((ord(nom[i]))-64);
    END;
  END;

  u := (u*47)+19;
  entree_nom := u;
END;

///////////////////////////////////Conversion///////////////////////////////////
FUNCTION StrAInt (p : INTEGER) : INTEGER;
VAR
  ope : STRING;
  i, anne : INTEGER;
BEGIN
  ope := IntToStr(p);
  anne := 0;
  FOR i := 1 TO length(ope) DO
    anne := anne + StrToInt(ope[i]);
  StrAInt := anne;
END;

////////////////////////////////Reincarnation///////////////////////////////////
PROCEDURE reincarnate(VAR str : tabStrdyn;VAR inte : tabIntdyn; x : INTEGER);
VAR
  nom : STRING;
  i,p : INTEGER;
BEGIN
  FOR i := 0 to (x-1) do BEGIN
    nom := str[i];
    inte[i] := entree_nom(nom);
    p := inte[i];
    inte[i] := StrAInt(p);
  END;
END;

/////////////////////////////////Affichage//////////////////////////////////////
PROCEDURE affiche(str : tabStrdyn; inte : tabIntdyn;x : INTEGER );
VAR
  i : INTEGER;
BEGIN
  WRITELN('Voici les prenoms selon leur avancement spirituel :');
  FOR i := 0 to x-1 DO BEGIN
    if (i = (x-1)) then
      WRITELN(str[i],' (',inte[i],')')
    ELSE
      WRITE(str[i],' (',inte[i],') - ');
  END;
END;

////////////////////////////////Tri/////////////////////////////////////////////
FUNCTION partitionner(VAR inte : tabIntdyn;VAR str : tabStrdyn; debut, fin: INTEGER): INTEGER;
VAR
    i, j, pivot,tmp: INTEGER;
    tmp1,pivotstr : STRING;
BEGIN
    pivot := inte[debut];
    pivotstr := str[debut];
    i := debut + 1;
    j := fin;
    WHILE (i <= j) DO
    BEGIN

        WHILE (i <= fin) AND (inte[i] < pivot) DO
          i := i+1;

        WHILE (j > debut) AND (inte[j] >= pivot) DO
          j := j-1;

        IF (i<j) THEN BEGIN
            tmp := inte[i];
            tmp1 := str[i];
            str[i] := str[j];
            inte[i] := inte[j];
            str[j] := tmp1;
            inte[j] := tmp;
        END;
    END;

    inte[debut] := inte[j];
    str[debut] := str[j];
    inte[j] := pivot;
    str[j] := pivotstr;
    partitionner := j;
END;

PROCEDURE triRapideRec(VAR inte : tabIntdyn;VAR str : tabStrdyn; debut , fin : INTEGER);
VAR
  pivot : INTEGER;
begin
  IF (debut < fin) THEN BEGIN
    pivot := partitionner(inte,str,debut,fin);
    triRapideRec(inte,str,debut,pivot-1);
    triRapideRec(inte,str,pivot+1,fin);
  END;
END;

PROCEDURE TriRapide(VAR inte : tabIntdyn;VAR str : tabStrdyn);
BEGIN
  triRapideRec(inte,str,0,length(inte)-1);
END;

//////////////////////////////////Affichage/////////////////////////////////////
PROCEDURE affireinc;
BEGIN
WRITELN('  ____      _                                  _   _');
WRITELN(' |  _ \ ___(_)_ __   ___ __ _ _ __ _ __   __ _| |_(_) ___  _ __');
WRITELN(' | |_) / _ \ | ''_ \ / __/ _` | ''__| ''_ \ / _` | __| |/ _ \| ''_ \');
WRITELN(' |  _ <  __/ | | | | (_| (_| | |  | | | | (_| | |_| | (_) | | | |');
WRITELN(' |_| \_\___|_|_| |_|\___\__,_|_|  |_| |_|\__,_|\__|_|\___/|_| |_|');
WRITELN('');
END;

PROCEDURE welcome;
BEGIN
  ClrScr;
  affireinc;
  WRITELN('Bienvenue dans la calculatrice du grand sage Shakacharaya');
END;

/////////////////////////////////Principal//////////////////////////////////////
PROCEDURE recin;
VAR
  x,i : INTEGER;
  noms : STRING;
  str : tabStrdyn;
  inte : tabIntdyn;
BEGIN
welcome;
WRITELN('Combien de noms voulez-vous entrer ?');
READLN(x);
setlength(str,x);
setlength(inte,x);
WRITELN('Veuillez entrer chaque nom en majuscule un par un :');
FOR i := 0 to x-1 DO BEGIN
  readln(noms);
  str[i] := noms;
END;

WRITELN('');

reincarnate(str,inte,x);
TriRapide(inte,str);
affiche(str,inte,x);
END;

END.
