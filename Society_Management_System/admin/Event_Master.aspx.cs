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
    public partial class Event_Master : System.Web.UI.Page
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
                    string query;
                    SqlCommand cmd = new SqlCommand();

                    // Determine if we are inserting or updating
                    if (string.IsNullOrEmpty(eid.Value))
                    {
                        // INSERT Operation
                        query = "INSERT INTO Event_Master (E_Name, Description) VALUES (@E_Name, @Description)";
                    }
                    else
                    {
                        // UPDATE Operation
                        query = "UPDATE Event_Master SET E_Name = @E_Name, Description = @Description WHERE E_ID = @E_ID";
                        cmd.Parameters.AddWithValue("@E_ID", eid.Value);
                    }

                    cmd.Connection = con;
                    cmd.CommandText = query;

                    // Add parameters
                    cmd.Parameters.AddWithValue("@E_Name", ename.Text);
                    cmd.Parameters.AddWithValue("@Description", des.Text);

                    cmd.ExecuteNonQuery();
                }

                // Clear the form and rebind the GridView
                clearAll();
                BindGridView();
                string script = "success();";
                ClientScript.RegisterStartupScript(this.GetType(), "success", script, true);
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
        public void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvRow = (GridViewRow)((Control)sender).NamingContainer;
                int index = gvRow.RowIndex;

                eid.Value = Event_Gridview.DataKeys[index].Values["E_ID"].ToString(); 
                ename.Text = Event_Gridview.Rows[index].Cells[1].Text; 
                des.Text = Event_Gridview.Rows[index].Cells[2].Text;   

                Session["Flag"] = 1;

                ename.Focus();
            }
            catch (Exception ex)
            {
                string errorMessage = ex.Message.Replace("'", "\\'");
                string script = $"alert('An error occurred: {errorMessage}');";
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", script, true);
            }
        }
        protected void Event_Gridview_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "delete1")
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
                    {
                        con.Open();
                        string query = "DELETE FROM Event_Master WHERE E_ID = @E_ID";
                        SqlCommand cmd = new SqlCommand(query, con);
                        cmd.Parameters.AddWithValue("@E_ID", e.CommandArgument);
                        cmd.ExecuteNonQuery();
                    }

                    // Rebind the GridView after deletion
                    BindGridView();
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
            }
            else if (e.CommandName == "Add_Event_images")
            {
                Session["Event_Images"] = e.CommandArgument.ToString();
                Response.Redirect("Event_type_master.aspx");
            }
        }
        protected void BindGridView()
        {
            using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
            {
                con.Open();
                string query = "SELECT * FROM Event_Master";
                SqlCommand cmd = new SqlCommand(query, con);
                SqlDataReader reader = cmd.ExecuteReader();
                Event_Gridview.DataSource = reader;
                Event_Gridview.DataBind();
            }
        }
        protected void clearAll()
        {
            eid.Value = "";
            ename.Text = "";
            des.Text = "";
        }
        protected void btn_Clear_Click(object sender, EventArgs e)
        {
            clearAll();
        }
    }
}