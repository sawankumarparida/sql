import pandas as pd
import mysql.connector

print("🔄 Connecting to HR Sandbox...")

try:
    # IMPORTANT: Update with your actual local MySQL password
    connection = mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="Snmr@7875", 
        database="hr_sandbox"
    )
    
    # The advanced CASE query
    query = """
    SELECT 
        e.emp_id AS 'ID',
        e.first_name AS 'First Name',
        e.last_name AS 'Last Name',
        d.dept_name AS 'Department',
        s.base_salary AS 'Salary',
        pr.appraisal_score AS 'Score',
        pr.leadership_potential AS 'Potential',
        CASE 
            WHEN pr.appraisal_score >= 4 AND pr.leadership_potential = 'High' AND s.base_salary < da.avg_dept_salary 
                THEN '🚨 HIGH FLIGHT RISK'
            WHEN pr.appraisal_score >= 4 
                THEN '✅ Strong Performer'
            ELSE '📊 Standard Review'
        END AS 'Retention Status'
    FROM Employees e
    JOIN Salaries s ON e.emp_id = s.emp_id
    JOIN Performance_Reviews pr ON e.emp_id = pr.emp_id
    JOIN Departments d ON e.dept_id = d.dept_id
    JOIN (
        SELECT e2.dept_id, AVG(s2.base_salary) AS avg_dept_salary 
        FROM Salaries s2 
        JOIN Employees e2 ON s2.emp_id = e2.emp_id 
        GROUP BY e2.dept_id
    ) da ON e.dept_id = da.dept_id;
    """
    
    print("📊 Executing query and building report...")
    # Load data into a Pandas DataFrame
    df = pd.read_sql(query, connection)
    connection.close()

    # Export directly to an Excel file in the current directory
    filename = "flight_risk_report.xlsx"
    df.to_excel(filename, index=False, engine='openpyxl')
    
    print(f"✅ Success! Data successfully exported to {filename}")

except Exception as e:
    print(f"❌ Failed to connect or export: {e}")