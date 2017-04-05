<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="WebApp.SignUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script src="Scripts/jquery-3.1.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="main col-xs-10 col-sm-7 col-md-4 col-lg-4">

            <div class="form-group">
                <label class="control-label col-sm-3" for="email">Name:</label>
                <div class="col-sm-9 col-md-9 col-lg-9">

                    <asp:TextBox ID="txtUsername" CssClass="form-control" TabIndex="1" runat="server" />
                    <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtUsername" runat="server" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-3" for="email">Email:</label>
                <div class="col-sm-9 col-md-9 col-lg-9">
                    <asp:TextBox ID="txtEmail" CssClass="form-control" TabIndex="2" runat="server" />
                    <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtEmail" runat="server" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-3" for="pwd">Password:</label>
                <div class="col-sm-9 col-md-9 col-lg-9">

                    <asp:TextBox ID="txtPassword" TextMode="Password" CssClass="form-control" TabIndex="3" runat="server" />
                    <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtPassword" runat="server" />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-3" for="pwd">Confirm Password:</label>
                <div class="col-sm-9 col-md-9 col-lg-9">
                    <asp:TextBox ID="txtConfirmed" TextMode="Password" CssClass="form-control" TabIndex="4" runat="server" />
                    <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtConfirmed" runat="server" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-3 col-sm-6">
                    <asp:Button ID="btnSubmit" Text="Register" TabIndex="5" CssClass="btn btn-lg btn-info" runat="server" OnClick="Submit_SignUp" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
