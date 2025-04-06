<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Foodie.User.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .error-message {
            color: red;
        }

        .heading_container {
            margin-bottom: 30px;
            text-align: center;
        }

        .form_container {
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .btn_box {
            display: flex;
            justify-content: flex-start;
            gap: 6px;
        }

        .form-control {
            width: 100%;
        }

        .btn {
            text-align: center;
            display: inline-flex;
            justify-content: center;
            align-items: center;
            min-width: 100px;
            max-width: 120px;
            padding: 6px 8px;
            font-weight: bold;
        }

        .img-thumbnail {
            border: none;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            max-width: 120%;
            height: auto;
        }

        /*.login-title {
            font-weight: bold;
            font-size: 24px;
            text-align: center;
            color: #333;
        }*/
    </style>
    <script>
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label runat="server" ID="lblMsg"></asp:Label>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">
                        <img id="userLogin" src="../Images/login.png" alt="" class="img-thumbnail" />
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form_container">
                        <!-- Move Login text here -->
                        <h2 class="login-title">Login</h2>

                        <div>
                            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ErrorMessage="Username is required!"
                                ControlToValidate="txtUsername" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter Username"></asp:TextBox>
                        </div>
                        <div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Password is required!"
                                ControlToValidate="txtPassword" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Enter Password" TextMode="Password"></asp:TextBox>
                        </div>
                        <div class="btn_box">
                            <!-- Smaller Login Button -->
                            <asp:Button ID="btnLogin" runat="server" Text="Login"
                                CssClass="btn btn-success btn-sm rounded-pill px-3 py-1 text-white fw-bold"
                                OnClick="btnLogin_Click" />

                            <!-- Smaller Register Button with Different Background -->
                            <a href="Registration.aspx" class="btn btn-primary btn-sm rounded-pill px-3 py-1 text-white fw-bold ml-2">Register Here..
                            </a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
