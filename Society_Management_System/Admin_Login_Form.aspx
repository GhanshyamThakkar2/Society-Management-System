<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin_Login_Form.aspx.cs" Inherits="Society_Management_System.Admin_Login_Form" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="~/Admin/vendor/bootstrap-select/dist/css/bootstrap-select.min.css" rel="stylesheet" />
    <link href="~/Admin/vendor/sweetalert2/dist/sweetalert2.min.css" rel="stylesheet" />
    <link href="~/Admin/css/style.css" rel="stylesheet" />
</head>
<body>
    <div class="vh-100">
        <div class="authincation h-100">
            <div class="container h-100">
                <div class="row justify-content-center h-100 align-items-center">
                    <div class="col-md-6">
                        <div class="authincation-content">
                            <div class="row no-gutters">
                                <div class="col-xl-12">
                                    <div class="auth-form">
                                        <h2 class="text-center mb-4">Login</h2>
                                        <form runat="server">
                                            <asp:ScriptManager ID="ScriptManager1" runat="server">
                                                <Scripts>
                                                    <asp:ScriptReference Path="~/Admin/vendor/sweetalert2/dist/sweetalert2.min.js" />
                                                    <asp:ScriptReference Path="~/Admin/js/plugins-init/sweetalert.init.js" />
                                                </Scripts>
                                            </asp:ScriptManager>
                                            <asp:UpdatePanel runat="server" ID="Updatepanel1">
                                                <ContentTemplate>
                                                    <div class="form-group">
                                                        <asp:Label ID="Label1" class="mb-1" runat="server" Text="Username"><strong>Username</strong></asp:Label>
                                                        <asp:TextBox ID="username" class="form-control" runat="server" placeholder="USERNAME" AutoComplete="off"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group">
                                                        <asp:Label ID="Label2" class="mb-1" runat="server" Text="Password"><strong>Password</strong></asp:Label>
                                                        <asp:TextBox ID="password" class="form-control" TextMode="Password" runat="server" placeholder="PASSWORD"></asp:TextBox>
                                                    </div>
                                                    <div class="form-row d-flex justify-content-between mt-4 mb-2">
                                                        <%-- Uncomment if needed --%>
                                                        <%--<div class="form-group">
                                                            <a href="#">Forgot Password?</a>
                                                        </div>--%>
                                                    </div>
                                                    <div class="text-center">
                                                        <asp:Button ID="Button1" class="btn btn-primary btn-block" runat="server" Text="Login" OnClick="Button1_Click" />
                                                    </div>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--**********************************
        Scripts
    ***********************************-->
    <!-- Required vendors -->
    <script src="~/Admin/vendor/global/global.min.js"></script>
    <script src="~/Admin/vendor/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
    <script src="~/Admin/js/custom.min.js"></script>
    <script src="~/Admin/js/deznav-init.js"></script>
    <script src="~/Admin/js/demo.js"></script>
</body>
</html>
