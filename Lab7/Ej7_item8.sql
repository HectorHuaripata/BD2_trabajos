CREATE OR REPLACE PROCEDURE obtener_min_max_cantidad_p2 AS
  v_min_qty SP.QTY%TYPE;
  v_max_qty SP.QTY%TYPE;
BEGIN
  SELECT MIN(qty), MAX(qty)
  INTO v_min_qty, v_max_qty
  FROM SP
  WHERE p# = 'P2';
  
  DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
  DBMS_OUTPUT.PUT_LINE('Parte: P2');
  DBMS_OUTPUT.PUT_LINE('Cantidad Mínima: ' || v_min_qty);
  DBMS_OUTPUT.PUT_LINE('Cantidad Máxima: ' || v_max_qty);
  DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
  
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No hay envíos registrados para la parte P2.');
END;
/