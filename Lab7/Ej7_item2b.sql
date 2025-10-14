CREATE OR REPLACE PROCEDURE obtener_peso_en_gramos AS
  CURSOR partes_cursor IS
    SELECT p#, weight
    FROM P;
    
  v_p_num P.P#%TYPE;
  v_weight_lb P.WEIGHT%TYPE;
  v_weight_g NUMBER;
  
BEGIN
  DBMS_OUTPUT.PUT_LINE('-----------------------------');
  DBMS_OUTPUT.PUT_LINE('P# | Peso (Libras) | Peso (Gramos)');
  DBMS_OUTPUT.PUT_LINE('-----------------------------');

  OPEN partes_cursor;
  LOOP
    FETCH partes_cursor INTO v_p_num, v_weight_lb;
    EXIT WHEN partes_cursor%NOTFOUND;
    
    v_weight_g := libras_a_gramos(v_weight_lb);
    
    DBMS_OUTPUT.PUT_LINE(v_p_num || ' | ' || v_weight_lb || ' | ' || ROUND(v_weight_g, 2));
  END LOOP;
  CLOSE partes_cursor;
  DBMS_OUTPUT.PUT_LINE('-----------------------------');
END;
/