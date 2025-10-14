CREATE OR REPLACE PROCEDURE obtener_proveedores_todas_partes AS
  v_total_partes NUMBER;
  
  CURSOR proveedores_cursor IS
    SELECT s.sname
    FROM S s
    JOIN SP sp ON s.s# = sp.s#
    GROUP BY s.sname
    HAVING COUNT(DISTINCT sp.p#) = v_total_partes;
    
  v_s_name S.SNAME%TYPE;

BEGIN
  -- 1. Obtener el número total de partes distintas
  SELECT COUNT(DISTINCT p#) INTO v_total_partes FROM P;
  
  DBMS_OUTPUT.PUT_LINE('--------------------------------------');
  DBMS_OUTPUT.PUT_LINE('SNAME (Abastece TODAS las partes: ' || v_total_partes || ')');
  DBMS_OUTPUT.PUT_LINE('--------------------------------------');

  -- 2. Recorrer los proveedores que cumplen la condición
  OPEN proveedores_cursor;
  LOOP
    FETCH proveedores_cursor INTO v_s_name;
    EXIT WHEN proveedores_cursor%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE(v_s_name);
  END LOOP;
  CLOSE proveedores_cursor;
  DBMS_OUTPUT.PUT_LINE('--------------------------------------');
END;
/