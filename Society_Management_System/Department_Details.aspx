<%@ Page Title="" Language="C#" MasterPageFile="~/Main_Master.Master" AutoEventWireup="true" CodeBehind="Department_Details.aspx.cs" Inherits="Society_Management_System.Department_Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label>
    <main id="main">

        <!-- ======= Breadcrumbs ======= -->
        <div class="breadcrumbs d-flex align-items-center" style="background-image: url('admin/Images/SIENA%20PHOTOS/10..png');">
            <div class="container position-relative d-flex flex-column align-items-center" data-aos="fade">
                <h2>Department Details</h2>
                <ol>
                    <li><a href="Home.aspx">Home</a></li>
                    <li>Department Details</li>
                </ol>
            </div>
        </div>
        <!-- End Breadcrumbs -->

        <!-- ======= Blog Details Section ======= -->
        <section id="blog" class="blog">
            <div class="container" data-aos="fade-up" data-aos-delay="100">
                <div class="row g-5">
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                        <ItemTemplate>
                            <div class="col-lg-8" style="width: 2000px; margin-bottom: 20px;">
                                <article class="blog-details">
                                    <asp:Repeater ID="Repeater3" runat="server" DataSourceID="SqlDataSource2">
                                        <ItemTemplate>
                                            <div class="post-img">
                                                <img src='<%# "admin/Images/Department_Type_Image_Master/" + Eval("Image") %>' alt="" class="img-fluid">
                                            </div>
                                            <asp:Repeater ID="Repeater4" runat="server" DataSourceID="SqlDataSource1">
                                                <ItemTemplate>
                                                    <h2 class="title"><%# Eval("Department_Name") %></h2>
                                                    <p><%# Eval("Description") %></p>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </ItemTemplate>
                                    </asp:Repeater>

                                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString='<%$ ConnectionStrings:Society_ConnectionString %>' SelectCommand="SELECT * FROM [Department_Type__Image_Master] WHERE ([D_ID] = @D_ID)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="Label1" PropertyName="Text" Name="D_ID" Type="Int32"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </article>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:Society_ConnectionString %>' SelectCommand="SELECT * FROM [Department_Master] WHERE ([D_ID] = @D_ID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Label1" PropertyName="Text" Name="D_ID" Type="Int32"></asp:ControlParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </section>

        <section id="constructions" class="constructions">
            <div class="container" data-aos="fade-up">
                <div class="section-header">
                    <h2>Other Departments</h2>
                </div>
                <div class="row gy-4">
                    <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
                        <ItemTemplate>
                            <div class="col-lg-6" data-aos="fade-up" data-aos-delay="100">
                                <div class="card-item">
                                    <div class="row">
                                        <div class="col-xl-5">
                                            <div class="card-bg" style="background-image: url('<%# "/admin/Images/Department_Image/" + Eval("Image") %>')"></div>
                                        </div>
                                        <div class="col-xl-7 d-flex align-items-center">
                                            <div class="card-body">
                                                <h4 class="card-title"><%# Eval("Department_Name") %></h4>
                                                <asp:LinkButton ID="View_events" runat="server" CommandArgument='<%# Eval("D_ID") %>' class="readmore stretched-link">Read More</asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString='<%$ ConnectionStrings:Society_ConnectionString %>' SelectCommand="SELECT * FROM [Department_Master] WHERE ([D_ID] <> @D_ID)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Label1" PropertyName="Text" Name="D_ID" Type="Int32"></asp:ControlParameter>
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </section>
    </main>
</asp:Content>

