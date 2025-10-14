SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE obtener_partes_filtradas AS
  CURSOR partes_cursor IS
    SELECT color, city
    FROM P
    WHERE city != 'Paris' AND weight > 10;
  
  v_color P.COLOR%TYPE;
  v_city P.CITY%TYPE;

BEGIN
  DBMS_OUTPUT.PUT_LINE('-----------------------------');
  DBMS_OUTPUT.PUT_LINE('Color | Ciudad');
  DBMS_OUTPUT.PUT_LINE('-----------------------------');

  OPEN partes_cursor;
  LOOP
    FETCH partes_cursor INTO v_color, v_city;
    EXIT WHEN partes_cursor%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE(v_color || ' | ' || v_city);
  END LOOP;
  CLOSE partes_cursor;
  DBMS_OUTPUT.PUT_LINE('-----------------------------');
END;
/