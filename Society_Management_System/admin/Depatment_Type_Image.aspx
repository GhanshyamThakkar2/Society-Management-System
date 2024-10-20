<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="Depatment_Type_Image.aspx.cs" Inherits="Society_Management_System.admin.Depatment_Type_Image" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Admin Dashboard </title>

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
                        <h4 class="card-title">Department Images</h4>
                    </div>
                    <div class="card-body">
                        <div class="basic-form">
                            <form>

                                <div class="form-row">

                                    <input type="hidden" id="id" class="form-control" runat="server" />

                                    <div class="form-group col-md-6 ">
                                        <label>Department Name</label>
                                        <asp:TextBox ID="dep_name" ReadOnly runat="server" class="form-control"></asp:TextBox>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Upload Image </label>
                                        <br />
                                        &nbsp;&nbsp;
                                        <asp:FileUpload ID="img" runat="server" />
                                        <asp:Label ID="lbl_img" runat="server" Text=""></asp:Label>
                                    </div>
                                    <div class="form-group col-md-12">
                                        <label>Department Description</label>
                                        <asp:TextBox ID="des" runat="server" TextMode="MultiLine" class="form-control" Rows="5" cols="20"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Enter Department Description." ControlToValidate="des" Display="None" ValidationGroup="Event"></asp:RequiredFieldValidator>
                                    </div>

                                </div>
                                <asp:Button ID="btn_Save" runat="server" Text="Save" CssClass="btn btn-rounded btn-outline-success" ValidationGroup="Event" OnClick="btn_Save_Click"  />
                                <asp:Button ID="btn_Clear" CssClass="btn btn-rounded btn-outline-success" runat="server" Text="Clear" CausesValidation="false" />
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="table table-striped table-bordered">
                
                <asp:GridView ID="Department_Image_Gridview" ClientIDMode="Static" runat="server" OnRowCommand="Department_Image_Gridview_RowCommand" CssClass="table table-striped table-bordered" AutoGenerateColumns="False" DataKeyNames="ID,Image">
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="ID" Visible="false" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                        <asp:BoundField DataField="D_ID" Visible="false" HeaderText="D_ID" SortExpression="D_ID" />
                        <asp:BoundField DataField="Image" Visible="false" HeaderText="Image" SortExpression="Image"></asp:BoundField>
                        <asp:TemplateField HeaderText="Image" ItemStyle-Width="200px">
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# "Images/Department_Type_Image_Master/" + Eval("Image") %>' Width="100px" Height="100px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"></asp:BoundField>
                        <asp:TemplateField HeaderText="Action" ItemStyle-Width="200px">
                            <ItemTemplate>
                                <asp:Button ID="btnedit" Text="Edit" CommandName="Edit1" CssClass="btn btn-success" OnClick="btnEdit_Click" CausesValidation="false" runat="server" />
                                <asp:Button ID="delete1" runat="server" Text="Delete" CssClass="btn btn-danger" CausesValidation="false" CommandName="delete1" CommandArgument='<%# Eval("ID")%>' OnClientClick="return message(this)" />
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
                        $("#example1").DataTable({
                            "responsive": true, "lengthChange": false, "autoWidth": false,

                        }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');

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
