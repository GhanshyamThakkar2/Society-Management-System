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
    public partial class Department_Master : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;

            if (!IsPostBack)
            {
                dep_date.Text = DateTime.Now.ToString("yyyy-MM-dd");
                BindGridView();
            }
        }

        protected void btn_Save_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString;
                conn.Open();

                string query;
                SqlCommand cmd = new SqlCommand();

                // Check if we're in insert or update mode based on the hidden field dep_id
                if (string.IsNullOrEmpty(dep_id.Value))
                {
                    // Insert new record
                    query = "INSERT INTO Department_Master (Department_Name, City, Address, Pincode, No_Of_Houses, Image, Entry_Date) " +
                            "VALUES (@Department_Name, @City, @Address, @Pincode, @No_Of_Houses, @Image, @Entry_Date)";
                }
                else
                {
                    // Update existing record
                    query = "UPDATE Department_Master SET Department_Name = @Department_Name, City = @City, Address = @Address, " +
                            "Pincode = @Pincode, No_Of_Houses = @No_Of_Houses, Image = @Image, Entry_Date = @Entry_Date " +
                            "WHERE D_ID = @D_ID";
                    cmd.Parameters.AddWithValue("@D_ID", dep_id.Value);
                }

                cmd.Connection = conn;
                cmd.CommandText = query;

                cmd.Parameters.AddWithValue("@Department_Name", dep_name.Text);
                cmd.Parameters.AddWithValue("@City", dep_city.Text);
                cmd.Parameters.AddWithValue("@Address", dep_add.Text);
                cmd.Parameters.AddWithValue("@Pincode", dep_pin_code.Text);
                cmd.Parameters.AddWithValue("@No_Of_Houses", dep_no_houses.Text);

                // For the image
                if (dep_img.HasFile)
                {
                    string fileName = Path.GetFileName(dep_img.PostedFile.FileName);
                    string filePath = Server.MapPath("Images/Department_Image/") + fileName;
                    dep_img.SaveAs(filePath);
                    cmd.Parameters.AddWithValue("@Image", fileName);
                }
                else if (string.IsNullOrEmpty(dep_id.Value))
                {
                    cmd.Parameters.AddWithValue("@Image", DBNull.Value); // For insert with no image
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Image", lbl_img.Text); // For update with existing image
                }

                // Assuming the dep_date field is populated with the current date when the form is loaded
                cmd.Parameters.AddWithValue("@Entry_Date", dep_date.Text);
                cmd.ExecuteNonQuery();
            }

            ClearAll();
            BindGridView();
        }

        public void btnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvRow = (GridViewRow)((Control)sender).NamingContainer;
                int index = gvRow.RowIndex;
                dep_id.Value = Department_Gridview.DataKeys[index].Values["D_ID"].ToString();
                dep_name.Text = Department_Gridview.Rows[index].Cells[1].Text;
                dep_city.Text = Department_Gridview.Rows[index].Cells[2].Text;
                dep_add.Text = Department_Gridview.Rows[index].Cells[3].Text;
                dep_pin_code.Text = Department_Gridview.Rows[index].Cells[4].Text;
                dep_no_houses.Text = Department_Gridview.Rows[index].Cells[5].Text;
                lbl_img.Text = Department_Gridview.DataKeys[index].Values["Image"].ToString();
                //dep_date.Text = Department_Gridview.Rows[index].Cells[8].Text;
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

        protected void Department_Gridview_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "delete1")
            {
                DAO d = new DAO();
                DataSet ds = new DataSet();
                DataSet ds1 = new DataSet();

                ds = d.LoadData("select * from Flat_Master where D_ID=" + e.CommandArgument.ToString());
                ds1 = d.LoadData("select * from Department_Type_Master where D_ID=" + e.CommandArgument.ToString());

                if (ds.Tables[0].Rows.Count != 0)
                {
                    // Display a message box
                    string script = "alert('There are Flats in this Department. First Delete Them!!');";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                }
                else
                {
                    if (ds1.Tables[0].Rows.Count != 0)
                    {
                        // Display a message box
                        string script = "alert('There are Department Images in this Department. First Delete Them!!');";
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                    }
                    else
                    {
                        try
                        {
                            // Get the GridViewRow that contains the button clicked by the user
                            //GridViewRow gvRow = (GridViewRow)((Control)sender).NamingContainer;
                            //int index = gvRow.RowIndex;
                            int id = Convert.ToInt32(e.CommandArgument);
                            // Get the ID of the record to delete
                            //string departmentId = Department_Gridview.DataKeys[index].Values["D_ID"].ToString();

                            // Delete the record from the database
                            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
                            {
                                string deleteQuery = "DELETE FROM Department_Master WHERE D_ID = @D_ID";
                                SqlCommand cmd = new SqlCommand(deleteQuery, conn);
                                cmd.Parameters.AddWithValue("@D_ID", id);

                                conn.Open();
                                cmd.ExecuteNonQuery();
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
            }
            else if (e.CommandName == "add_flat")
            {
                Session["flat"] = e.CommandArgument.ToString();
                Response.Redirect("Flat_Master.aspx");
            }
            else if (e.CommandName == "Add_Department_Image")
            {
                Session["Department"] = e.CommandArgument.ToString();
                Response.Redirect("Depatment_Type_Image.aspx");
            }
        }

        private void BindGridView()
        {
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString;

            string query = "SELECT * FROM Department_Master";
            SqlCommand cmd = new SqlCommand(query, conn);
            conn.Open();

            SqlDataReader reader = cmd.ExecuteReader();
            Department_Gridview.DataSource = reader;
            Department_Gridview.DataBind();

            conn.Close();
        }

        private void Department_Gridview_PreRender(object sender, EventArgs e)
        {
            try
            {
                Department_Gridview.UseAccessibleHeader = true;
                Department_Gridview.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
            catch (Exception ex)
            {
                
            }
        }
        private void Department_Gridview_RowDataBound(object sender, GridViewRowEventArgs e)
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
            dep_id.Value = "";
            dep_name.Text = "";
            dep_city.Text = "";
            dep_add.Text = "";
            dep_pin_code.Text = "";
            dep_no_houses.Text = "";
            dep_img.Dispose();
            lbl_img.Text = "";
        }
    }
}