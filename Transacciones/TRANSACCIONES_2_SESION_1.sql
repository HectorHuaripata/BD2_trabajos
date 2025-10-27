UPDATE employees
SET salary = salary + 500
WHERE employee_id = 103;

-- ESPERAR QUE TERMINE LA SESION 2
ROLLBACK;