<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="Allotment_Image_Master.aspx.cs" Inherits="Society_Management_System.admin.Allotment_Image_Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8">
    <meta name="keywords" content="">
    <meta name="author" content="">
    <meta name="robots" content="">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta name="description" content="Zenix - Crypto Admin Dashboard">
    <meta property="og:title" content="Zenix - Crypto Admin Dashboard">
    <meta property="og:description" content="Zenix - Crypto Admin Dashboard">
    <meta property="og:image" content="https://zenix.dexignzone.com/xhtml/social-image.png">
    <meta name="format-detection" content="telephone=no">
    <title>Zenix -  Crypto Admin Dashboard </title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="images/favicon.png">
    <!-- Custom Stylesheet -->
    <link href="vendor/bootstrap-select/dist/css/bootstrap-select.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:scriptmanager id="ScriptManager1" runat="server">
        <Scripts>  
        <asp:ScriptReference Path="../cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"  />
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
    </asp:scriptmanager>
    <asp:updatepanel id="UpdatePanel1" runat="server">
        <Triggers> <asp:PostBackTrigger ControlID="btn_Save"/> </Triggers>
        <ContentTemplate>
     <div class="col-xl-12 col-lg-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Identity Proof of Family Member</h4>
                            </div>
                            <div class="card-body">
                                <div class="basic-form">
                                    <form>

                                        <div class="form-row">

                                            <input type="hidden" id="img_id" runat="server">
                                            <asp:HiddenField ID="aid" runat="server" />
                                            <div class="form-group col-md-6 ">
                                                <label>Name</label>
                                                <asp:TextBox id="name" runat="server" class="form-control" placeholder="Enter Name" ValidationGroup="Image"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="name" runat="server" ForeColor="Red" ErrorMessage="*Enter Name" Display="Dynamic" ValidationGroup="Image"></asp:RequiredFieldValidator>
                                            </div>
                                            &nbsp;
                                            <div class="form-group col-md-6">
                                                <label> Upload File</label><br />
                                                <asp:FileUpload ID="img" runat="server" ValidationGroup="Image"/><br>
                                                <asp:Label ID="lbl_img" runat="server" Text=""></asp:Label>
                                            </div>
                                              

                                        </div>
                                        <asp:Button ID="btn_Save" class="btn btn-rounded btn-outline-success" runat="server" Text="Save" ValidationGroup="Image" OnClick="btn_Save_Click" />
                                        <asp:Button ID="btn_Clear" class="btn btn-rounded btn-outline-success" runat="server" Text="Clear" OnClick="btn_Clear_Click" />
                                    </form>
                                </div>
                            </div>
                        </div>
					</div>
    <div>
        <asp:GridView ID="Allotment_Image_Gridview" runat="server" CssClass="table table-striped table-bordered" AutoGenerateColumns="False" DataKeyNames="I_ID,Image" AlternatingRowStyle-HorizontalAlign="NotSet">
            <Columns>
                <asp:BoundField DataField="I_ID" HeaderText="I_ID" Visible="false" InsertVisible="False" ReadOnly="True" SortExpression="I_ID" />
                <asp:BoundField DataField="A_ID" HeaderText="A_ID" Visible="false" SortExpression="A_ID" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name"></asp:BoundField>
                <asp:BoundField DataField="Image" Visible="false" HeaderText="Image" SortExpression="Image"></asp:BoundField>
                <asp:TemplateField HeaderText="User Member Image" ItemStyle-Width="200px">
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%#"Images/User_Documents_Image_Image_Master/" + Eval("Image") %>' Width="100px" Height="100px" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action" ItemStyle-Width="200px">
                    <ItemTemplate>
                        <asp:Button ID="btnedit" OnClick="btnedit_Click" text="Edit" CommandName="Edit1" CssClass="btn btn-success" CausesValidation="false" runat="server" />
                        <asp:Button ID="delete1" runat="server" Text="Delete" CssClass="btn btn-danger"  CausesValidation="false" CommandName="delete1"  CommandArgument='<%# Eval("I_ID")%>' OnClientClick="return message(this)"/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
            <script>
                function BindControls() {
                    Sys.Application.add_init(function () {
                        $("#ContentPlaceHolder1_example1").DataTable({
                            "responsive": true, "lengthChange": false, "autoWidth": false,
                            "buttons": ["copy", "csv", "excel", "pdf", "print"]
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
        </asp:updatepanel>
</asp:Content>
