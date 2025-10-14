CREATE OR REPLACE PROCEDURE obtener_detalles_proveedores AS
  CURSOR proveedores_cursor IS
    SELECT S#, SNAME, STATUS, CITY
    FROM S;
    
  v_s_num S.S#%TYPE;
  v_s_name S.SNAME%TYPE;
  v_status S.STATUS%TYPE;
  v_city S.CITY%TYPE;

BEGIN
  DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
  DBMS_OUTPUT.PUT_LINE('S# | SNAME | STATUS | CITY');
  DBMS_OUTPUT.PUT_LINE('-------------------------------------------');

  OPEN proveedores_cursor;
  LOOP
    FETCH proveedores_cursor INTO v_s_num, v_s_name, v_status, v_city;
    EXIT WHEN proveedores_cursor%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE(v_s_num || ' | ' || v_s_name || ' | ' || v_status || ' | ' || v_city);
  END LOOP;
  CLOSE proveedores_cursor;
  DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
END;
/