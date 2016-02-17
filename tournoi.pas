UNIT

INTERFACE

USES

TYPE tabdyn1 = ARRAY OF STRING;
     tabdyn2 = ARRAY OF INTEGER;

VAR t1 : tabdyn1;
    t2 : tabdyn2;

FUNCTION result(VAR t1:tabdyn1; t2:tabdyn2);
    var i, x : integer;

        begin
          If t2[0] > t2[1] then
            writeln(t1[0],'vainqueur')
            if  t2[0] < t2[1] then
              writeln(t1[1],'vainqueur')
              else writeln('Match nul');

        end;
