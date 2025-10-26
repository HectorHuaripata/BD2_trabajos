CREATE OR REPLACE PACKAGE EMPLOYEE_PKG AS
    PROCEDURE P_INSERT_EMPLOYEE(
        P_EMPLOYEE_ID     IN EMPLOYEES.EMPLOYEE_ID%TYPE,
        P_FIRST_NAME      IN EMPLOYEES.FIRST_NAME%TYPE,
        P_LAST_NAME       IN EMPLOYEES.LAST_NAME%TYPE,
        P_EMAIL           IN EMPLOYEES.EMAIL%TYPE,
        P_PHONE_NUMBER    IN EMPLOYEES.PHONE_NUMBER%TYPE,
        P_HIRE_DATE       IN EMPLOYEES.HIRE_DATE%TYPE,
        P_JOB_ID          IN EMPLOYEES.JOB_ID%TYPE,
        P_SALARY          IN EMPLOYEES.SALARY%TYPE,
        P_COMMISSION_PCT  IN EMPLOYEES.COMMISSION_PCT%TYPE,
        P_MANAGER_ID      IN EMPLOYEES.MANAGER_ID%TYPE,
        P_DEPARTMENT_ID   IN EMPLOYEES.DEPARTMENT_ID%TYPE
    );
    
    PROCEDURE P_UPDATE_EMPLOYEE(
        P_EMPLOYEE_ID     IN EMPLOYEES.EMPLOYEE_ID%TYPE,
        P_FIRST_NAME      IN EMPLOYEES.FIRST_NAME%TYPE,
        P_LAST_NAME       IN EMPLOYEES.LAST_NAME%TYPE,
        P_EMAIL           IN EMPLOYEES.EMAIL%TYPE,
        P_PHONE_NUMBER    IN EMPLOYEES.PHONE_NUMBER%TYPE,
        P_HIRE_DATE       IN EMPLOYEES.HIRE_DATE%TYPE,
        P_JOB_ID          IN EMPLOYEES.JOB_ID%TYPE,
        P_SALARY          IN EMPLOYEES.SALARY%TYPE,
        P_COMMISSION_PCT  IN EMPLOYEES.COMMISSION_PCT%TYPE,
        P_MANAGER_ID      IN EMPLOYEES.MANAGER_ID%TYPE,
        P_DEPARTMENT_ID   IN EMPLOYEES.DEPARTMENT_ID%TYPE
    );

    PROCEDURE P_DELETE_EMPLOYEE(
        P_EMPLOYEE_ID     IN EMPLOYEES.EMPLOYEE_ID%TYPE
    );
    
    PROCEDURE SHOW_TOP_JOB_ROTATORS;
    
    FUNCTION GET_AVG_HIRES_BY_MONTH RETURN NUMBER;
    
    PROCEDURE SHOW_REGIONAL_STATS;
    
    FUNCTION calculate_service_time_and_vacation RETURN NUMBER;
    
END EMPLOYEE_PKG;
/

CREATE OR REPLACE PACKAGE BODY EMPLOYEE_PKG AS

    PROCEDURE P_INSERT_EMPLOYEE AS
    BEGIN
        INSERT INTO EMPLOYEES (
            EMPLOYEE_ID,
            FIRST_NAME,
            LAST_NAME,
            EMAIL,
            PHONE_NUMBER,
            HIRE_DATE,
            JOB_ID,
            SALARY,
            COMMISSION_PCT,
            MANAGER_ID,
            DEPARTMENT_ID
        ) VALUES (
            P_EMPLOYEE_ID,
            P_FIRST_NAME,
            P_LAST_NAME,
            P_EMAIL,
            P_PHONE_NUMBER,
            P_HIRE_DATE,
            P_JOB_ID,
            P_SALARY,
            P_COMMISSION_PCT,
            P_MANAGER_ID,
            P_DEPARTMENT_ID
        );
        COMMIT;
        
    END P_INSERT_EMPLOYEE;
    
    PROCEDURE P_UPDATE_EMPLOYEE AS
    BEGIN
        UPDATE EMPLOYEES SET
        FIRST_NAME = P_FIRST_NAME,
        LAST_NAME = P_LAST_NAME,
        EMAIL = P_EMAIL,
        PHONE_NUMBER = P_PHONE_NUMBER,
        HIRE_DATE = P_HIRE_DATE,
        JOB_ID = P_JOB_ID,
        SALARY = P_SALARY,
        COMMISSION_PCT = P_COMMISSION_PCT,
        MANAGER_ID = P_MANAGER_ID,
        DEPARTMENT_ID = P_DEPARTMENT_ID
        WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;
        COMMIT;
        
    END P_UPDATE_EMPLOYEE;

    PROCEDURE P_DELETE_EMPLOYEE AS
    BEGIN
        DELETE FROM EMPLOYEES WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;
        COMMIT;
    END P_DELETE_EMPLOYEE;

    PROCEDURE SHOW_TOP_JOB_ROTATORS AS
      CURSOR C_ROTATIONS IS
        SELECT
          e.EMPLOYEE_ID,
          e.LAST_NAME,
          e.FIRST_NAME,
          e.JOB_ID AS CURRENT_JOB_ID,
          j.JOB_TITLE AS CURRENT_JOB_TITLE,
          (SELECT COUNT(*) FROM JOB_HISTORY jh WHERE jh.EMPLOYEE_ID = e.EMPLOYEE_ID) AS ROTATION_COUNT
        FROM EMPLOYEES e
        JOIN JOBS j ON e.JOB_ID = j.JOB_ID
        ORDER BY ROTATION_COUNT DESC
        FETCH FIRST 4 ROWS ONLY; -- solo los 4 primeros
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Cod. Empleado | Apellido, Nombre | Cod. Puesto | Nombre Puesto | Cambios');
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------');
        FOR rec IN c_rotations LOOP
          DBMS_OUTPUT.PUT_LINE(rec.EMPLOYEE_ID || ' | ' || rec.LAST_NAME || ', ' || rec.FIRST_NAME || ' | ' 
            || rec.CURRENT_JOB_ID || ' | ' || rec.CURRENT_JOB_TITLE || ' | ' || rec.ROTATION_COUNT);
        END LOOP;
    END SHOW_TOP_JOB_ROTATORS;

