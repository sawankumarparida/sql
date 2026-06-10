import streamlit as st
import pandas as pd
import mysql.connector

# 1. Dashboard Header
st.set_page_config(page_title="Executive Dashboard", layout="wide")
st.title("📊 Interactive Corporate Revenue Dashboard")

# 2. Database Connection Function
@st.cache_data
def fetch_data():
    connection = mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="Snmr@7875",  # <-- Put your MySQL password here
        database="ba_sandbox"
    )
    query = "SELECT * FROM vw_executive_revenue_report;"
    df = pd.read_sql(query, connection)
    connection.close()
    return df

# 3. Main Application Logic
try:
    # Fetch master dataset
    master_data = fetch_data()
    
    # --- SIDEBAR INTERACTIVITY ---
    st.sidebar.header("🎯 Filter Options")
    
    # Create a unique list of clients and add an "All Companies" option
    client_list = ["All Companies"] + list(master_data["Client"].unique())
    
    # Render the dropdown menu in the sidebar
    selected_client = st.sidebar.selectbox("Select a Client to Analyze:", client_list)
    
    # Filter the dataset based on the user's selection
    if selected_client == "All Companies":
        filtered_data = master_data
    else:
        filtered_data = master_data[master_data["Client"] == selected_client]
    # ------------------------------

    # 4. Display Dynamic Metrics
    total_rev = filtered_data["Order Value"].sum()
    st.metric(label=f"Total Revenue ({selected_client})", value=f"${total_rev:,.2f}")
    
    # 5. Render Layout Columns
    col1, col2 = st.columns(2)
    
    with col1:
        st.subheader("Filtered Data Feed")
        st.dataframe(filtered_data, use_container_width=True)
        
    with col2:
        st.subheader("Revenue Progression")
        # If analyzing a specific company, show individual order values; otherwise, show running total
        if selected_client == "All Companies":
            st.line_chart(filtered_data, x="Date", y="Running Total Revenue")
        else:
            st.bar_chart(filtered_data, x="Date", y="Order Value")

except Exception as e:
    st.error(f"Failed to connect to the database: {e}")