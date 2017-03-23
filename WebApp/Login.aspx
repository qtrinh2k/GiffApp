<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApp.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="Content/bootstrap.min.css" />
    <link rel="stylesheet" href="Content/bootstrap-theme.min.css" />

    <script src="Scripts/jquery-3.1.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <style>
        .main {
            position: absolute;
            left: 30%;
            top: 30%;
            transform: translate(-50%,0%);
            -ms-transform: translate(-50%,0%);
        }

        form {
            margin-top: 50px;
        }

        p {
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="jumbotron text-center">
        <h1>General International Freight Forwarders, Inc.</h1>
    </div>
    <form id="formLogin" runat="server">
        <div class="container">
            <div class="row">
                <asp:Login ID="userLogin" OnAuthenticate="userLogin_Authenticate" DestinationPageUrl="~/Index.aspx" runat="server">
                    <LayoutTemplate>
                        <div class="row">
                            <div class="main col-xs-10 col-sm-7 col-md-4 col-lg-4">
                                <div class="form-group">

                                    <label class="control-label col-sm-3" for="email">Username:</label>
                                    <div class="col-sm-9 col-md-9 col-lg-9">
                                        <asp:TextBox CssClass="form-control" ID="UserName" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="userLogin">*</asp:RequiredFieldValidator>

                                    </div>
                                </div>
                                <div class="form-group">

                                    <label class="control-label col-sm-3" for="pwd">Password:</label>
                                    <div class="col-sm-9 col-md-9 col-lg-9">
                                        <asp:TextBox ID="Password" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="userLogin">*</asp:RequiredFieldValidator>

                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-3 col-sm-6">
                                        <div class="checkbox">
                                            <label>
                                                <asp:CheckBox ID="RememberMe" runat="server" />
                                                Remember me</label>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-3 col-sm-6">
                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-offset-3 col-sm-6">
                                        <asp:Button CssClass="btn btn-default" ID="LoginButton" runat="server" CommandName="Login" Text="Log In" ValidationGroup="userLogin" />
                                    </div>
                                </div>
                                <%--<div>
                                    <ul class="nav nav-tabs">
                                        <li class="active"><a href="#login" data-toggle="tab">Login</a></li>
                                        <li><a href="#signup" data-toggle="tab">Sign Up</a></li>
                                        <li><a href="#forgotpassword" data-toggle="tab">Forgot password</a></li>
                                    </ul>
                                </div>

                                <div class="tab-content">

                                    <div class=" tab-pane fade in active" id="login">

                                            <div class="form-group">

                                                <label class="control-label col-sm-3" for="email">Username:</label>
                                                <div class="col-sm-9 col-md-9 col-lg-9">
                                                    <asp:TextBox CssClass="form-control" ID="UserName" runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="UserName" ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="userLogin">*</asp:RequiredFieldValidator>

                                                </div>
                                            </div>
                                            <div class="form-group">

                                                <label class="control-label col-sm-3" for="pwd">Password:</label>
                                                <div class="col-sm-9 col-md-9 col-lg-9">
                                                    <asp:TextBox ID="Password" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="userLogin">*</asp:RequiredFieldValidator>

                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-sm-offset-3 col-sm-6">
                                                    <div class="checkbox">
                                                        <label>
                                                            <asp:CheckBox ID="RememberMe" runat="server" />
                                                            Remember me</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-sm-offset-3 col-sm-6">
                                                    <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-sm-offset-3 col-sm-6">
                                                    <asp:Button CssClass="btn btn-default" ID="LoginButton" runat="server" CommandName="Login" Text="Log In" ValidationGroup="userLogin" />
                                                </div>
                                            </div>
                                    </div>


                                    <div class="tab-pane fade" id="signup">

                                            <div class="form-group">
                                                <label class="control-label col-sm-3" for="email">Name:</label>
                                                <div class="col-sm-9 col-md-9 col-lg-9">

                <asp:TextBox ID="txtUsername" CssClass="form-control" TabIndex="-1" runat="server" />
                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtUsername" runat="server" />
                                                </div>
                                            </div>
                                            <form class="form-horizontal">
                                                <div class="form-group">
                                                    <label class="control-label col-sm-3" for="email">Email:</label>
                                                    <div class="col-sm-9 col-md-9 col-lg-9">
                                                                        <asp:TextBox ID="txtEmail" CssClass="form-control" TabIndex="-1" runat="server" />
                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtEmail" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-sm-3" for="pwd">Password:</label>
                                                    <div class="col-sm-9 col-md-9 col-lg-9">
                                                                        <asp:TextBox ID="txtPassword" CssClass="form-control" TabIndex="-1" runat="server" />
                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtPassword" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-sm-3" for="pwd">Confirm Password:</label>
                                                    <div class="col-sm-9 col-md-9 col-lg-9">
                <asp:TextBox ID="txtConfirmed" CssClass="form-control" TabIndex="-1" runat="server" />
                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtConfirmed" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <div class="col-sm-offset-3 col-sm-6">

<asp:Button ID="btnSubmit" Text="Register" CssClass="btn btn-lg btn-info" runat="server" OnClick="btnSubmit_Click" />
                                                    </div>
                                                </div>

                                    </div>

                                    <div class="tab-pane fade" id="forgotpassword">

                                            <p>Forgot password? Its okay we got you covered. Enter your Email ID and we'll send you a link to reset your password.</p>
                                            <div class="form-group">

                                                <div class="col-lg-12">
                                                    <input type="email" class="form-control" id="email" placeholder="Enter Email">
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <div class="col-sm-offset-4 col-sm-12">

<asp:Button ID="btnReset" Text="Reset Password" CssClass="btn btn-lg btn-info" runat="server" OnClick="Submit_SignUp" />
                                                </div>
                                            </div>

                                    </div>

                                </div>--%>

                            </div>
                        </div>
                    </LayoutTemplate>
                </asp:Login>
            </div>
        </div>
    </form>
</body>
</html>
