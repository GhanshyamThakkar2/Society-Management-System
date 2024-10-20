using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.IO;
using System.Data;

namespace Society_Management_System.admin
{
    public partial class Allotment_Image_Master : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;
            if (!Page.IsPostBack)
            {
                Session.Add("Flag", 0);
                if (Session["Image"] != null && Session["Image"].ToString() != "")
                {
                    DAO d = new DAO();
                    DataSet ds = d.LoadData("SELECT * FROM Allotment_Master WHERE A_ID=" + Session["Image"].ToString());
                    if (ds.Tables[0].Rows.Count != 0)
                    {
                        aid.Value = ds.Tables[0].Rows[0]["A_ID"].ToString();
                    }
                    BindGridView();
                }
            }
        }
        protected void btn_Save_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
                {
                    con.Open();
                    string query;
                    string fname = lbl_img.Text;  // The image name
                    SqlCommand cmd = new SqlCommand();

                    if (Convert.ToInt32(Session["Flag"]) == 0)
                    {
                        // INSERT OPERATION
                        query = "INSERT INTO Image_Master (A_ID, Name, Image) VALUES (@A_ID, @Name, @Image)";
                    }
                    else
                    {
                        // Check if the file needs to be deleted
                        if (img.HasFile && File.Exists(Server.MapPath("Images/User_Documents_Image_Image_Master/") + lbl_img.Text))
                        {
                            File.Delete(Server.MapPath("Images/User_Documents_Image_Image_Master/") + lbl_img.Text);
                        }

                        // UPDATE OPERATION
                        query = "UPDATE Allotment_Image_Master SET A_ID = @A_ID, Name = @Name, Image = @Image WHERE I_ID = @I_ID";
                        cmd.Parameters.AddWithValue("@I_ID", img_id.Value);
                    }

                    cmd.Connection = con;
                    cmd.CommandText = query;

                    cmd.Parameters.AddWithValue("@A_ID", aid.Value);
                    cmd.Parameters.AddWithValue("@Name", name.Text);
                    cmd.Parameters.AddWithValue("@Image", fname);
                    // Image handling
                    if (img.HasFile)
                    {
                        fname = img.FileName;
                        if (fname.EndsWith("jpg") || fname.EndsWith("png") || fname.EndsWith("jpeg") || fname.EndsWith("pdf"))
                        {
                            string filePath = Server.MapPath("Images/User_Documents_Image(Image_Master)/") + fname;
                            img.SaveAs(filePath);
                        }
                    }

                    
                    // Check if we are in insert or update mode based on the session flag
                    
                    // Add common parameters
                    


                    
                    cmd.ExecuteNonQuery();
                }
                
                clearall();
                BindGridView();
                string script = "success();";
                ClientScript.RegisterStartupScript(this.GetType(), "success", script, true);
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
        private void BindGridView()
        {
            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
            {
                string query = "SELECT * FROM Image_Master WHERE A_ID = @A_ID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@A_ID", Session["Image"]);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                Allotment_Image_Gridview.DataSource = reader;
                Allotment_Image_Gridview.DataBind();

                conn.Close();
            }
        }
        public void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvRow = ((Control)sender).NamingContainer as GridViewRow;
                int index = gvRow.RowIndex;

                img_id.Value = Allotment_Image_Gridview.DataKeys[index].Values["I_ID"].ToString();
                aid.Value = Allotment_Image_Gridview.Rows[index].Cells[1].Text;
                name.Text = Allotment_Image_Gridview.Rows[index].Cells[2].Text;
                lbl_img.Text = Allotment_Image_Gridview.DataKeys[index].Values["Image"].ToString();
                Session["Flag"] = 1;
                name.Focus();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }

        protected void Allotment_Image_Gridview_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Add_Image")
            {
                string deleteQuery = "DELETE FROM Image_Master WHERE I_ID = @I_ID";

                using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(deleteQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@I_ID", e.CommandArgument);

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }

                Allotment_Image_Gridview.DataBind();
            }
        }

        private void Allotment_Image_Gridview_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
            }
        }

        

        protected void Allotment_Image_Gridview_PreRender(object sender, EventArgs e)
        {
            try
            {
                Allotment_Image_Gridview.UseAccessibleHeader = true;
                Allotment_Image_Gridview.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
            catch (Exception ex)
            {
                // Handle exception if needed
            }
        }

        private void clearall()
        {
            name.Text = "";
            lbl_img.Text = "";
            img_id.Value = "";
        }

        protected void btn_Clear_Click(object sender, EventArgs e)
        {
            clearall();
        }

    }
}