--------------------------------------------------------------------------------

    FUNCTION GET_AVG_HIRES_BY_MONTH RETURN NUMBER IS-- Retorna el total de meses considerados
        V_TOTAL_MONTHS NUMBER;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nombre del Mes | Promedio de Contrataciones');
        DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    FOR rec IN (
        SELECT
          TO_CHAR(HIRE_DATE, 'Month') AS month_name,
          COUNT(*) / COUNT(DISTINCT TO_CHAR(HIRE_DATE, 'YYYY')) AS avg_hires -- Total hires / Total years in data
        FROM EMPLOYEES
        GROUP BY TO_CHAR(HIRE_DATE, 'Month'), TO_CHAR(HIRE_DATE, 'MM') -- Group by month name and sort by month number
        ORDER BY TO_CHAR(HIRE_DATE, 'MM')
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(rec.month_name, 15) || ' | ' || TO_CHAR(rec.avg_hires, '99.99'));
    END LOOP;    
    SELECT COUNT(DISTINCT TO_CHAR(HIRE_DATE, 'MM')) INTO V_TOTAL_MONTHS FROM EMPLOYEES;
    RETURN V_TOTAL_MONTHS;
    END GET_AVG_HIRES_BY_MONTH;
    
--------------------------------------------------------------------------------

    PROCEDURE SHOW_REGIONAL_STATS IS
    BEGIN
      DBMS_OUTPUT.PUT_LINE('Region | Suma Salarios | Cant. Empleados | Fecha Ingreso Más Antiguo');
      DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------');
    
      FOR rec IN (
        SELECT
          r.REGION_NAME,
          SUM(e.SALARY) AS total_salary,
          COUNT(e.EMPLOYEE_ID) AS employee_count,
          MIN(e.HIRE_DATE) AS oldest_hire_date
        FROM REGIONS r
        JOIN COUNTRIES c ON r.REGION_ID = c.REGION_ID
        JOIN LOCATIONS l ON c.COUNTRY_ID = l.COUNTRY_ID
        JOIN DEPARTMENTS d ON l.LOCATION_ID = d.LOCATION_ID
        JOIN EMPLOYEES e ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
        GROUP BY r.REGION_NAME
        ORDER BY r.REGION_NAME
      ) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.region_name || ' | ' || TO_CHAR(rec.total_salary, 'FM999,999.00') 
          || ' | ' || rec.employee_count || ' | ' || TO_CHAR(rec.oldest_hire_date, 'DD-MON-YYYY'));
      END LOOP;
    END SHOW_REGIONAL_STATS;
    
--------------------------------------------------------------------------------

    FUNCTION CALCULATE_SERVICE_TIME_AND_VACATION
      RETURN NUMBER -- Retorna el monto total de salarios
    IS
      V_TOTAL_SALARY_AMOUNT NUMBER;
    BEGIN
      DBMS_OUTPUT.PUT_LINE('Empleado | Tiempo Servicio (Años) | Meses Vacaciones Correspondientes');
      DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------');
    
      FOR rec IN (
        SELECT
          EMPLOYEE_ID,
          FIRST_NAME || ' ' || LAST_NAME AS FULL_NAME,
          MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12 AS YEARS_OF_SERVICE,
          TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) / 12) AS VACATION_MONTHS -- 1 month for each full year
        FROM EMPLOYEES
        ORDER BY EMPLOYEE_ID
      ) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.full_name || ' | ' || TO_CHAR(rec.years_of_service, '99.99') 
          || ' | ' || rec.vacation_months);
      END LOOP;
    
      SELECT SUM(SALARY) INTO V_TOTAL_SALARY_AMOUNT FROM EMPLOYEES;
    
      RETURN V_TOTAL_SALARY_AMOUNT;
    END CALCULATE_SERVICE_TIME_AND_VACATION;

END EMPLOYEE_PKG;
/