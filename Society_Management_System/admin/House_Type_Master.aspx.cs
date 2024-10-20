using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Society_Management_System.admin
{
    public partial class House_Type_Master : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                // Retrieve the department ID from the session
                LoadDepartments();
                BindGridView();
            }
        }
        private void LoadDepartments()
        {
            // Define the connection string (you can also retrieve it from web.config)
            string connectionString = WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString;

            // Define the query
            string query = "SELECT D_ID, Department_Name FROM Department_Master";

            // Use a SqlConnection and SqlCommand to query the database
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    try
                    {
                        conn.Open();

                        // Execute the command and bind the data to the DropDownList
                        SqlDataReader reader = cmd.ExecuteReader();

                        dep_Name.DataSource = reader;
                        dep_Name.DataTextField = "Department_Name"; // The field to display in the dropdown
                        dep_Name.DataValueField = "D_ID"; // The value to store for each item
                        dep_Name.DataBind();

                        // Optionally, add a default "Select" item at the top
                        dep_Name.Items.Insert(0, new ListItem("Select a Department", ""));
                    }
                    catch (Exception ex)
                    {
                        // Handle the error
                        string errorMessage = ex.Message.Replace("'", "\\'"); // Escape single quotes
                        string script = $"alert('An error occurred: {errorMessage}');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
                    }
                }
            }
        }
        private void BindGridView()
        {
            string connectionString = WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString;
            string query = "SELECT H_ID, D_ID, House_Type FROM House_Type_Master";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    try
                    {
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        House_Type_Gridview.DataSource = reader;
                        House_Type_Gridview.DataBind();
                    }
                    catch (Exception ex)
                    {
                        string errorMessage = ex.Message.Replace("'", "\\'");
                        string script = $"alert('An error occurred: {errorMessage}');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
                    }
                }
            }
        }
        protected void btn_Save_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
                {
                    conn.Open();
                    string query;

                    if (string.IsNullOrEmpty(hid.Value))
                    {
                        query = "INSERT INTO House_Type_Master (D_ID, House_Type) VALUES (@D_ID, @House_Type)";
                    }
                    else
                    {
                        query = "UPDATE House_Type_Master SET D_ID = @D_ID, House_Type = @House_Type WHERE H_ID = @H_ID";
                    }

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@D_ID", dep_Name.SelectedValue);
                        cmd.Parameters.AddWithValue("@House_Type", house_Type.Text);

                        if (!string.IsNullOrEmpty(hid.Value))
                        {
                            cmd.Parameters.AddWithValue("@H_ID", hid.Value);
                        }

                        cmd.ExecuteNonQuery();
                    }

                    ClearAll();
                    BindGridView();
                }
            }
            catch (Exception ex)
            {
                string errorMessage = ex.Message.Replace("'", "\\'");
                string script = $"alert('An error occurred: {errorMessage}');";
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
            }
        }
        public void btnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvRow = (GridViewRow)((Control)sender).NamingContainer;
                int index = gvRow.RowIndex;

                // Retrieve values from the GridView and assign them to the controls
                hid.Value = House_Type_Gridview.DataKeys[index].Values["H_ID"].ToString();
                string departmentId = House_Type_Gridview.DataKeys[index].Values["D_ID"].ToString();

                // Set the Department dropdown to the corresponding value
                if (dep_Name.Items.FindByValue(departmentId) != null)
                {
                    dep_Name.SelectedValue = departmentId;
                }
                house_Type.Text = House_Type_Gridview.Rows[index].Cells[2].Text;

                // Set a flag for edit mode
                Session["Flag"] = 1;

                // Set focus to the house type text box
                house_Type.Focus();
            }
            catch (Exception ex)
            {
                string errorMessage = ex.Message.Replace("'", "\\'"); // Escape single quotes
                string script = $"alert('An error occurred: {errorMessage}');";
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
            }
        }

        protected void HouseTypeGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "delete1")
            {
                try
                {
                    int id = Convert.ToInt32(e.CommandArgument);

                    using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
                    {
                        string query = "DELETE FROM House_Type_Master WHERE H_ID = @H_ID";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@H_ID", id);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                    ClearAll();
                    BindGridView();
                }
                catch (Exception ex)
                {
                    string errorMessage = ex.Message.Replace("'", "\\'");
                    string script = $"alert('An error occurred: {errorMessage}');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
                }
            }
        }
        private void ClearAll()
        {
            hid.Value = "";
            house_Type.Text = "";
            dep_Name.SelectedIndex = 0;
        }
        protected void dep_Name_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Handle the selected index change event if needed
            string selectedDepartmentId = dep_Name.SelectedValue;
            // Perform actions based on the selected value
        }

        protected void btn_Clear_Click(object sender, EventArgs e)
        {
            ClearAll();
        }
    }
}