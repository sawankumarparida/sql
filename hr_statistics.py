import pandas as pd
import mysql.connector
import scipy.stats as stats

print("🔬 Initializing HR Statistical Analysis...\n")

# 1. Connect to Database and Fetch Data
try:
    connection = mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="Snmr@7875",  # <-- Update this
        database="hr_sandbox"
    )
    
    query = """
    SELECT d.dept_name, s.base_salary, pr.appraisal_score 
    FROM Employees e
    JOIN Departments d ON e.dept_id = d.dept_id
    JOIN Salaries s ON e.emp_id = s.emp_id
    JOIN Performance_Reviews pr ON e.emp_id = pr.emp_id;
    """
    df = pd.read_sql(query, connection)
    connection.close()

except Exception as e:
    print(f"Database connection failed: {e}")
    exit()

# ---------------------------------------------------------
# TEST 1: ANOVA (Salary Differences by Department)
# ---------------------------------------------------------
print("📊 TEST 1: ANOVA (Compensation Equity)")
print("Hypothesis: Base salaries are equal across all departments.")

# Separate the salaries into lists by department
eng_salaries = df[df['dept_name'] == 'Engineering']['base_salary']
sales_salaries = df[df['dept_name'] == 'Sales']['base_salary']
mkt_salaries = df[df['dept_name'] == 'Marketing']['base_salary']

# Run the One-Way ANOVA
f_stat, p_value_anova = stats.f_oneway(eng_salaries, sales_salaries, mkt_salaries)

print(f"F-Statistic: {f_stat:.2f}")
print(f"P-Value:     {p_value_anova:.4f}")

if p_value_anova < 0.05:
    print("🚨 CONCLUSION: Reject the null hypothesis. There is a statistically significant pay gap between departments.\n")
else:
    print("✅ CONCLUSION: Fail to reject the null hypothesis. Pay variance between departments is not statistically significant.\n")


# ---------------------------------------------------------
# TEST 2: CHI-SQUARE (Appraisal Bias)
# ---------------------------------------------------------
print("📊 TEST 2: CHI-SQUARE (Performance Review Bias)")
print("Hypothesis: Performance scores are independent of department.")

# Create a contingency table (cross-tabulation of Department vs Score)
contingency_table = pd.crosstab(df['dept_name'], df['appraisal_score'])

# Run the Chi-Square Test
chi2_stat, p_value_chi, dof, expected = stats.chi2_contingency(contingency_table)

print(f"Chi2-Statistic: {chi2_stat:.2f}")
print(f"P-Value:        {p_value_chi:.4f}")

if p_value_chi < 0.05:
    print("🚨 CONCLUSION: Reject the null hypothesis. There is a statistical bias in how departments grade their employees.")
else:
    print("✅ CONCLUSION: Fail to reject the null hypothesis. Performance scores are distributed fairly across departments.")