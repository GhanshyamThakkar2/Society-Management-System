<%@ Page Title="" Language="C#" MasterPageFile="~/Main_Master.Master" AutoEventWireup="true" CodeBehind="About_Us.aspx.cs" Inherits="Society_Management_System.About_Us" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <main id="main">

        <!-- ======= Breadcrumbs ======= -->
        <div class="breadcrumbs d-flex align-items-center" style="background-image: url('admin/images/SIENA%20PHOTOS/10..png');">
            <div class="container position-relative d-flex flex-column align-items-center" data-aos="fade">

                <h2>About</h2>
                <ol>
                    <li><a href="Home.aspx">Home</a></li>
                    <li>About</li>
                </ol>

            </div>
        </div>
        <!-- End Breadcrumbs -->

        <!-- ======= About Section ======= -->
        <section id="about" class="about">
            <div class="container" data-aos="fade-up">

                <div class="row position-relative">

                    <div class="col-lg-7 about-img" style="background-image: url('admin/images/SIENA PHOTOS/04..png');"></div>

                    <div class="col-lg-7">
                        <h2>Arravali Society</h2>
                        <div class="our-story">
                            <h4>Est 2021</h4>
                            <h3>Our Story</h3>
                            <p>The Aravalli Society is more than just a place to live; it is a home where you can build lifelong friendships, create memories, and make a positive impact in the world. We invite you to join us and become part of our community today.</p>
                            <ul>
                                <li><i class="bi bi-check-circle"></i><span>Strives to create a safe, supportive, and nurturing environment for all.</span></li>
                                <li><i class="bi bi-check-circle"></i><span>Provides a home where residents can build lifelong friendships, create memories, and make a positive impact in the world.</span></li>
                            </ul>
                            <p>At the heart of the Aravalli Society is our commitment to building strong relationships among our residents.</p>

                            <div class="watch-video d-flex align-items-center position-relative">
                                <i class="bi bi-play-circle"></i>
                                <a href="https://youtu.be/r51cYVZWKdY" class="glightbox stretched-link">Watch Video</a>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </section>
        <!-- End About Section -->

        <!-- ======= Stats Counter Section ======= -->
        <section id="stats-counter" class="stats-counter section-bg">
            <div class="container">

                <div class="row gy-4">

                    <div class="col-lg-3 col-md-6">
                        <div class="stats-item d-flex align-items-center w-100 h-100">
                            <i class="bi bi-emoji-smile color-blue flex-shrink-0"></i>
                            <div>
                                <span data-purecounter-start="0" data-purecounter-end="232" data-purecounter-duration="1"
                                    class="purecounter"></span>
                                <p>Total Houses</p>
                            </div>
                        </div>
                    </div>
                    <!-- End Stats Item -->

                    <div class="col-lg-3 col-md-6">
                        <div class="stats-item d-flex align-items-center w-100 h-100">
                            <i class="bi bi-journal-richtext color-orange flex-shrink-0"></i>
                            <div>
                                <span data-purecounter-start="0" data-purecounter-end="521" data-purecounter-duration="1"
                                    class="purecounter"></span>
                                <p>Selled Houses</p>
                            </div>
                        </div>
                    </div>
                    <!-- End Stats Item -->

                    <div class="col-lg-3 col-md-6">
                        <div class="stats-item d-flex align-items-center w-100 h-100">
                            <i class="bi bi-headset color-green flex-shrink-0"></i>
                            <div>
                                <span data-purecounter-start="0" data-purecounter-end="3" data-purecounter-duration="1"
                                    class="purecounter"></span>
                                <p>Departments</p>
                            </div>
                        </div>
                    </div>
                    <!-- End Stats Item -->

                    <div class="col-lg-3 col-md-6">
                        <div class="stats-item d-flex align-items-center w-100 h-100">
                            <i class="bi bi-people color-pink flex-shrink-0"></i>
                            <div>
                                <span data-purecounter-start="0" data-purecounter-end="15" data-purecounter-duration="1"
                                    class="purecounter"></span>
                                <p>Residents</p>
                            </div>
                        </div>
                    </div>
                    <!-- End Stats Item -->

                </div>

            </div>
        </section>
        <!-- End Stats Counter Section -->

        <!-- ======= Alt Services Section ======= -->

        <!-- ======= Our Team Section ======= -->
        <!-- End Our Team Section -->

        <!-- ======= Testimonials Section ======= -->

    </main>
    <!-- End #main -->
</asp:Content>
