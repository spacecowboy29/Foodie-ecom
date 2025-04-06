<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="OrderStatus.aspx.cs" Inherits="Foodie.Admin.OrderStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
    <style>
        .table-plus {
            cursor: pointer;
        }

        .details-row {
            display: none;
        }

            .details-row.active {
                display: table-row;
            }

        .badge-success {
            background-color: green;
        }

        .badge-warning {
            background-color: orange;
        }

        .badge-primary {
            background-color: blue;
        }

        .toggle-button {
            display: inline-block;
            width: 30px;
            height: 30px;
            line-height: 30px;
            border-radius: 5%;
            background-color: skyblue;
            color: white;
            text-align: center;
            cursor: pointer;
            border: none;
            font-size: 20px;
            font-weight: bold;
        }

            .toggle-button:hover {
                background-color: skyblue;
            }
    </style>
    <script>
        function toggleDetails(rowId, button) {
            var detailsRow = document.getElementById(rowId);
            if (detailsRow.classList.contains("active")) {
                detailsRow.classList.remove("active");
                button.innerText = "+";
            } else {
                // Hide all other active rows
                var activeRows = document.querySelectorAll('.details-row.active');
                activeRows.forEach(function (row) {
                    row.classList.remove('active');
                });
                // Set the button text to "+" for all other buttons
                var toggleButtons = document.querySelectorAll('.toggle-button');
                toggleButtons.forEach(function (btn) {
                    if (btn !== button) {
                        btn.innerText = "+";
                    }
                });

                detailsRow.classList.add("active");
                button.innerText = "-";
            }
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pcoded-inner-content pt-0">
        <div class="align-align-self-end">
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        </div>

        <div class="main-body">
            <div class="page-wrapper">
                <div class="page-body">
                    <ul class="nav nav-tabs">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#openOrders">Open Orders</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#completedOrders">Completed Orders</a>
                        </li>
                    </ul>

                    <div class="tab-content">
                        <div id="openOrders" class="tab-pane active">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="card">
                                        <div class="card-header"></div>
                                        <div class="card-block">
                                            <div class="row">
                                                <div class="col-sm-6 col-md-8 col-lg-8 mobile-inputs">
                                                    <h4 class="sub-title">List of Orders</h4>
                                                    <div>
                                                        <div class="card-block table-border-style">
                                                            <div class="table-responsive">
                                                                <asp:Label ID="lblNoPendingOrders" runat="server" Text="No pending orders available." Visible="false"></asp:Label>

                                                                <asp:Repeater ID="rOrderStatus" runat="server" OnItemCommand="rOrderStatus_ItemCommand">
                                                                    <HeaderTemplate>
                                                                        <table class="table data-table-export table-hover nowrap">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th></th>
                                                                                    <th>Order No.</th>
                                                                                    <th>Order Date</th>
                                                                                    <th>Status</th>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr>
                                                                            <td>
                                                                                <button type="button" class="toggle-button" onclick="toggleDetails('details-<%# Eval("OrderDetailsId") %>', this)">+</button>
                                                                            </td>
                                                                            <td><%# Eval("OrderNo") %></td>
                                                                            <td><%# Eval("OrderDate") %></td>
                                                                            <td>
                                                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>' CssClass='<%# Eval("Status").ToString() == "Delivered" ? "badge badge-success" : "badge badge-warning"%>'></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr id="details-<%# Eval("OrderDetailsId") %>" class="details-row">
                                                                            <td colspan="4">
                                                                                <div><strong>Name: </strong><%# Eval("Name") %></div>
                                                                                <div><strong>Price: </strong><%# Eval("TotalPrice") %></div>
                                                                                <div><strong>Payment Mode: </strong><%# Eval("PaymentMode") %></div>
                                                                                <div>
                                                                                    <strong>Update Order Status:</strong>
                                                                                    <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CommandName="edit" CssClass="badge badge-primary" CommandArgument='<%# Eval("OrderDetailsId") %>'>
                                                                                    <i class="ti-pencil"></i>
                                                                                    </asp:LinkButton>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <FooterTemplate>
                                                                        </tbody>
                                                                        </table>
                                                                    </FooterTemplate>
                                                                </asp:Repeater>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-sm-6 col-md-4 col-lg-4 mobile-inputs">
                                                    <asp:Panel ID="pUpdateOrderStatus" runat="server">
                                                        <h4 class="sub-title">Update Status </h4>
                                                        <div>
                                                            <div class="form-group">
                                                                <label>Order Status: </label>
                                                                <div>
                                                                    <asp:DropDownList ID="ddlOrderStatus" runat="server" CssClass="form-control">
                                                                        <asp:ListItem Value="0">Select Status</asp:ListItem>
                                                                        <asp:ListItem>Pending</asp:ListItem>
                                                                        <asp:ListItem>Dispatched</asp:ListItem>
                                                                        <asp:ListItem>Delivered</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="rfvDdlOrderStatus" runat="server" ForeColor="Red" ControlToValidate="ddlOrderStatus" ErrorMessage="Order Status is Required!" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                                                    <asp:HiddenField ID="hdnId" runat="server" Value="0" />
                                                                </div>
                                                            </div>

                                                            <div class="pb-5">
                                                                <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary" OnClick="btnUpdate_Click" />
                                                                &nbsp;
                                                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-primary" OnClick="btnCancel_Click" />
                                                            </div>
                                                        </div>
                                                    </asp:Panel>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div id="completedOrders" class="tab-pane">
                            <div class="row">

                                <!-- Statestics Start -->
                                <div class="col-sm-12">
                                    <div class="card">
                                        <div class="card-header">
                                        </div>

                                        <div class="card-block">
                                            <div class="row">

                                                <div class="col-sm-12 mobile-inputs">

                                                    <h4 class="sub-title">User List</h4>

                                                    <div>
                                                        <div class="card-block table-border-style">
                                                            <div class="table-responsive">

                                                                <asp:Label ID="lblNoCompletedOrders" runat="server" Text="No completed orders available." Visible="false"></asp:Label>

                                                                <asp:Repeater ID="rCompletedOrders" runat="server">
                                                                    <HeaderTemplate>
                                                                        <table class="table data-table-export table-hoveer nowrap">
                                                                            <thead>
                                                                                <tr>
                                                                                    <th class="table-plus">Order Number</th>
                                                                                    <th>OrderDate</th>
                                                                                    <th class="datatable-nosort">Status</th>
                                                                                </tr>
                                                                            </thead>

                                                                            <tbody>
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <tr>
                                                                            <td class="table-plus"><%# Eval("OrderNo") %></td>

                                                                            <td>
                                                                                <%# Eval("OrderDate") %>
                                                                            </td>
                                                                            <td>
                                                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>' CssClass='<%# Eval("Status").ToString() == "Delivered" ? "badge badge-success" : "badge badge-warning"%>'></asp:Label>
                                                                            </td>

                                                                        </tr>
                                                                    </ItemTemplate>
                                                                    <FooterTemplate>
                                                                        </tbody>
                                                                        </table>
                                                                    </FooterTemplate>
                                                                </asp:Repeater>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>


                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="styleSelector"></div>
            </div>
        </div>
    </div>

</asp:Content>
