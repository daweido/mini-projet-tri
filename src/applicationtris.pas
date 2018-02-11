PROGRAM Application_tris;
USES
  reincarnation,tournoi,crt;
VAR
  i : STRING;
BEGIN
  ClrScr;
  WRITELN('  ______');
  WRITELN(' /\__  _\        __');
  WRITELN(' \/_/\ \/ _ __  /\_\    ____');
  WRITELN('    \ \ \/\`''__ \/\ \  /'',__\');
  WRITELN('     \ \ \ \ \/  \ \ \/\__, `\');
  WRITELN('      \ \_\ \_\   \ \_\/\____/');
  WRITELN('       \/_/\/_/    \/_/\/___/');
  WRITELN('Bonjour et bievenu dans le menu du mini-projet : Application des tris');
  WRITELN('Que voulez vous faire ?');
  WRITELN('1. Reincarnation');
  WRITELN('2. Tournoi de football');

  READLN(i);
  IF (i = '1') THEN
    recin
  ELSE IF (i = '2') THEN
    tournois
  ELSE
    WRITELN('Erreur : Mauvaise entree');
END.
