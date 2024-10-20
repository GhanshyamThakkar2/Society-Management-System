<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="Flat_Master.aspx.cs" Inherits="Society_Management_System.admin.Flat_Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <title>Flat List</title>
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
        <ContentTemplate>
            <div class="col-xl-12 col-lg-12">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">Flat Master</h4>
                    </div>
                    <div class="card-body">
                        <div class="basic-form">
                            <form>


                                <asp:HiddenField ID="flat_ID" runat="server" />

                                <div class="form-row">
                                    <div class="form-group col-md-6 ">

                                        <label>Department</label>
                                        <asp:TextBox ID="dep_name" runat="server" class="form-control" ReadOnly ValidationGroup="flat"></asp:TextBox>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Flat No.</label>
                                        <asp:TextBox ID="flat_No" runat="server" class="form-control"  placeholder="Enter Flat No." ValidationGroup="flat"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red" runat="server" ErrorMessage="*Enter Flat No." ControlToValidate="flat_No" Display="Dynamic" ValidationGroup="flat"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>House Type</label>
                                        <asp:DropDownList ID="h_type" runat="server" class="form-control" placeholder="Enter House Type" AutoPostBack="True" DataTextField="House_Type" DataValueField="House_Type" DataSourceID="SqlDataSource1"></asp:DropDownList>
                                        <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:Society_ConnectionString %>' SelectCommand="SELECT [House_Type] FROM [House_Type_Master] WHERE ([D_ID] = @D_ID)">
                                            <SelectParameters>
                                                <asp:SessionParameter SessionField="flat" DefaultValue="0" Name="D_ID" Type="Int32"></asp:SessionParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label>Area</label>
                                        <asp:TextBox ID="f_area" runat="server" class="form-control" placeholder="Enter The Area of Flat" ValidationGroup="flat"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Enter The Area of Flat" ControlToValidate="f_area" Display="Dynamic" ForeColor="Red" ValidationGroup="flat"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="f_area" ValidationExpression="^\d+$" ErrorMessage="*Enter The valid Area of Flat" Display="None" ValidationGroup="flat" />
                                    </div>
                                </div>
                                <div class="form-group col-md-4">
                                    <label>Entry Date</label>
                                    <asp:TextBox ID="E_Date" type="date" runat="server" class="form-control" ValidationGroup="flat" ReadOnly></asp:TextBox>
                                </div>
                                <asp:Button ID="btn_Save" runat="server" Text="Save" CssClass="btn btn-rounded btn-outline-success" ValidationGroup="flat" OnClick="btn_Save_Click" />
                                <asp:Button ID="btn_Clear" class="btn btn-rounded btn-outline-success" runat="server" Text="Clear" OnClick="btn_Clear_Click" />
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                
                <asp:GridView ID="Flat_Master_Gridview" runat="server" CssClass="table table-striped table-bordered" OnRowCommand="Flat_Master_Gridview_RowCommand" AutoGenerateColumns="False" DataKeyNames="F_ID,D_ID">
                    <Columns>
                        <asp:BoundField DataField="F_ID" Visible="false" InsertVisible="False" ReadOnly="True" SortExpression="F_ID" />
                        <asp:BoundField DataField="D_ID" Visible="false" SortExpression="D_ID" />

                        <asp:BoundField DataField="Flat_No" HeaderText="Flat No" SortExpression="Flat_No" />

                        <asp:BoundField DataField="House_Type" HeaderText="House Type" SortExpression="House_Type" />
                        <asp:BoundField DataField="Area" HeaderText="Area" SortExpression="Area" />
                        <asp:BoundField DataField="Entry_Date" HeaderText="Entry Date" SortExpression="Entry_Date" />
                        <asp:TemplateField HeaderText="Action" ItemStyle-Width="200px">
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" Text="Edit" CommandName="Edit1" CssClass="btn btn-success" OnClick="btnEdit_Click" CausesValidation="false" runat="server" />
                                <asp:Button ID="delete1" runat="server" Text="Delete" CssClass="btn btn-danger" CausesValidation="false" CommandName="delete1" CommandArgument='<%# Eval("F_ID")%>' />
                                <asp:Button ID="Add_Allotment" Text="Add Allotment" CommandName="Add_Allotment" CssClass="btn btn-success" CausesValidation="false" CommandArgument='<%#Eval("F_ID") %>' runat="server" />
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
