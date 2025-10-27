DECLARE
    v_old_job_id     employees.job_id%TYPE;
    v_old_dept_id    employees.department_id%TYPE;
    v_start_date     job_history.start_date%TYPE;
BEGIN
    SELECT job_id, department_id, hire_date
    INTO v_old_job_id, v_old_dept_id, v_start_date
    FROM employees
    WHERE employee_id = 104;

    UPDATE employees
    SET department_id = 110
    WHERE employee_id = 104;
    
    INSERT INTO job_history (employee_id, start_date, end_date, job_id, department_id)
    VALUES (104, v_start_date, SYSDATE, v_old_job_id, v_old_dept_id);
    
    ----------------------------------------------------------------------------
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Empleado 104 transferido y historial registrado exitosamente.');

EXCEPTION

    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error durante la transferencia. Revirtiendo cambios. Error: ' || SQLERRM);
END;
/