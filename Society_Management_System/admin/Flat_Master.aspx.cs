using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Society_Management_System.admin
{
    public partial class Flat_Master : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                // Retrieve the department ID from the session
                if (Session["flat"] != null)
                {
                    string departmentId = Session["flat"].ToString();
                    E_Date.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    PopulateDepartmentDetails(departmentId);
                    BindGridView();
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
                    SqlCommand cmd = new SqlCommand();

                    // Check if we're in insert or update mode based on the hidden field id
                    if (string.IsNullOrEmpty(flat_ID.Value))
                    {
                        // Insert new record
                        query = "INSERT INTO Flat_Master (D_ID, Flat_No, House_Type, Area, Entry_Date) " +
                                "VALUES (@D_ID, @Flat_No, @House_Type, @Area, @Entry_Date)";
                    }
                    else
                    {
                        // Update existing record
                        query = "UPDATE Flat_Master SET D_ID = @D_ID, Flat_No = @Flat_No, House_Type = @House_Type, Area = @Area, Entry_Date = @Entry_Date " +
                                "WHERE F_ID = @F_ID";
                        cmd.Parameters.AddWithValue("@F_ID", flat_ID.Value);
                    }

                    cmd.Connection = conn;
                    cmd.CommandText = query;

                    cmd.Parameters.AddWithValue("@D_ID", Session["flat"]);
                    cmd.Parameters.AddWithValue("@Flat_No", flat_No.Text);
                    cmd.Parameters.AddWithValue("@House_Type", h_type.Text);
                    cmd.Parameters.AddWithValue("@Area", f_area.Text);
                    cmd.Parameters.AddWithValue("@Entry_Date", E_Date.Text);

                    cmd.ExecuteNonQuery();
                }

                BindGridView();
                ClearAll();
            }
            catch (Exception ex)
            {
                // Handle exceptions here
                string errorMessage = ex.Message.Replace("'", "\\'"); // Escape single quotes
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
                flat_ID.Value = Flat_Master_Gridview.DataKeys[index].Values["F_ID"].ToString();
                flat_No.Text = Flat_Master_Gridview.Rows[index].Cells[2].Text;
                string departmentId = Flat_Master_Gridview.Rows[index].Cells[3].Text;

                // Set the Department dropdown to the corresponding value
                if (h_type.Items.FindByValue(departmentId) != null)
                {
                    h_type.SelectedValue = departmentId;
                }
                f_area.Text = Flat_Master_Gridview.Rows[index].Cells[4].Text;

                // Set a flag for edit mode
                Session["Flag"] = 1;

                // Set focus to the flat number text box
                flat_No.Focus();
            }
            catch (Exception ex)
            {
                string errorMessage = ex.Message.Replace("'", "\\'"); // Escape single quotes
                string script = $"alert('An error occurred: {errorMessage}');";
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
            }
        }

        private void BindGridView()
        {
            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
            {
                string query = "SELECT * FROM Flat_Master WHERE D_ID = @D_ID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@D_ID", Session["flat"]);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                Flat_Master_Gridview.DataSource = reader;
                Flat_Master_Gridview.DataBind();

                conn.Close();
            }
        }
        protected void Flat_Master_Gridview_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "delete1")
            {
                DAO d = new DAO();
                DataSet ds = new DataSet();

                ds = d.LoadData("select * from Allotment_Master where F_ID=" + e.CommandArgument);

                if (ds.Tables[0].Rows.Count != 0)
                {
                    // Display a message box
                    string script = "alert('These Flat in Already Alloted. First Remove Allotment!!');";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                }
                else
                {
                    int flatId = Convert.ToInt32(e.CommandArgument);
                    try
                    {
                        using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
                        {
                            string query = "DELETE FROM Flat_Master WHERE F_ID = @F_ID";
                            SqlCommand cmd = new SqlCommand(query, conn);
                            cmd.Parameters.AddWithValue("@F_ID", flatId);

                            conn.Open();
                            cmd.ExecuteNonQuery();
                            conn.Close();
                        }

                        BindGridView(); // Refresh the GridView after deletion
                    }
                    catch (Exception ex)
                    {
                        string errorMessage = ex.Message.Replace("'", "\\'"); // Escape single quotes
                        string script = $"alert('An error occurred: {errorMessage}');";
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
                    }
                }
            }
            else if(e.CommandName == "Add_Allotment")
            {
                Session["Allotment"] = e.CommandArgument.ToString();
                Response.Redirect("Allotment_Master.aspx");
            }
        }
        private void PopulateDepartmentDetails(string departmentId)
        {
            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
            {

                DAO d = new DAO();
                DataSet ds = d.LoadData("SELECT * FROM Department_Master WHERE D_ID = " + departmentId);

                if (ds.Tables[0].Rows.Count != 0)
                {
                    dep_name.Text = ds.Tables[0].Rows[0]["Department_Name"].ToString();
                }
            }
        }
        private void LoadHouseTypes(string departmentId)
        {
            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
            {
                string query = "SELECT H_ID, House_Type FROM House_Type_Master WHERE D_ID = @D_ID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@D_ID", departmentId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                h_type.DataSource = reader;
                h_type.DataTextField = "House_Type"; // The name of the house type
                h_type.DataValueField = "H_ID"; // The ID of the house type
                h_type.DataBind();

                // Optionally, add a default "Select" item at the top
                h_type.Items.Insert(0, new ListItem("Select a House Type", ""));
            }
        }
        private void Flat_Master_Gridview_PreRender(object sender, EventArgs e)
        {
            try
            {
                Flat_Master_Gridview.UseAccessibleHeader = true;
                Flat_Master_Gridview.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
            catch (Exception ex)
            {

            }
        }
        private void Flat_Master_Gridview_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
            }
        }
        private void ClearAll()
        {
            flat_ID.Value = ""; // Reset hidden field
            flat_No.Text = ""; // Reset flat number text box
            f_area.Text = ""; // Reset area text box
            //E_Date.Text = ""; // Reset entry date text box
        }

        protected void btn_Clear_Click(object sender, EventArgs e)
        {
            ClearAll();
        }
    }
}