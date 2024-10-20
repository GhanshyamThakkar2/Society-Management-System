<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="Allotment_Master.aspx.cs" Inherits="Society_Management_System.admin.Allotment_Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <title>Allotment List</title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="images/favicon.png">
    <!-- Custom Stylesheet -->
    <link href="vendor/bootstrap-select/dist/css/bootstrap-select.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

    <!-- Data table-->

    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-buttons/css/buttons.bootstrap4.min.css">

    <link rel="stylesheet" href="css/style.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Scripts>

            <asp:ScriptReference Path="../cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js" />
            <asp:ScriptReference Path="vendor/global/global.min.js" />
            <asp:ScriptReference Path="vendor/bootstrap-select/dist/js/bootstrap-select.min.js" />
            <asp:ScriptReference Path="vendor/chart.js/Chart.bundle.min.js" />

            <asp:ScriptReference Path="js/dashboard/dashboard-1.js" />

            <asp:ScriptReference Path="vendor/owl-carousel/owl.carousel.js" />
            <asp:ScriptReference Path="js/custom.min.js" />
            <asp:ScriptReference Path="js/deznav-init.js" />
            <asp:ScriptReference Path="js/demo.js" />
            <asp:ScriptReference Path="js/styleSwitcher.js" />

            <asp:ScriptReference Path="plugins/jquery/jquery.min.js" />
            <asp:ScriptReference Path="plugins/datatables/jquery.dataTables.min.js" />
            <asp:ScriptReference Path="plugins/datatables-bs4/js/dataTables.bootstrap4.min.js" />
            <asp:ScriptReference Path="plugins/datatables-responsive/js/dataTables.responsive.min.js" />
            <asp:ScriptReference Path="plugins/datatables-responsive/js/responsive.bootstrap4.min.js" />
            <asp:ScriptReference Path="plugins/datatables-buttons/js/dataTables.buttons.min.js" />
            <asp:ScriptReference Path="plugins/datatables-buttons/js/buttons.bootstrap4.min.js" />
            <asp:ScriptReference Path="plugins/jszip/jszip.min.js" />
            <asp:ScriptReference Path="plugins/pdfmake/pdfmake.min.js" />
            <asp:ScriptReference Path="plugins/pdfmake/vfs_fonts.js" />
            <asp:ScriptReference Path="plugins/datatables-buttons/js/buttons.html5.min.js" />
            <asp:ScriptReference Path="plugins/datatables-buttons/js/buttons.colVis.min.js" />
            <asp:ScriptReference Path="js/Popup.js" />

        </Scripts>

    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <Triggers>
            <asp:PostBackTrigger ControlID="btn_Save" />
        </Triggers>
        <ContentTemplate>
            <div class="col-xl-12 col-lg-12">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">Allotment Master</h4>
                    </div>
                    <div class="card-body">
                        <div class="basic-form">
                            <form>

                                <div class="form-row">
                                    <input type="hidden" id="A_ID" runat="server" class="form-control">

                                    <div class="form-group col-md-6">
                                        <label>First Name</label>
                                        <asp:TextBox ID="F_name" type="text" class="form-control" runat="server" placeholder="Enter First Name" ValidationGroup="allotment"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Enter First Name" ControlToValidate="F_name" Display="Dynamic" ForeColor="Red" ValidationGroup="allotment"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="*Enter Valid First Name" ValidationExpression="^[a-zA-Z\s]+$" ForeColor="Red" ControlToValidate="F_name" Display="None" ValidationGroup="allotment"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Last Name</label>
                                        <asp:TextBox ID="L_name" type="text" class="form-control" runat="server" placeholder="Enter Last Name" ValidationGroup="allotment"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="L_name" ErrorMessage="*Enter Last Name" Display="Dynamic" ValidationGroup="allotment" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="*Enter Valid Last Name" ValidationExpression="^[a-zA-Z\s]+$" ControlToValidate="L_name" ForeColor="Red" Display="None" ValidationGroup="allotment"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Email</label>
                                        <asp:TextBox ID="email" type="text" class="form-control" runat="server" placeholder="Enter Email Id" ValidationGroup="allotment"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="email" ErrorMessage="*Enter Email Id" Display="Dynamic" ValidationGroup="allotment" ForeColor="Red"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="email" runat="server" ErrorMessage="Enter Valid Email Id" Display="None" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ForeColor="Red" ValidationGroup="allotment"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Enter Mobile No</label>
                                        <asp:TextBox ID="Mobile_num" runat="server" class="form-control" placeholder="Enter Mobile Number" ValidationGroup="allotment"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*Enter Valid Mobile Number" Display="Dynamic" ValidationExpression="(\(\d{3}\)|\d{3}-)?\d{10}" ControlToValidate="Mobile_num" ForeColor="Red" ValidationGroup="allotment"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Birth Date</label>
                                        <asp:TextBox ID="dob" type="date" class="form-control" runat="server" placeholder="Enter Birth Date" ValidationGroup="allotment"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="dob" Display="Dynamic" ErrorMessage="*Enter Birth Date" ValidationGroup="allotment" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Enter Member In House</label>
                                        <asp:TextBox ID="tot_mem" type="text" class="form-control" runat="server" placeholder="Enter Member In House" ValidationGroup="allotment"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="tot_mem" Display="Dynamic" ErrorMessage="Enter Member In House" ValidationGroup="allotment"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ControlToValidate="tot_mem" ValidationExpression="^\d+$" ErrorMessage="*Enter Valid Member In House." ForeColor="Red" Display="None" ValidationGroup="allotment" />
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>ID For User</label>
                                        <asp:TextBox ID="uid" type="text" class="form-control" runat="server" placeholder="Enter User ID" ValidationGroup="allotment" ReadOnly></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="uid" Display="Dynamic" ErrorMessage="*Enter User ID" ForeColor="Red" ValidationGroup="allotment"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Password</label>
                                        <asp:TextBox ID="pass" type="password" runat="server" class="form-control" placeholder="Enter Password" ValidationGroup="allotment"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="pass" Display="Dynamic" ErrorMessage="*Enter Password" ForeColor="Red" ValidationGroup="allotment"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Image of User</label><br>
                                        <asp:FileUpload ID="img_user" runat="server" ValidationGroup="allotment" />
                                        <asp:Label ID="lbl_img" runat="server" Text=""></asp:Label>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <label>Enter Date</label>
                                        <asp:TextBox ID="e_date" type="date" class="form-control" runat="server" ValidationGroup="allotment" ReadOnly></asp:TextBox>
                                    </div>
                                </div>
                                <asp:Button ID="btn_Save" class="btn btn-rounded btn-outline-success" runat="server" Text="Save" ValidationGroup="allotment" OnClick="btn_Save_Click" />
                                <asp:Button ID="btn_Clear" class="btn btn-rounded btn-outline-success" runat="server" Text="Clear" OnClick="btn_Clear_Click" />
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <asp:GridView ID="Allotment_Gridview" runat="server" OnRowCommand="Allotment_Gridview_RowCommand" CssClass="table table-bordered table-striped" AutoGenerateColumns="False" DataKeyNames="A_ID,Image" AlternatingRowStyle-HorizontalAlign="NotSet">
                    <Columns>
                        <asp:BoundField DataField="A_ID" HeaderText="A_ID" Visible="false" InsertVisible="False" ReadOnly="True" SortExpression="A_ID" />
                        <asp:BoundField DataField="F_Name" HeaderText="First Name" SortExpression="First_Name" />
                        <asp:BoundField DataField="L_Name" HeaderText="Last Name" SortExpression="Last_Name" />
                        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                        <asp:BoundField DataField="Mobile_No" HeaderText="Mobile Number" SortExpression="Mobile_Number" />
                        <asp:BoundField DataField="Birth_Date" HeaderText="Birth Date" SortExpression="Birth_Date" />
                        <asp:BoundField DataField="Total_Member" HeaderText="Total Member" SortExpression="Total_Member" />
                        <asp:BoundField DataField="F_ID" HeaderText="F_ID" Visible="false" SortExpression="F_ID" />
                        <asp:BoundField DataField="User_ID" HeaderText="User ID" SortExpression="User_ID" />
                        <asp:BoundField DataField="Password" HeaderText="Password" SortExpression="Password" />
                        <asp:BoundField DataField="Image" HeaderText="Image" Visible="false" SortExpression="Image" />
                        <asp:TemplateField HeaderText="Image Of User" ItemStyle-Width="200px">
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%#"Images/Allotment_user_photo/" + Eval("Image") %>' Width="100px" Height="100px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Entry_Date" HeaderText="Entry Date" SortExpression="Entry_Date" />
                        <asp:TemplateField HeaderText="Action" ItemStyle-Width="200px">
                            <ItemTemplate>
                                <asp:Button ID="btnedit" Text="Edit" CommandName="Edit1" CssClass="btn btn-success" OnClick="btnedit_Click" CausesValidation="false" runat="server" />
                                <asp:Button ID="delete1" runat="server" Text="Delete" CssClass="btn btn-danger" CausesValidation="false" CommandName="delete1" CommandArgument='<%# Eval("A_ID")%>' OnClientClick="return message(this)" />
                                <asp:Button ID="Button1" Text="Add Image" CommandName="Add_Image" CssClass="btn btn-success" CommandArgument='<%# Eval("A_ID") %>' CausesValidation="false" runat="server" />
                            </ItemTemplate> 
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="White" ForeColor="#000066"></FooterStyle>

                        <HeaderStyle BackColor="#eb8153" Font-Bold="True" ForeColor="White"></HeaderStyle>

                        <PagerStyle HorizontalAlign="Left" BackColor="White" ForeColor="#000066"></PagerStyle>

                        <RowStyle ForeColor="#000066"></RowStyle>

                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

                        <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>

                        <SortedAscendingHeaderStyle BackColor="#007DBB"></SortedAscendingHeaderStyle>

                        <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>

                        <SortedDescendingHeaderStyle BackColor="#00547E"></SortedDescendingHeaderStyle>
                </asp:GridView>
            </div>
            <script>
                function BindControls() {
                    Sys.Application.add_init(function () {
                        $("#ContentPlaceHolder1_example1").DataTable({
                            "responsive": true, "lengthChange": false, "autoWidth": false,

                        }).buttons().container().appendTo('#ContentPlaceHolder1_example1_wrapper .col-md-6:eq(0)');

                    });
                }
                function message(del) {
                    if (del.dataset.confirmed) {
                        // The action was already confirmed by the user, proceed with server event
                        del.dataset.confirmed = false;
                        return true;
                    } else {
                        // Ask the user to confirm/cancel the action
                        event.preventDefault();
                        swal({
                            title: 'Are you sure?',
                            text: "Once deleted, you will not be able to recover it!",
                            icon: 'warning',
                            buttons: true,
                            dangerMode: true,
                        }).then(function (willDelete) {
                            if (willDelete) {
                                swal("The Record is Deleted!", {
                                    icon: "success",
                                }).then(function () {
                                    del.dataset.confirmed = true;
                                    // Trigger button click programmatically
                                    del.click();
                                });
                            }
                        });
                    }
                }
                function success() {
                    swal("Done!", "The Record is Saved!", "success");
                }
            </script>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
