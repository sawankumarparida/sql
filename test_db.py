import mysql.connector

try:
    # Establish connection using localhost and the root credentials you set up
    connection = mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="Snmr@7875",  # Replace with your actual password
        database="one_db"        # The DB we created earlier
    )
    
    if connection.is_connected():
        print("🚀 Success! Your project is actively connected to the WSL MySQL database.")
        
        # Run a quick query to prove it works
        cursor = connection.cursor()
        cursor.execute("SELECT VERSION();")
        db_version = cursor.fetchone()
        print(f"Database Engine Version: {db_version[0]}")

except Exception as error:
    print(f"❌ Connection failed: {error}")

finally:
    if 'connection' in locals() and connection.is_connected():
        cursor.close()
        connection.close()