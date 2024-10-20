<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="Circular_Master.aspx.cs" Inherits="Society_Management_System.admin.Circular_Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Custom Stylesheet -->
    <link href="vendor/bootstrap-select/dist/css/bootstrap-select.min.css" rel="stylesheet">
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
                        <h4 class="card-title">Circular</h4>
                    </div>
                    <div class="card-body">
                        <div class="basic-form">
                            <form>

                                <div class="form-row">

                                    <input type="hidden" id="c_id" runat="server" class="form-control">

                                    <div class="form-group col-md-6 ">
                                        <label>Circular Date</label>
                                        <asp:TextBox type="text" ID="c_cir_date" runat="server" class="form-control" placeholder="Enter Date of Circular" ValidationGroup="circular"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="c_cir_date" runat="server" ErrorMessage="*Enter Date of Circular" Display="None" ValidationGroup="circular"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Circular From</label>
                                        <asp:TextBox ID="c_from" type="text" runat="server" class="form-control" placeholder="From Where is Circular" ValidationGroup="circular"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="c_from" runat="server" ErrorMessage="*Enter From Where is Circular" Display="None" ValidationGroup="circular"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*Enter Valid From Where is Circular" ValidationExpression="^[a-zA-Z\s]+$" ControlToValidate="c_from" Display="None" ValidationGroup="circular"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Circular Subject</label>
                                        <asp:TextBox type="text" ID="c_sub" runat="server" class="form-control" placeholder="Enter Circular Subject" ValidationGroup="circular"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="c_sub" runat="server" ErrorMessage="*Enter Circular Subject" Display="None" ValidationGroup="circular"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="*Enter Valid Circular Subject" ValidationExpression="^[a-zA-Z\s]+$" ControlToValidate="c_sub" Display="None" ValidationGroup="circular"></asp:RegularExpressionValidator>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Circular File</label><br />
                                        <asp:FileUpload ID="circular" runat="server" CssClass="btn btn-rounded" ValidationGroup="circular" /><br>
                                        <asp:Label ID="lbl_img" runat="server" Text=""></asp:Label>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Entery Date</label>
                                        <asp:TextBox ID="c_date" type="date" runat="server" class="form-control" placeholder="Enter Date" ValidationGroup="circular" ReadOnly></asp:TextBox>
                                    </div>

                                </div>
                                <asp:Button ID="btn_Save" class="btn btn-rounded btn-outline-success" runat="server" Text="Save" ValidationGroup="circular" OnClick="btn_Save_Click" OnClientClick="success()" />
                                <asp:Button ID="btn_Clear" class="btn btn-rounded btn-outline-success" runat="server" Text="Clear" OnClick="btn_Clear_Click" />
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" ValidationGroup="circular" />
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <asp:GridView ID="Circular_Gridview" OnRowCommand="Circular_Gridview_RowCommand" runat="server" CssClass="table table-striped table-bordered" AutoGenerateColumns="False" DataKeyNames="Cir_ID,Circular" AlternatingRowStyle-HorizontalAlign="NotSet">
                    <Columns>
                        <asp:BoundField DataField="Cir_ID" HeaderText="ID" Visible="false" InsertVisible="False" ReadOnly="True" SortExpression="Cir_ID" />
                        <asp:BoundField DataField="Cir_Date" HeaderText="Circular Date" SortExpression="Cir_Date" />
                        <asp:BoundField DataField="Cir_From" HeaderText="From" SortExpression="Cir_From" />
                        <asp:BoundField DataField="Cir_Subject" HeaderText="Subject" SortExpression="Cir_Subject" />
                        <asp:BoundField DataField="Circular" HeaderText="Circular" Visible="false" SortExpression="Circular" />
                        <asp:TemplateField HeaderText="Image" ItemStyle-Width="200px">
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%#"Images/Circular/" + Eval("Circular") %>' Width="100px" Height="100px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Entry_Date" HeaderText="Entry Date" SortExpression="Entry_Date" />
                        <asp:TemplateField HeaderText="Action" ItemStyle-Width="200px">
                            <ItemTemplate>
                                <asp:Button ID="btnedit" Text="Edit" CommandName="Edit1" CssClass="btn btn-success" OnClick="btnedit_Click" CausesValidation="false" runat="server" />
                                <asp:Button ID="delete1" runat="server" Text="Delete" CssClass="btn btn-danger" CausesValidation="false" CommandName="delete1" CommandArgument='<%# Eval("Cir_ID")%>' OnClientClick="return message(this)" />
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
