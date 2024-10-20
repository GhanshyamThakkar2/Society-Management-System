using System;
using System.Data;
using System.Data.SqlClient;

namespace Society_Management_System.admin
{
    public class DAO
    {
        private SqlConnection con;

        public DAO()
        {
            con = new SqlConnection("Data Source=HP-LAPTOP\\sqlexpress;Initial Catalog=Housing_Management;Integrated Security=True");
            try
            {
                con.Open();
                con.Close();
            }
            catch (Exception ex)
            {
                // Handle exception if necessary
            }
        }

        public SqlDataReader GetData(string str)
        {
            SqlDataReader obj;
            SqlCommand cmd = new SqlCommand(str, con);
            con.Open();
            obj = cmd.ExecuteReader();
            return obj;
        }

        public void CloseConn()
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }

        public DataSet LoadData(string str)
        {
            DataSet ds = new DataSet();
            SqlDataAdapter da = new SqlDataAdapter(str, con);
            da.Fill(ds); // SqlDataAdapter handles connection automatically
            return ds;
        }

        public int Validate(string str)
        {
            int f = 0;
            SqlDataReader obj = GetData(str);
            while (obj.Read())
            {
                f = 1;
            }
            con.Close();
            return f;
        }

        public void ModifyData(string str)
        {
            SqlCommand cmd = new SqlCommand(str, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
    }
}
