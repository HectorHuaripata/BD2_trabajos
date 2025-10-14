CREATE OR REPLACE FUNCTION libras_a_gramos (p_weight_lb IN NUMBER)
  RETURN NUMBER
IS
  v_conversion_factor CONSTANT NUMBER := 453.592; -- 1 liba = 453.592 gramos aprox
BEGIN
  RETURN p_weight_lb * v_conversion_factor;
END;
/