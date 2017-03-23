<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="WebApp.SignUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script src="Scripts/jquery-3.1.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <%--<style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
        input[type=text], input[type=password]
        {
            width: 200px;
        }
        table
        {
            border: 1px solid #ccc;
            width: 300px;
        }
        table th
        {
            background-color: #F7F7F7;
            color: #333;
            font-weight: bold;
        }
        table th, table td
        {
            padding: 5px;
            border-color: #ccc;
        }

        label{
            text-align:right;
        }
    </style>--%>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="main col-xs-10 col-sm-7 col-md-4 col-lg-4">

            <div class="form-group">
                <label class="control-label col-sm-3" for="email">Name:</label>
                <div class="col-sm-9 col-md-9 col-lg-9">

                    <asp:TextBox ID="txtUsername" CssClass="form-control" TabIndex="-1" runat="server" />
                    <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtUsername" runat="server" />
                </div>
            </div>

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

                    <asp:Button ID="btnSubmit" Text="Register" CssClass="btn btn-lg btn-info" runat="server" OnClick="Submit_SignUp" />
                </div>
            </div>
        </div>
    </div>
    <%--<div>
     <table>
        <tr>
            <th colspan="3">Sign up</th>
        </tr>       
        <tr>
            <td>
                <label>UserName: </label>
            </td>
            <td>
                <asp:TextBox ID="txtUsername" CssClass="form-control" TabIndex="-1" runat="server" />
                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtUsername" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <label>Password: </label>
            </td>
            <td>
                <asp:TextBox ID="txtPassword" CssClass="form-control" TabIndex="-1" runat="server" />
                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtPassword" runat="server" />

            </td>
        </tr>
        <tr>
            <td>
                <label>Confirmed: </label>
            </td>
            <td>
                <asp:TextBox ID="txtConfirmed" CssClass="form-control" TabIndex="-1" runat="server" />
                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtConfirmed" runat="server" />

            </td>
        </tr>
        <tr>
            <td>
                <label>Email: </label>
            </td>
            <td>                
                <asp:TextBox ID="txtEmail" CssClass="form-control" TabIndex="-1" runat="server" />
                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtEmail" runat="server" />

            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnSubmit" Text="Submit" CssClass="btn btn-lg btn-info" TabIndex="22" runat="server" OnClick="Submit_SignUp" />
            </td>
        </tr>
    </table>
    </div>--%>
</asp:Content>
