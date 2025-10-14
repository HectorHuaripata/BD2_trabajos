CREATE OR REPLACE PROCEDURE obtener_pares_proveedores_co_localizados AS
  CURSOR pares_cursor IS
    SELECT s1.s# AS s_num_1, s2.s# AS s_num_2, s1.city
    FROM S s1, S s2
    WHERE s1.city = s2.city
      AND s1.s# < s2.s#; -- Condición para obtener pares únicos
      
  v_s_num_1 S.S#%TYPE;
  v_s_num_2 S.S#%TYPE;
  v_city S.CITY%TYPE;

BEGIN
  DBMS_OUTPUT.PUT_LINE('--------------------------');
  DBMS_OUTPUT.PUT_LINE('Proveedor 1 | Proveedor 2 | Ciudad');
  DBMS_OUTPUT.PUT_LINE('--------------------------');

  OPEN pares_cursor;
  LOOP
    FETCH pares_cursor INTO v_s_num_1, v_s_num_2, v_city;
    EXIT WHEN pares_cursor%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE(v_s_num_1 || ' | ' || v_s_num_2 || ' | ' || v_city);
  END LOOP;
  CLOSE pares_cursor;
  DBMS_OUTPUT.PUT_LINE('--------------------------');
END;
/