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
</head>
<body>
    <div class="container">
        <div class="jumbotron text-center">
            <h1>General International Freight Forwarders, Inc.</h1>
        </div>
        <form id="formLogin" class="form-horizontal" runat="server">
            <asp:Login ID="userLogin" OnAuthenticate="userLogin_Authenticate" DestinationPageUrl="~/Index.aspx" runat="server">
                <LayoutTemplate>
                    <table>
                        <tr>
                            <td colspan="2">
                                <h3>Login</h3>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <tr style="vertical-align: middle">
                                        <td>
                                            <label class="control-label col-sm-4" for="email">UserName:</label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="UserName" CssClass="form-control" runat="server"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" Text="*"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr style="vertical-align: middle">
                                        <td>
                                            <label class="control-label col-sm-4" for="password">Password:</label></td>
                                        <td>
                                            <asp:TextBox ID="Password" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" Text="*"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:CheckBox ID="RememberMe" runat="server" Text="Remember my login"></asp:CheckBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="list-group">
                                <ul>
                                    <li><a href="SignUp.aspx">Create a new account...</a></li>
                                    <li><a href="getPass.aspx">Forgot your password?</a></li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="align-content: center">
                                <asp:Button ID="Login" CommandName="Login" runat="server" Text="Login"></asp:Button>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="align-content: center">
                                <asp:Literal ID="FailureText" runat="server"></asp:Literal></td>
                        </tr>
                    </table>
                </LayoutTemplate>
            </asp:Login>
        </form>
    </div>
</body>
</html>
