<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Foodie.User.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .menu-link {
            font-weight: bold !important; 
            font-size: 18px !important;
            color: #333 !important;
            text-decoration: none !important; 
        }

            .menu-link:hover {
                color: #FFC107 !important; 
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- about section -->

    <section class="about_section layout_padding">
        <div class="container  ">

            <div class="row">
                <div class="col-md-6 ">
                    <div class="img-box">
                        <img src="../TemplateFiles/images/about-img.png" alt="">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="detail-box">
                        <div class="heading_container">
                            <h2>We Are Foodie
              </h2>
                        </div>
                        <p>
                            Foodie Haven’s Fast Food Ordering System revolutionizes fast-food delivery with an intuitive online platform tailored to fast-food enthusiasts.
              It streamlines the ordering process, reducing wait times and improving convenience. Simple, fast, and hassle-free—get your food when and how you want it.
              Just simply browse the menu, customize your orders, and place them for pickup or delivery with just a few clicks.
           
                        </p>
                        <a href="Menu.aspx" class="menu-link">Check Out our Menu!
            </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- end about section -->

</asp:Content>
