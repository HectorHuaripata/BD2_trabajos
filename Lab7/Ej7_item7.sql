CREATE OR REPLACE FUNCTION contar_proveedores
  RETURN NUMBER
IS
  v_total_proveedores NUMBER;
BEGIN
  SELECT COUNT(s#)
  INTO v_total_proveedores
  FROM S;
  
  RETURN v_total_proveedores;
END;
/