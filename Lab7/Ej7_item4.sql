CREATE OR REPLACE PROCEDURE obtener_co_localizados AS
  CURSOR co_localizados_cursor IS
    SELECT s.s#, s.sname, p.p#, p.pname, s.city
    FROM S s, P p
    WHERE s.city = p.city;
    
  v_s_num S.S#%TYPE;
  v_s_name S.SNAME%TYPE;
  v_p_num P.P#%TYPE;
  v_p_name P.PNAME%TYPE;
  v_city S.CITY%TYPE;

BEGIN
  DBMS_OUTPUT.PUT_LINE('-----------------------------------------------');
  DBMS_OUTPUT.PUT_LINE('S# | SNAME | P# | PNAME | Ciudad (co-localizados)');
  DBMS_OUTPUT.PUT_LINE('-----------------------------------------------');

  OPEN co_localizados_cursor;
  LOOP
    FETCH co_localizados_cursor INTO v_s_num, v_s_name, v_p_num, v_p_name, v_city;
    EXIT WHEN co_localizados_cursor%NOTFOUND;
    
    DBMS_OUTPUT.PUT_LINE(v_s_num || ' | ' || v_s_name || ' | ' || v_p_num || ' | ' || v_p_name || ' | ' || v_city);
  END LOOP;
  CLOSE co_localizados_cursor;
  DBMS_OUTPUT.PUT_LINE('-----------------------------------------------');
END;
/