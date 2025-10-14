CREATE OR REPLACE PROCEDURE obtener_partes_multiprovedor AS
  CURSOR partes_cursor IS
    SELECT p#
    FROM SP
    GROUP BY p#
    HAVING COUNT(s#) > 1;
    
  v_p_num SP.P#%TYPE;

BEGIN
  DBMS_OUTPUT.PUT_LINE('-------------------------------------');
  DBMS_OUTPUT.PUT_LINE('P# (Abastecida por más de 1 proveedor)');
  DBMS_OUTPUT.PUT_LINE('-------------------------------------');

  OPEN partes_cursor;
  LOOP
    FETCH partes_cursor INTO v_p_num;
    EXIT WHEN partes_cursor%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE(v_p_num);
  END LOOP;
  CLOSE partes_cursor;
  DBMS_OUTPUT.PUT_LINE('-------------------------------------');
END;
/