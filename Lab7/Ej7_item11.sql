CREATE OR REPLACE PROCEDURE obtener_proveedores_p2 AS
  CURSOR proveedores_cursor IS
    SELECT DISTINCT s.sname
    FROM S s
    JOIN SP sp ON s.s# = sp.s#
    WHERE sp.p# = 'P2';
    
  v_s_name S.SNAME%TYPE;

BEGIN
  DBMS_OUTPUT.PUT_LINE('-----------------------------');
  DBMS_OUTPUT.PUT_LINE('SNAME (Abastece P2)');
  DBMS_OUTPUT.PUT_LINE('-----------------------------');

  OPEN proveedores_cursor;
  LOOP
    FETCH proveedores_cursor INTO v_s_name;
    EXIT WHEN proveedores_cursor%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE(v_s_name);
  END LOOP;
  CLOSE proveedores_cursor;
  DBMS_OUTPUT.PUT_LINE('-----------------------------');
END;
/