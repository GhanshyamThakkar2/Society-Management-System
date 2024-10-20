using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Society_Management_System.admin
{
    public partial class Depatment_Type_Image : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                // Retrieve the department ID from the session
                if (Session["Department"] != null)
                {
                    string departmentId = Session["Department"].ToString();
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
                    if (string.IsNullOrEmpty(id.Value))
                    {
                        // Insert new record
                        query = "INSERT INTO Department_Type_Master (D_ID, Image, Description) " +
                                "VALUES (@D_ID, @Image, @Description)";
                    }
                    else
                    {
                        // Update existing record
                        query = "UPDATE Department_Type_Master SET D_ID = @D_ID, Image = @Image, Description = @Description " +
                                "WHERE ID = @ID";
                        cmd.Parameters.AddWithValue("@ID", id.Value);
                    }

                    cmd.Connection = conn;
                    cmd.CommandText = query;

                    cmd.Parameters.AddWithValue("@D_ID", Session["Department"]);
                    cmd.Parameters.AddWithValue("@Description", des.Text);

                    // Handle image upload
                    if (img.HasFile)
                    {
                        string fileName = Path.GetFileName(img.PostedFile.FileName);
                        string filePath = Server.MapPath("Images/Department_Type_Image_Master/") + fileName;
                        img.SaveAs(filePath);
                        cmd.Parameters.AddWithValue("@Image", fileName);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@Image", lbl_img.Text); // For update with existing image
                    }
                    cmd.ExecuteNonQuery();
                }

                ClearAll();
                BindGridView();
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
                id.Value = Department_Image_Gridview.DataKeys[index].Values["ID"].ToString();
                lbl_img.Text = Department_Image_Gridview.DataKeys[index].Values["Image"].ToString();
                des.Text = Department_Image_Gridview.Rows[index].Cells[4].Text;
                Session["Flag"] = 1;
                dep_name.Focus();
            }
            catch (Exception ex)
            {
                string errorMessage = ex.Message.Replace("'", "\\'"); // Escape single quotes
                string script = $"alert('An error occurred: {errorMessage}');";
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
            }
        }
        protected void Department_Image_Gridview_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "delete1")
            {
                try
                {
                    int id = Convert.ToInt32(e.CommandArgument);

                    using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
                    {
                        string query = "DELETE FROM Department_Type_Master WHERE ID = @ID";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@ID", id);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
                    ClearAll();
                    // Rebind the GridView to reflect changes
                    BindGridView();
                }
                catch (Exception ex)
                {
                    string errorMessage = ex.Message.Replace("'", "\\'"); // Escape single quotes
                    string script = $"alert('An error occurred: {errorMessage}');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
                }
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


        private void BindGridView()
        {
            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
            {
                string query = "SELECT ID, D_ID, Image, Description FROM Department_Type_Master WHERE D_ID = @D_ID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@D_ID", Session["Department"]);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                Department_Image_Gridview.DataSource = reader;
                Department_Image_Gridview.DataBind();
            }
        }


        private void Department_Image_Gridview_PreRender(object sender, EventArgs e)
        {
            try
            {
                Department_Image_Gridview.UseAccessibleHeader = true;
                Department_Image_Gridview.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
            catch (Exception ex)
            {

            }
        }
        private void Department_Image_Gridview_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
            }
        }
        protected void btn_Clear_Click(object sender, EventArgs e)
        {
            ClearAll();
        }

        private void ClearAll()
        {
            id.Value = ""; // Reset hidden field
            des.Text = ""; // Reset description text box
            img.Dispose(); // Clear file upload control
            lbl_img.Text = ""; // Reset image label
        }
    }
}