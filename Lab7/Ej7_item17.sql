CREATE OR REPLACE PROCEDURE obtener_partes_union_criterios AS
  CURSOR partes_cursor IS
    -- Partes que pesan más de 16 libras
    SELECT p# FROM P WHERE weight > 16
    UNION
    -- Partes abastecidas por el proveedor S2
    SELECT p# FROM SP WHERE s# = 'S2';
    
  v_p_num P.P#%TYPE;

BEGIN
  DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
  DBMS_OUTPUT.PUT_LINE('P# (Peso > 16 Lbs OR Abastecida por S2)');
  DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');

  OPEN partes_cursor;
  LOOP
    FETCH partes_cursor INTO v_p_num;
    EXIT WHEN partes_cursor%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE(v_p_num);
  END LOOP;
  CLOSE partes_cursor;
  DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
END;
/