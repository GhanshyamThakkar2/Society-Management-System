<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="Department_Master.aspx.cs" Inherits="Society_Management_System.admin.Department_Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Department List</title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="images/favicon.png">
    <!-- Custom Stylesheet -->
    <link href="vendor/bootstrap-select/dist/css/bootstrap-select.min.css" rel="stylesheet">

    <link rel="stylesheet" href="plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="plugins/datatables-buttons/css/buttons.bootstrap4.min.css">

    <link href="css/style.css" rel="stylesheet">
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
                        <h4 class="card-title">Department Master</h4>
                    </div>
                    <div class="card-body">
                        <div class="basic-form">
                            <form>

                                <div class="form-row">

                                    <input type="hidden" id="dep_id" class="form-control" runat="server">

                                    <div class="form-group col-md-6 ">
                                        <label>Enter Department Name</label>
                                        <asp:TextBox ID="dep_name" class="form-control" runat="server" placeholder="Enter Department Name" ValidationGroup="Department"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Enter Department Name" ControlToValidate="dep_name" Display="Dynamic" ForeColor="Red" ValidationGroup="Department"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*Enter Valid Department Name" ValidationExpression="^[a-zA-Z\s]+$" ForeColor="Red" ControlToValidate="dep_name" Display="Dynamic" ValidationGroup="Department"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Enter City</label>
                                        <asp:TextBox ID="dep_city" class="form-control" runat="server" placeholder="Enter City Name" ValidationGroup="Department"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Enter City Name" ControlToValidate="dep_city" Display="Dynamic" ForeColor="Red" ValidationGroup="Department"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="*Enter Valid City Name" ValidationExpression="^[a-zA-Z\s]+$" ForeColor="Red" ControlToValidate="dep_city" Display="Dynamic" ValidationGroup="Department"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Enter Address</label>
                                        <asp:TextBox ID="dep_add" class="form-control" runat="server" placeholder="Enter Address" ValidationGroup="Department"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*Enter Address" ControlToValidate="dep_add" Display="Dynamic" ForeColor="Red" ValidationGroup="Department"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Enter Pin-code</label>
                                        <asp:TextBox ID="dep_pin_code" class="form-control" runat="server" placeholder="Enter Pin-code" ValidationGroup="Department"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*Enter Pin-code" ForeColor="Red" ControlToValidate="dep_pin_code" Display="Dynamic" ValidationGroup="Department"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="*Enter Valid Pincode" Display="Dynamic" ForeColor="Red" ValidationExpression="(\(\d{3}\)|\d{3}-)?\d{6}" ControlToValidate="dep_pin_code" ValidationGroup="Department"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Enter No of Houses</label>
                                        <asp:TextBox ID="dep_no_houses" class="form-control" runat="server" placeholder="Enter Number of House in Department" ValidationGroup="Department"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*Enter Number of House in Department" ForeColor="Red" ControlToValidate="dep_no_houses" Display="Dynamic" ValidationGroup="Department"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="dep_no_houses" ForeColor="Red" ValidationExpression="^\d+$" ErrorMessage="*Enter a valid House Number." Display="Dynamic" ValidationGroup="Department" />

                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Upload Image of Department</label>
                                        <asp:FileUpload ID="dep_img" runat="server" />
                                        <asp:Label ID="lbl_img" runat="server" Text=""></asp:Label>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Entry Date</label>
                                        <asp:TextBox ID="dep_date" type="date" class="form-control" runat="server" ReadOnly></asp:TextBox>
                                    </div>

                                </div>
                                <asp:Button ID="btn_Save" runat="server" Text="Save" CssClass="btn btn-rounded btn-outline-success" ValidationGroup="Department" OnClick="btn_Save_Click" />
                                <asp:Button ID="btn_Clear" class="btn btn-rounded btn-outline-success" runat="server" Text="Clear" OnClick="btn_Clear_Click" />
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="table table-striped table-bordered">
                <asp:GridView ID="Department_Gridview" runat="server" CssClass="table table-striped table-bordered" AutoGenerateColumns="False" DataKeyNames="D_ID,Image,Department_Name" OnRowCommand="Department_Gridview_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="D_ID" HeaderText="ID" Visible="false" InsertVisible="False" ReadOnly="True" SortExpression="D_ID" />
                        <asp:BoundField DataField="Department_Name" HeaderText="Department Name" SortExpression="Department_Name" />
                        <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                        <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                        <asp:BoundField DataField="Pincode" HeaderText="Pincode" SortExpression="Pincode" />
                        <asp:BoundField DataField="No_of_Houses" HeaderText="Number of Houses" SortExpression="No_of_Houses" />
                        <asp:BoundField DataField="Image" HeaderText="Image" Visible="false" SortExpression="Image" />
                        <asp:TemplateField HeaderText="Department Image" ItemStyle-Width="200px">
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# "Images/Department_Image/" + Eval("Image") %>' Width="100px" Height="100px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Entry_Date" HeaderText="Entry Date" SortExpression="Entry_Date" />
                        <asp:TemplateField HeaderText="Action" ItemStyle-Width="200px">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" Text="Edit" CommandName="Edit1" CssClass="btn btn-success" OnClick="btnEdit_Click" CausesValidation="false" runat="server" />
                                <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger" CausesValidation="false" CommandName="delete1" CommandArgument='<%# Eval("D_ID")%>' />
                                <asp:Button ID="Add_Flat" runat="server" Text="Add Flat" CommandName="add_flat" CssClass="btn btn-success" CommandArgument='<%#Eval("D_ID") %>' CausesValidation="false" />
                                <asp:Button ID="Add_Department_Image" runat="server" Text="Add Department Image" CommandName="Add_Department_Image" CssClass="btn btn-success" CommandArgument='<%#Eval("D_ID") %>' CausesValidation="false" />
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
                        $("#ContentPlaceHolder1_Department_Gridview").DataTable({
                            "responsive": true, "lengthChange": false, "autoWidth": false,
                           
                        }).buttons().container().appendTo('#ContentPlaceHolder1_Department_Gridview_wrapper .col-md-6:eq(0)');

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
