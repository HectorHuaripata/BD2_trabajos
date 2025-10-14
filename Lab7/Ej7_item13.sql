CREATE OR REPLACE PROCEDURE obtener_proveedores_estado_menor_max AS
  v_max_status S.STATUS%TYPE;
  
  CURSOR proveedores_cursor IS
    SELECT s#
    FROM S
    WHERE status < v_max_status;
    
  v_s_num S.S#%TYPE;

BEGIN
  -- 1. Obtener el estado máximo
  SELECT MAX(status) INTO v_max_status FROM S;
  
  DBMS_OUTPUT.PUT_LINE('-------------------------------------');
  DBMS_OUTPUT.PUT_LINE('Estado Máximo en S: ' || v_max_status);
  DBMS_OUTPUT.PUT_LINE('S# (con STATUS < ' || v_max_status || ')');
  DBMS_OUTPUT.PUT_LINE('-------------------------------------');

  -- 2. Recorrer los proveedores con estado menor al máximo
  OPEN proveedores_cursor;
  LOOP
    FETCH proveedores_cursor INTO v_s_num;
    EXIT WHEN proveedores_cursor%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE(v_s_num);
  END LOOP;
  CLOSE proveedores_cursor;
  DBMS_OUTPUT.PUT_LINE('-------------------------------------');
END;
/