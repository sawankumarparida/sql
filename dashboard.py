import streamlit as st
import pandas as pd
import mysql.connector

# 1. Dashboard Header
st.set_page_config(page_title="Executive Dashboard", layout="wide")
st.title("📊 Corporate Revenue Dashboard")
st.markdown("Live data pulled directly from the WSL MySQL Engine.")

# 2. Database Connection Function
@st.cache_data # This tells Streamlit to cache the data so it doesn't crash the database
def fetch_data():
    connection = mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="Snmr@7875",  # <-- Put your MySQL password here
        database="ba_sandbox"
    )
    # Query our permanent view!
    query = "SELECT * FROM vw_executive_revenue_report;"
    df = pd.read_sql(query, connection)
    connection.close()
    return df

# 3. Fetch and Display the Data
try:
    data = fetch_data()
    
    # Create two columns for a clean layout
    col1, col2 = st.columns(2)
    
    with col1:
        st.subheader("Raw Data Feed")
        st.dataframe(data, use_container_width=True)
        
    with col2:
        st.subheader("Running Revenue Trend")
        # Streamlit automatically builds a beautiful line chart with one line of code!
        st.line_chart(data, x="Date", y="Running Total Revenue")

except Exception as e:
    st.error(f"Failed to connect to the database: {e}")