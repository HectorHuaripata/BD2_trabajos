CREATE OR REPLACE PROCEDURE obtener_pares_ciudades_abastecimiento AS
  CURSOR ciudades_cursor IS
    SELECT DISTINCT s.city AS ciudad_proveedor, p.city AS ciudad_parte
    FROM S s
    JOIN SP sp ON s.s# = sp.s#
    JOIN P p ON sp.p# = p.p#;
    
  v_city_supplier S.CITY%TYPE;
  v_city_part P.CITY%TYPE;

BEGIN
  DBMS_OUTPUT.PUT_LINE('-------------------------------------');
  DBMS_OUTPUT.PUT_LINE('Ciudad Proveedor | Ciudad Parte');
  DBMS_OUTPUT.PUT_LINE('-------------------------------------');

  OPEN ciudades_cursor;
  LOOP
    FETCH ciudades_cursor INTO v_city_supplier, v_city_part;
    EXIT WHEN ciudades_cursor%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE(v_city_supplier || ' | ' || v_city_part);
  END LOOP;
  CLOSE ciudades_cursor;
  DBMS_OUTPUT.PUT_LINE('-------------------------------------');
END;
/