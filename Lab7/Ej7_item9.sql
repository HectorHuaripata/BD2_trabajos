CREATE OR REPLACE PROCEDURE obtener_total_despachado_por_parte AS
  CURSOR total_por_parte_cursor IS
    SELECT p#, SUM(qty) AS total_qty
    FROM SP
    GROUP BY p#
    ORDER BY p#;
    
  v_p_num SP.P#%TYPE;
  v_total_qty NUMBER;

BEGIN
  DBMS_OUTPUT.PUT_LINE('-------------------------------------');
  DBMS_OUTPUT.PUT_LINE('P# | Total Despachado (QTY)');
  DBMS_OUTPUT.PUT_LINE('-------------------------------------');

  OPEN total_por_parte_cursor;
  LOOP
    FETCH total_por_parte_cursor INTO v_p_num, v_total_qty;
    EXIT WHEN total_por_parte_cursor%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE(v_p_num || ' | ' || v_total_qty);
  END LOOP;
  CLOSE total_por_parte_cursor;
  DBMS_OUTPUT.PUT_LINE('-------------------------------------');
END;
/