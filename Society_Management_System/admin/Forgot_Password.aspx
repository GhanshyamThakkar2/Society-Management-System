<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Forgot_Password.aspx.cs" Inherits="Society_Management_System.admin.Forgot_Password" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Aravali society</title>
    <link href="~/Admin/vendor/sweetalert2/dist/sweetalert2.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="assets/css/admin_login.css" />
    
</head>
<body>
     <div class="wrapper">
  <div class="container">
    <div class="col-left">
      <div class="login-text">
        <h2>Forgot Password?</h2>
        <p>Enter Your Email Id<br/>And Enter OTP.</p>
        <a class="btn" href="user_login.aspx">User Login</a>
      </div>
    </div>
    <div class="col-right">
      <div class="login-form">
        <h2>Forgot Password</h2>
        <form id="form1" runat="server">

            <asp:ScriptManager ID="ScriptManager1" runat="server">
                <Scripts>
                    <asp:ScriptReference Path="~/admin/vendor/sweetalert2/dist/sweetalert2.min.js" />
                    <asp:ScriptReference Path="~/admin/js/plugins-init/sweetalert.init.js" />
                    
                </Scripts>
            </asp:ScriptManager>
            <asp:UpdatePanel ID="Updatepanel1" runat="server">
                <ContentTemplate>
                    <asp:SqlDataSource  id="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:ConnectionString %>' SelectCommand="SELECT [Email] FROM [Allotment_Master] WHERE ([Email] = @Email)">

                        <SelectParameters>
                            <asp:ControlParameter ControlID="Email" PropertyName="Text" Name="Email" Type="String"></asp:ControlParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                    
                    <p>
                        <asp:Label ID="Label1" runat="server" Text="Enter Your Email"></asp:Label>
                        <asp:TextBox ID="Email" type= "email" runat="server" AutoComplete="off"></asp:TextBox>

                    </p>
                    
                    <p>
                        <asp:Button ID="Button1" runat="server" Text="Send OTP" />

                    </p>
                </ContentTemplate>
            </asp:UpdatePanel>
          
        </form>
      </div>
    </div>
  </div>
 
</div>
</body>
</html>
