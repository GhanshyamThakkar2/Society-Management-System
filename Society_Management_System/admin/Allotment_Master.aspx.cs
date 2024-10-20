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
    public partial class Allotment_Master : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                // Retrieve the department ID from the session
                if (Session["Allotment"] != null)
                {
                    DAO d = new DAO();
                    DataSet ds = new DataSet();

                    ds = d.LoadData("select * from Flat_Master where F_ID=" + Session["Allotment"]);
                    if (ds.Tables[0].Rows.Count != 0)
                    {
                        uid.Text = ds.Tables[0].Rows[0]["Flat_No"].ToString();
                    }
                    //string departmentId = Session["Allotment"].ToString();
                    e_date.Text = DateTime.Now.ToString("yyyy-MM-dd");
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
                    if (string.IsNullOrEmpty(A_ID.Value))
                    {
                        // Insert new record
                        query = "INSERT INTO Allotment_Master (F_Name, L_Name, Email, Mobile_No, Birth_Date, Total_Member, F_ID, User_ID, Password, Image, Entry_Date) " +
                                "VALUES (@F_Name, @L_Name, @Email, @Mobile_No, @Birth_Date, @Total_Member, @F_ID, @User_ID, @Password, @Image, @Entry_Date)";
                    }
                    else
                    {
                        // Update existing record
                        query = "UPDATE Allotment_Master SET F_Name = @F_Name, L_Name = @L_Name, Email = @Email, Mobile_No = @Mobile_No, Birth_Date = @Birth_Date, " +
                                "Total_Member = @Total_Member, F_ID = @F_ID, User_ID = @User_ID, Password = @Password, Image = @Image, Entry_Date = @Entry_Date WHERE A_ID = @A_ID";
                        cmd.Parameters.AddWithValue("@A_ID", A_ID.Value);
                    }

                    cmd.Connection = conn;
                    cmd.CommandText = query;

                    // Add parameters
                    cmd.Parameters.AddWithValue("@F_Name", F_name.Text);
                    cmd.Parameters.AddWithValue("@L_Name", L_name.Text);
                    cmd.Parameters.AddWithValue("@Email", email.Text);
                    cmd.Parameters.AddWithValue("@Mobile_No", Mobile_num.Text);
                    cmd.Parameters.AddWithValue("@Birth_Date", dob.Text);
                    cmd.Parameters.AddWithValue("@Total_Member", tot_mem.Text);
                    cmd.Parameters.AddWithValue("@F_ID", Session["Allotment"]);
                    cmd.Parameters.AddWithValue("@User_ID", uid.Text);
                    cmd.Parameters.AddWithValue("@Password", pass.Text);
                    //cmd.Parameters.AddWithValue("@Image", lbl_img.Text);
                    cmd.Parameters.AddWithValue("@Entry_Date", e_date.Text);

                    if (img_user.HasFile)
                    {
                        // Generate a unique filename to avoid conflicts
                        string fileName = Path.GetFileName(img_user.PostedFile.FileName);
                        string filePath = Server.MapPath("Images/Allotment_user_photo/") + fileName;
                        img_user.SaveAs(filePath);
                        cmd.Parameters.AddWithValue("@Image", fileName);  // Store the image filename in the database
                    }
                    else if (string.IsNullOrEmpty(A_ID.Value))
                    {
                        // For insert with no image
                        cmd.Parameters.AddWithValue("@Image", DBNull.Value);
                    }
                    else
                    {
                        // For update with the existing image
                        cmd.Parameters.AddWithValue("@Image", lbl_img.Text);
                    }


                    cmd.ExecuteNonQuery();
                }

                BindGridView();
                clearall();
            }
            catch (Exception ex)
            {
                string errorMessage = ex.Message.Replace("'", "\\'"); // Escape single quotes
                string script = $"alert('An error occurred: {errorMessage}');";
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
            }
        }

        public void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvRow = (GridViewRow)((Control)sender).NamingContainer;
                int index = gvRow.RowIndex;

                // Retrieve values from the GridView and assign them to the controls
                A_ID.Value = Allotment_Gridview.DataKeys[index].Values["A_ID"].ToString();
                F_name.Text = Allotment_Gridview.Rows[index].Cells[1].Text;
                L_name.Text = Allotment_Gridview.Rows[index].Cells[2].Text;
                email.Text = Allotment_Gridview.Rows[index].Cells[3].Text;
                Mobile_num.Text = Allotment_Gridview.Rows[index].Cells[4].Text;
                dob.Text = Convert.ToDateTime(Allotment_Gridview.Rows[index].Cells[5].Text).ToString("yyyy-MM-dd");
                tot_mem.Text = Allotment_Gridview.Rows[index].Cells[6].Text;
                //uid.Text = Allotment_Gridview.Rows[index].Cells[7].Text;
                pass.Text = Allotment_Gridview.Rows[index].Cells[9].Text;
                //e_date.Text = Convert.ToDateTime(Allotment_Gridview.Rows[index].Cells[9].Text).ToString("yyyy-MM-dd");

                // Set a flag for edit mode
                Session["Flag"] = 1;

                // Set focus to the flat number text box
                F_name.Focus();
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
                string query = "SELECT * FROM Allotment_Master WHERE F_ID = @F_ID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@F_ID", Session["Allotment"]);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                Allotment_Gridview.DataSource = reader;
                Allotment_Gridview.DataBind();

                conn.Close();
            }
        }
        protected void Allotment_Gridview_RowCommand(object sender, GridViewCommandEventArgs e)
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
                            string query = "DELETE FROM Allotment_Master WHERE A_ID = @A_ID";
                            SqlCommand cmd = new SqlCommand(query, conn);
                            cmd.Parameters.AddWithValue("@A_ID", A_ID);

                            conn.Open();
                            cmd.ExecuteNonQuery();
                            conn.Close();
                        }

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
            else if (e.CommandName == "Add_Image")
            {
                Session["Image"] = e.CommandArgument.ToString();
                Response.Redirect("Allotment_Image_Master.aspx");
            }
        }
        private void Allotment_Gridview_PreRender(object sender, EventArgs e)
        {
            try
            {
                Allotment_Gridview.UseAccessibleHeader = true;
                Allotment_Gridview.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
            catch (Exception ex)
            {

            }
        }
        private void Allotment_Gridview_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.TableSection = TableRowSection.TableHeader;
            }
        }
        private void clearall()
        {
            A_ID.Value = "";
            F_name.Text = "";
            L_name.Text = "";
            email.Text = "";
            Mobile_num.Text = "";
            dob.Text = "";
            tot_mem.Text = "";
            pass.Text = "";
            img_user.Dispose();
        }
        protected void btn_Clear_Click(object sender, EventArgs e)
        {
            clearall();
        }
    }
}