BEGIN
    UPDATE employees
    SET salary = salary * 1.10
    WHERE department_id = 90;
    
    SAVEPOINT punto1;
    
    UPDATE employees
    SET salary = salary * 1.05
    WHERE department_id = 60;
    
    ROLLBACK TO SAVEPOINT punto1;
    
    COMMIT;
END;
/