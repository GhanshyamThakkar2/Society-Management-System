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
    public partial class Event_type_master : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;
            if (!IsPostBack)
            {
                Session.Add("Flag", 0);
                if (Session["Event_Images"] != null)
                {
                    DAO d = new DAO();
                    DataSet ds = new DataSet();
                    ds = d.LoadData("select * from Event_Master where E_ID=" + Session["Event_Images"]);
                    if (ds.Tables[0].Rows.Count != 0)
                    {
                        eid.Value = ds.Tables[0].Rows[0]["E_ID"].ToString();
                    }
                }
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
                    if (string.IsNullOrEmpty(id.Value))
                    {
                        // INSERT Operation
                        query = "INSERT INTO Event_Type_Master (E_ID, Image) VALUES (@E_ID, @Image)";
                    }
                    else
                    {
                        // UPDATE Operation
                        query = "UPDATE Event_Type_Master SET  Image = @Image WHERE ID = @ID";
                        cmd.Parameters.AddWithValue("@ID", id.Value);
                    }

                    cmd.Connection = con;
                    cmd.CommandText = query;

                    // Add parameters
                    cmd.Parameters.AddWithValue("@E_ID", eid.Value);
                    //cmd.Parameters.AddWithValue("@E_Type", E_Name.Text);

                    string fileName = lbl_img.Text;
                    if (img.HasFile)
                    {
                        fileName = img.FileName;
                        if (fileName.EndsWith("jpg") || fileName.EndsWith("png") || fileName.EndsWith("jpeg"))
                        {
                            img.SaveAs(Server.MapPath("Images/Event_Type_Images/") + fileName);
                        }
                    }
                    cmd.Parameters.AddWithValue("@Image", fileName);

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
        protected void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvRow = (GridViewRow)((Control)sender).NamingContainer;
                int index = gvRow.RowIndex;

                id.Value = Event_Type_Gridview.DataKeys[index].Values["ID"].ToString();
                //E_Name.Text = Event_Type_Gridview.Rows[index].Cells[1].Text;
                lbl_img.Text = Event_Type_Gridview.DataKeys[index].Values["Image"].ToString();
                BindGridView();
                Session["Flag"] = 1;
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
        protected void Event_Type_Master_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "delete1")
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
                    {
                        con.Open();
                        SqlCommand cmd = new SqlCommand("DELETE FROM Event_Type_Master WHERE ID = @ID", con);
                        cmd.Parameters.AddWithValue("@ID", e.CommandArgument);
                        cmd.ExecuteNonQuery();
                    }

                    // Delete associated image file
                    string imageName = Event_Type_Gridview.DataKeys[Convert.ToInt32(e.CommandArgument)].Values["Image"].ToString();
                    if (System.IO.File.Exists(Server.MapPath("Images/Event_Type_Images/") + imageName))
                    {
                        System.IO.File.Delete(Server.MapPath("Images/Event_Type_Images/") + imageName);
                    }

                    BindGridView();
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
            }
        }
        protected void BindGridView()
        {
            using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["Society_ConnectionString"].ConnectionString))
            {
                con.Open();
                string query = "SELECT * FROM Event_Type_Master where E_ID = @E_ID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@E_ID", Session["Event_Images"]);
                SqlDataReader reader = cmd.ExecuteReader();
                Event_Type_Gridview.DataSource = reader;
                Event_Type_Gridview.DataBind();
            }
        }
        protected void clearAll()
        {
            id.Value = "";
            //E_Name.Text = "";
            lbl_img.Text = "";
        }
        protected void btn_Clear_Click(object sender, EventArgs e)
        {
            clearAll();
        }
    }
}