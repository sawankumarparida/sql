import streamlit as st
import pandas as pd
import mysql.connector

# 1. Dashboard Configuration
st.set_page_config(page_title="HR Analytics Dashboard", layout="wide")
st.title("👥 HR Executive Dashboard: Retention & Compensation")
st.markdown("Live People Analytics feed from the WSL MySQL HR Sandbox.")

# 2. Database Connection & Data Merging
@st.cache_data
def fetch_hr_data():
    connection = mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="Snmr@7875",  # <-- Put your MySQL password here
        database="hr_sandbox"
    )
    # We write a custom query to join our Master Report with our Quartile Math!
    query = """
    SELECT 
        m.first_name, 
        m.last_name, 
        m.dept_name, 
        m.base_salary, 
        m.appraisal_score, 
        m.leadership_potential,
        m.tenure_years,
        c.Company_Pay_Quartile
    FROM vw_master_hr_report m
    JOIN vw_compensation_quartiles c 
      ON m.first_name = c.Employee AND m.dept_name = c.Department;
    """
    df = pd.read_sql(query, connection)
    connection.close()
    return df

# 3. Main Application Logic
try:
    df = fetch_hr_data()
    
    # --- SIDEBAR INTERACTIVITY ---
    st.sidebar.header("🎯 Department Filter")
    departments = ["All Departments"] + list(df["dept_name"].unique())
    selected_dept = st.sidebar.selectbox("Select a target department:", departments)
    
    if selected_dept != "All Departments":
        df = df[df["dept_name"] == selected_dept]
    # ------------------------------

    # 4. Executive Summary Metrics
    # Calculate exactly how many high-performers are in the bottom 50% of pay
    flight_risks = len(df[(df["appraisal_score"] >= 4) & (df["Company_Pay_Quartile"] <= 2)])
    avg_salary = df["base_salary"].mean()
    
    col1, col2, col3 = st.columns(3)
    col1.metric("Total Headcount", len(df))
    col2.metric("Average Salary", f"${avg_salary:,.0f}")
    col3.metric("🚨 High-Value Flight Risks", flight_risks, help="Score >= 4, but Pay Quartile 1 or 2")
    
    st.divider()

    # 5. Visualizations
    col_chart1, col_chart2 = st.columns(2)
    
    with col_chart1:
        st.subheader("Compensation Distribution")
        # A clean bar chart showing salaries colored by department
        st.bar_chart(df, x="first_name", y="base_salary", color="dept_name")
        
    with col_chart2:
        st.subheader("Performance vs. Pay Quartile")
        # A scatter chart plotting appraisal score against their pay band
        st.scatter_chart(
            df, 
            x="appraisal_score", 
            y="Company_Pay_Quartile", 
            color="leadership_potential",
            size="base_salary"
        )
        
    # 6. Raw Data Feed
    st.subheader("Detailed Employee Roster")
    st.dataframe(df, use_container_width=True)

except Exception as e:
    st.error(f"Failed to connect to the database: {e}")