<%@ Page Title="" Language="C#" MasterPageFile="~/Main_Master.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Society_Management_System.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- ======= Breadcrumbs ======= -->
    <div class="breadcrumbs d-flex align-items-center" style="background-image: url('admin/images/SIENA%20PHOTOS/10..png');">
        <div class="container position-relative d-flex flex-column align-items-center" data-aos="fade">

            <h2>Contact</h2>
            <ol>
                <li><a href="Home.aspx">Home</a></li>
                <li>Contact</li>
            </ol>

        </div>
    </div>
    <!-- End Breadcrumbs -->

    <!-- ======= Contact Section ======= -->
    <section id="contact" class="contact">
        <div class="container" data-aos="fade-up" data-aos-delay="100">

            <div class="row gy-4">
                <div class="col-lg-6">
                    <div class="info-item  d-flex flex-column justify-content-center align-items-center">
                        <i class="bi bi-map"></i>
                        <h3>Our Address</h3>
                        <p>Arravali Society Near Yogipuram Shinay</p>
                    </div>
                </div>
                <!-- End Info Item -->

                <div class="col-lg-3 col-md-6">
                    <div class="info-item d-flex flex-column justify-content-center align-items-center">
                        <i class="bi bi-envelope"></i>
                        <h3>Email Us</h3>
                        <p>contact@example.com</p>
                    </div>
                </div>
                <!-- End Info Item -->

                <div class="col-lg-3 col-md-6">
                    <div class="info-item  d-flex flex-column justify-content-center align-items-center">
                        <i class="bi bi-telephone"></i>
                        <h3>Call Us</h3>
                        <p>+91 9989334455</p>
                    </div>
                </div>
                <!-- End Info Item -->

            </div>

            <div class="row gy-4 mt-1">

                <div class="col-lg-6 ">
                    <iframe
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3671.254486288389!2d70.07139407501745!3d23.051129879153716!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3950b968fb4a051f%3A0x747e5f83b2bec829!2sShinay%2040%20township!5e0!3m2!1sen!2sin!4v1683960699591!5m2!1sen!2sin"
                        frameborder="0" style="border: 0; width: 100%; height: 479px;" allowfullscreen></iframe>
                </div>
                <!-- End Google Maps -->

                <div class="col-lg-6">
                    <div class="box" style="box-shadow: 0 0 25px rgba(0, 0, 0, 0.08); padding: 40px 70px; height: 480px">
                        <h3 class="heading">Contact Us</h3>
                        <%--  <form class="mb-5" method="post" id="contactForm" name="contactForm">
              <div class="row">
                
                <div class="col-md-12 form-group">
                  <label for="name" class="col-form-label">Name</label>
                  <input type="text" class="form-control" name="name" id="name" style="height:30px">
                </div>
              </div>
              <div class="row">
                <div class="col-md-12 form-group">
                  <label for="email" class="col-form-label">Email</label>
                  <input type="text" class="form-control" name="email" id="email"style="height:30px">
                </div>
              </div>
                 <div class="col-md-12 form-group">
                  <label for="Subject" class="col-form-label">Subject</label>
                  <input type="text" class="form-control" name="email" id="sub"style="height:30px">
                </div>
              
              <div class="row mb-3">
                <div class="col-md-12 form-group">
                  <label for="message" class="col-form-label">Message</label>
                  <textarea class="form-control" name="message" id="message" cols="30" rows="7" style="height: 60px;"></textarea>
                </div>
              </div>
              <div class="row">
                <div class="col-md-12">
                 <input type="submit" value="Send Message" class="btn btn-block btn-primary rounded-0 py-2 px-4" style="border-radius: 5px !important; background-color: #ccda46;     border-color: #ccda46;">
                  <span class="submitting"></span>
                </div>
              </div>
            </form>--%>
                        <asp:Panel runat="server" CssClass="mb-5">
                            <div class="row">
                                <div class="col-md-12 form-group">
                                    <label for="name" class="col-form-label">Name</label>
                                    <asp:TextBox runat="server" ID="name" CssClass="form-control" Height="30px" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 form-group">
                                    <label for="email" class="col-form-label">Email</label>
                                    <asp:TextBox runat="server" ID="email" CssClass="form-control" Height="30px" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 form-group">
                                    <label for="subject" class="col-form-label">Subject</label>
                                    <asp:TextBox runat="server" ID="subject" CssClass="form-control" Height="30px" />
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-12 form-group">
                                    <label for="message" class="col-form-label">Message</label>
                                    <asp:TextBox runat="server" ID="message" CssClass="form-control" Rows="7" TextMode="MultiLine" Height="60px" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <asp:Button runat="server" ID="submitBtn" CssClass="btn btn-block btn-primary rounded-0 py-2 px-4" Text="Send Message" Style="border-radius: 5px !important; background-color: #ccda46; border-color: #ccda46;" />
                                    <span class="submitting"></span>
                                </div>
                            </div>
                        </asp:Panel>


                    </div>
                    <!-- End Contact Form -->

                </div>

            </div>
    </section>

    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.validate.min.js"></script>
    <script src="js/main.js"></script>
</asp:Content>
