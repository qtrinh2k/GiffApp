<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Company.aspx.cs" Inherits="WebApp.Company" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>New Company Info Page</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

    <div class="jumbotron text-center">
        <h1>General International Freight Forwarders, Inc.</h1>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <nav class="navbar navbar-default">
                    <div class="container-fluid">
                        <ul class="nav navbar-nav">
                            <li><a href="Index.aspx">Home</a></li>
                            <li><a href="Booking.aspx">Booking</a></li>
                            <li class="active"><a href="Management.apsx">Management</a></li>
                            <li><a href="Accounting.aspx">Accounting</a></li>
                        </ul>
                    </div>
                </nav>

            </div>
        </div>
        <div class="col-lg-12 well">
            <h4>New Company Info</h4>
            <div class="row">
                <form runat="server">
                    <div class="col-sm-12">
                        <div class="row">
                            <div class="col-sm-6 form-group">
                                <label>Name:</label>
                                <asp:TextBox CssClass="form-control" ID="txtCompanyName" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtCompanyName" runat="server" />
                            </div>
                            <div class="col-sm-2 form-group">
                                <label>Type:</label>
                                <asp:DropDownList ID="ddlType" CssClass="form-control" runat="server">
                                    <asp:ListItem Text="Vendor" Value="Vendor" />
                                    <asp:ListItem Text="Carrier" Value="Carrier" />
                                    <asp:ListItem Text="Both" Value="Both" />
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="ddlType" runat="server" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-3 form-group">
                                <label>Company Code:</label>
                                <asp:TextBox CssClass="form-control" ID="txtCode" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtCode" runat="server" />
                            </div>
                            <div class="col-sm-3 form-group">
                                <label>Federal No.</label>
                                <asp:TextBox CssClass="form-control" ID="txtFederalNum" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtFederalNum" runat="server" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 form-group">
                                <label>Address1:</label>
                                <asp:TextBox CssClass="form-control" ID="txtAddress1" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtAddress1" runat="server" />
                            </div>
                            <div class="col-sm-2 form-group">
                                <label>Address2:</label>
                                <asp:TextBox CssClass="form-control" ID="txtAddress2" runat="server" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-3 form-group">
                                <label>City:</label>
                                <asp:TextBox CssClass="form-control" ID="txtCity" Width="50%" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtCity" runat="server" />
                            </div>
                            <div class="col-sm-3 form-group">
                                <label>State:</label>
                                <asp:TextBox CssClass="form-control" ID="txtState" Width="50%" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtState" runat="server" />
                            </div>
                            <div class="col-sm-3 form-group">
                                <label>Zip Code:</label>
                                <asp:TextBox CssClass="form-control" ID="txtZip" Width="30%" runat="server" />
                                <asp:RegularExpressionValidator runat="server" Display="Dynamic" ValidationExpression="[0-9-]*" ControlToValidate="txtZip" ForeColor="Red" ErrorMessage="Invalid Zip code." />

                            </div>
                            <div class="col-sm-3 form-group">
                                <label>Country:</label>
                                <asp:TextBox CssClass="form-control" ID="txtCountry" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtCountry" runat="server" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 form-group">
                                <label>Phone:</label>
                                <asp:TextBox CssClass="form-control" ID="txtPhone" Width="50%" runat="server" />
                                <asp:RegularExpressionValidator runat="server" Display="Dynamic" ValidationExpression="([0-9]\-?)*" ControlToValidate="txtPhone" ForeColor="Red" ErrorMessage="Invalid Phone." />
                            </div>
                            <div class="col-sm-6 form-group">
                                <label>Email:</label>
                                <asp:TextBox CssClass="form-control" ID="txtEmail" runat="server" />
                                <asp:RegularExpressionValidator runat="server" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmail" ForeColor="Red" ErrorMessage="Invalid email address." />
                            </div>
                        </div>
                        <asp:Button Text="Submit" CssClass="btn btn-lg btn-info" TabIndex="15" runat="server" OnClick="AddNewCompany_Click" />
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
