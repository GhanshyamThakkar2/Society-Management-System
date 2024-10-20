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
    public partial class Circular_Master : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;
            if (!Page.IsPostBack)
            {
                Session.Add("Flag", 0);
                BindGridView();
                c_date.Text = DateTime.Now.ToString("yyyy-MM-dd");
                //c_cir_date.Text = DateTime.Now.ToString("yyyy-MM-dd");
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
                    string fname = lbl_img.Text;  // The circular file name
                    SqlCommand cmd = new SqlCommand();

                    if (Convert.ToInt32(Session["Flag"]) == 0)
                    {
                        // INSERT OPERATION
                        query = "INSERT INTO Circular_Master (Cir_Date, Cir_From, Cir_Subject, Circular, Entry_Date) VALUES (@Cir_Date, @Cir_From, @Cir_Subject, @Circular, @Entry_Date)";
                    }
                    else
                    {
                        // Check if the file needs to be deleted
                        if (circular.HasFile && File.Exists(Server.MapPath("Images/Circular/") + lbl_img.Text))
                        {
                            File.Delete(Server.MapPath("Images/Circular/") + lbl_img.Text);
                        }

                        // UPDATE OPERATION
                        query = "UPDATE Circular_Master SET Cir_Date = @Cir_Date, Cir_From = @Cir_From, Cir_Subject = @Cir_Subject, Circular = @Circular, Entry_Date = @Entry_Date WHERE Cir_ID = @Cir_ID";
                        cmd.Parameters.AddWithValue("@Cir_ID", c_id.Value);
                    }
                    // Circular file handling
                    if (circular.HasFile)
                    {
                        fname = circular.FileName;
                        if (fname.EndsWith("jpg") || fname.EndsWith("png") || fname.EndsWith("jpeg") || fname.EndsWith("pdf"))
                        {
                            string filePath = Server.MapPath("Images/Circular/") + fname;
                            circular.SaveAs(filePath);
                        }
                    }

                    cmd.Connection = con;
                    cmd.CommandText = query;

                    cmd.Parameters.AddWithValue("@Cir_Date", c_cir_date.Text);
                    cmd.Parameters.AddWithValue("@Cir_From", c_from.Text);
                    cmd.Parameters.AddWithValue("@Cir_Subject", c_sub.Text);
                    cmd.Parameters.AddWithValue("@Entry_Date", c_date.Text);
                    cmd.Parameters.AddWithValue("@Circular", fname);

                   

                    // Execute the query (either INSERT or UPDATE)
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
        protected void BindGridView()
        {
            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
            {
                string query = "SELECT * FROM Circular_Master";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                Circular_Gridview.DataSource = reader;
                Circular_Gridview.DataBind();

                conn.Close();
            }
        }
        public void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvRow = ((Control)sender).NamingContainer as GridViewRow;
                int index = gvRow.RowIndex;

                c_id.Value = Circular_Gridview.DataKeys[index].Values["Cir_ID"].ToString();
                c_cir_date.Text = Circular_Gridview.Rows[index].Cells[1].Text;
                c_from.Text = Circular_Gridview.Rows[index].Cells[2].Text;
                c_sub.Text = Circular_Gridview.Rows[index].Cells[3].Text;
                lbl_img.Text = Circular_Gridview.DataKeys[index].Values["Circular"].ToString();
                //c_date.Text = Circular_Gridview.Rows[index].Cells[6].Text;
                Session["Flag"] = 1;
                c_cir_date.Focus();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
        protected void Circular_Gridview_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "delete1")
            {
                string deleteQuery = "DELETE FROM Circular_Master WHERE Cir_ID = @Cir_ID";

                using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(deleteQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@Cir_ID", e.CommandArgument);

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }

                Circular_Gridview.DataBind();
            }
        }
        protected void Circular_Gridview_PreRender(object sender, EventArgs e)
        {
            try
            {
                Circular_Gridview.UseAccessibleHeader = true;
                Circular_Gridview.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
            catch (Exception ex)
            {
                // Handle exception if needed
            }
        }
        protected void clearall()
        {
            c_id.Value = "";
            c_from.Text = "";
            c_sub.Text = "";
            c_cir_date.Text = "";
            lbl_img.Text = "";
            circular.Dispose();
        }
        protected void btn_Clear_Click(object sender, EventArgs e)
        {
            clearall();
        }
    }
}