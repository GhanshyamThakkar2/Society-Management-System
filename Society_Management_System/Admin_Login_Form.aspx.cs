using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Society_Management_System
{
    public partial class Admin_Login_Form : System.Web.UI.Page
    {
        protected void Button1_Click(object sender, EventArgs e)
        {
            string connectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString;
            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    con.Open();

                    // Sample query to validate user login
                    string query = "SELECT * FROM Login_Master WHERE user_name = @user_name AND password = @password AND type = @type";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@user_name", username.Text);
                        cmd.Parameters.AddWithValue("@password", password.Text);
                        cmd.Parameters.AddWithValue("@type", "admin");  // or whatever the role/type is

                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.HasRows)
                        {
                            Session["adminname"] = username.Text;
                            Response.Redirect("admin/Admin_Dashboard.aspx");
                        }
                        else
                        {
                            // Show a message about invalid login
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", "swal('Error', 'Username and Password Did Not Match!', 'error');", true);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Catch and display the error
                Response.Write("Error: " + ex.Message);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["admin"] = "admin";
        }
    }
}