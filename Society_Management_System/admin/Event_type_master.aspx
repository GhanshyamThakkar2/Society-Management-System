<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="Event_type_master.aspx.cs" Inherits="Society_Management_System.admin.Event_type_master" %>
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
                        <h4 class="card-title">Event Type</h4>
                    </div>
                    <div class="card-body">
                        <div class="basic-form">
                            <form>

                                <div class="form-row">

                                    <input type="hidden" id="id" class="form-control" runat="server" />
                                    <asp:HiddenField ID="eid" runat="server" />
                                   <%-- <div class="form-group col-md-6 ">
                                        <label>Event</label>
                                        <asp:TextBox ID="E_Name" CssClass="form-control" runat="server"></asp:TextBox>
                                    </div>--%>
                                    <div class="form-group col-md-6">
                                        &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;<label>Upload Image </label><br />
                                       &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; <asp:FileUpload ID="img" runat="server" />
                                        <asp:Label ID="lbl_img" runat="server" Text=""></asp:Label>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="img" runat="server" ErrorMessage="*Please Upload The Image" ForeColor="red"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <asp:Button ID="btn_Save" runat="server" Text="Save" CssClass="btn btn-rounded btn-outline-success" OnClick="btn_Save_Click" ValidationGroup="gallery"/>
                                <asp:Button ID="btn_Clear" class="btn btn-rounded btn-outline-success" runat="server" OnClick="btn_Clear_Click" Text="Clear" />
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div>
            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            <asp:GridView ID="Event_Type_Gridview" OnRowCommand="Event_Type_Master_RowCommand" runat="server" CssClass="table table-striped table-bordered" AutoGenerateColumns="False" DataKeyNames="ID">
                <Columns>
                    <asp:BoundField DataField="ID" Visible="false" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="ID"></asp:BoundField>
                    <asp:BoundField DataField="E_ID" Visible="false" HeaderText="E_ID" SortExpression="E_ID"></asp:BoundField>
                    <%--<asp:BoundField DataField="E_Type" HeaderText="Event Type" SortExpression="E_Type"></asp:BoundField>--%>
                    <asp:BoundField DataField="Image" Visible="false" HeaderText="Image" SortExpression="Image"></asp:BoundField>
                    <asp:TemplateField HeaderText="Event Image" ItemStyle-Width="200px">
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# "images/Event_Type_Images/" + Eval("Image") %>' Width="100px" Height="100px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action" ItemStyle-Width="200px">
                            <ItemTemplate>
                                <asp:Button ID="btnedit" Text="Edit" CommandName="Edit1" CssClass="btn btn-success" OnClick="btnedit_Click" CausesValidation="false" runat="server" />
                                <asp:Button ID="delete1" runat="server" Text="Delete" CssClass="btn btn-danger"  CausesValidation="false" CommandName="delete1"  CommandArgument='<%# Eval("ID")%>' OnClientClick="return message(this)"/>
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
