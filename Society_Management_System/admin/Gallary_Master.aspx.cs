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
    public partial class Gallary_Master : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                BindGridView();
            }
        }
        protected void btn_Save_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand();
                    string query;

                    // Handle image file name
                    string fileName = lbl_img.Text; // Keep existing file name if no new file is uploaded

                    // Check if we are inserting or updating
                    if (string.IsNullOrEmpty(id.Value))
                    {
                        // INSERT operation
                        query = "INSERT INTO Gallery_Master (Image, Description) VALUES (@Image, @Description)";
                    }
                    else
                    {
                        // UPDATE operation
                        query = "UPDATE Gallery_Master SET Image = @Image, Description = @Description WHERE ID = @ID";
                        cmd.Parameters.AddWithValue("@ID", id.Value);
                    }

                    // Check if a new file is uploaded
                    if (img.HasFile)
                    {
                        // Delete existing image file if it exists
                        if (System.IO.File.Exists(Server.MapPath("~/images/Gallery_Master/") + fileName))
                        {
                            System.IO.File.Delete(Server.MapPath("~/images/Gallery_Master/") + fileName);
                        }

                        // Set new file name and save it
                        fileName = Path.GetFileName(img.PostedFile.FileName);
                        if (fileName.EndsWith("jpg", StringComparison.OrdinalIgnoreCase) ||
                            fileName.EndsWith("png", StringComparison.OrdinalIgnoreCase) ||
                            fileName.EndsWith("jpeg", StringComparison.OrdinalIgnoreCase))
                        {
                            img.SaveAs(Server.MapPath("~/images/Gallery_Master/") + fileName);
                        }
                    }

                    cmd.Connection = con;
                    cmd.CommandText = query;

                    // Add parameters
                    cmd.Parameters.AddWithValue("@Image", fileName);
                    cmd.Parameters.AddWithValue("@Description", des.Text);

                    cmd.ExecuteNonQuery();
                }

                // Clear the form and rebind the GridView
                clearAll();
                BindGridView();

                // Show success message
                string script = "success();";
                ClientScript.RegisterStartupScript(this.GetType(), "success", script, true);
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.Message);
            }
        }

        public void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvRow = (GridViewRow)((Control)sender).NamingContainer;
                int index = gvRow.RowIndex;

                id.Value = Gallery_Gridview.DataKeys[index].Values["ID"].ToString();
                des.Text = Gallery_Gridview.Rows[index].Cells[3].Text;
                lbl_img.Text = Gallery_Gridview.DataKeys[index].Values["Image"].ToString();

                // Set a flag for edit mode
                Session["Flag"] = 1;

                // Set focus to the flat number text box
                des.Focus();
            }
            catch (Exception ex)
            {
                string errorMessage = ex.Message.Replace("'", "\\'"); // Escape single quotes
                string script = $"alert('An error occurred: {errorMessage}');";
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
            }
        }
        protected void Gallery_Gridview_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
           if (e.CommandName == "delete1")
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
                    {
                        con.Open();
                        SqlCommand cmd = new SqlCommand("DELETE FROM Gallery_Master WHERE ID = @ID", con);
                        cmd.Parameters.AddWithValue("@ID", id);
                        cmd.ExecuteNonQuery();
                    }

                    // Rebind GridView
                    BindGridView();
                }
                catch (Exception ex)
                {
                    Response.Write("Error: " + ex.Message);
                }
            }
        }
        protected void BindGridView()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
                {
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Gallery_Master", con);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    Gallery_Gridview.DataSource = dt;
                    Gallery_Gridview.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.Message);
            }
        }
        private void clearAll()
        {
            id.Value = "";
            img.Dispose();
            des.Text = "";
        }
        protected void btn_Clear_Click(object sender, EventArgs e)
        {
            clearAll();
        }
    }
}