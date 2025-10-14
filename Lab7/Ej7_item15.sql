CREATE OR REPLACE PROCEDURE obtener_proveedores_no_p2_not_exists AS
  CURSOR proveedores_cursor IS
    SELECT s.sname
    FROM S s
    WHERE NOT EXISTS (
      SELECT 1
      FROM SP sp
      WHERE sp.s# = s.s# AND sp.p# = 'P2'
    );
    
  v_s_name S.SNAME%TYPE;

BEGIN
  DBMS_OUTPUT.PUT_LINE('---------------------------------');
  DBMS_OUTPUT.PUT_LINE('SNAME (NO abastece P2 - con NOT EXISTS)');
  DBMS_OUTPUT.PUT_LINE('---------------------------------');

  OPEN proveedores_cursor;
  LOOP
    FETCH proveedores_cursor INTO v_s_name;
    EXIT WHEN proveedores_cursor%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE(v_s_name);
  END LOOP;
  CLOSE proveedores_cursor;
  DBMS_OUTPUT.PUT_LINE('---------------------------------');
END;
/