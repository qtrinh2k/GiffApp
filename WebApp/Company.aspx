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
            <div class="col-sm-3">
                <div class="panel panel-default">
                    <div class="panel-heading">New Company</div>
                    <div class="panel-heading"><a href="Carrier.aspx">Add Carrier</a></div>
                </div>
            </div>
            <div class="col-sm-9">
                <form class="form-horizontal">
                    <div class="form-group">
                        <div class="col-sm-6">
                        <input type="text" class="form-control" id="search" />
                        </div>
                        <button type="submit" class="btn btn-default">Search</button>
                    </div>
                </form>
            </div>

            <div class="col-sm-9">
                <div class="panel panel-primary">
                    <div class="panel-heading">Add New Entry</div>
                    <div class="panel-body">
                        <h4>Company Name and Address:</h4>
                        <form class="form-horizontal" runat="server">
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="company">Name</label>
                                <div class="col-sm-6">
                                    <asp:TextBox class="form-control" id="txtCompanyName" runat="server"/>
                                    <asp:RequiredFieldValidator ErrorMessage ="Required" Forecolor="Red" ControlToValidate="txtCompanyName" runat="server" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="address">Address1</label>
                                <div class="col-sm-6">
                                    <asp:TextBox class="form-control" id="txtAddress1" runat="server"/>
                                    <asp:RequiredFieldValidator ErrorMessage ="Required" Forecolor="Red" ControlToValidate="txtAddress1" runat="server" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="address2">Address2</label>
                                <div class="col-sm-6">
                                    <asp:TextBox class="form-control" id="txtAddress2" runat="server"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="city">City</label>
                                <div class="col-sm-2">
                                    <asp:TextBox class="form-control" id="txtCity" runat="server"/>
                                    <asp:RequiredFieldValidator ErrorMessage ="Required" Forecolor="Red" ControlToValidate="txtCity" runat="server" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="state">State</label>
                                <div class="col-sm-2">
                                    <asp:TextBox class="form-control" id="txtState" runat="server"/>
                                    <asp:RequiredFieldValidator ErrorMessage ="Required" Forecolor="Red" ControlToValidate="txtState" runat="server" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="zip">Zip Code</label>
                                <div class="col-sm-2">
                                    <asp:TextBox class="form-control" id="txtZip" runat="server"/>
                                    <asp:RegularExpressionValidator runat="server" Display="Dynamic" ValidationExpression="[0-9-]*" ControlToValidate="txtZip" ForeColor="Red" ErrorMessage="Invalid Zip code." />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="country">Country</label>
                                <div class="col-sm-2">
                                    <asp:TextBox class="form-control" id="txtCountry" runat="server"/>
                                    <asp:RequiredFieldValidator ErrorMessage ="Required" Forecolor="Red" ControlToValidate="txtCountry" runat="server" />
                                </div>
                            </div>     
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="phone">Phone</label>
                                <div class="col-sm-3">
                                    <asp:TextBox class="form-control" id="txtPhone" runat="server"/>
                                    <asp:RegularExpressionValidator runat="server" Display="Dynamic" ValidationExpression="([0-9]\-?)*" ControlToValidate="txtPhone" ForeColor="Red" ErrorMessage="Invalid Phone." />
                                </div>
                            </div>                                                   
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="email">Email</label>
                                <div class="col-sm-6">
                                    <asp:TextBox class="form-control" id="txtEmail" runat="server"/>
                                    <asp:RegularExpressionValidator runat="server" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmail" ForeColor="Red" ErrorMessage="Invalid email address." />
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <asp:Button Text="Submit" class="btn btn-default" runat="server" OnClick="AddNewCompany_Click" />
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>

</body>
</html>
