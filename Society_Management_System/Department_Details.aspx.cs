using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Society_Management_System
{
    public partial class Department_Details : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;
            // Check if Session["D_ID"] is not null before using it
            if (Session["D_ID"] != null)
            {
                Label1.Text = Session["D_ID"].ToString();
            }
            else
            {
                // Handle the case where Session["D_ID"] is null
                Label1.Text = "No Department ID available";
            }
        }


        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (!string.IsNullOrEmpty(e.CommandArgument.ToString()))
            {
                Session["D_ID"] = e.CommandArgument;
                Response.Redirect("Department_Details.aspx");
            }
        }
    }
}