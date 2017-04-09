<%@ Page Language="C#" MasterPageFile="~/Site.Master" MaintainScrollPositionOnPostback="true" AutoEventWireup="true" CodeBehind="Company.aspx.cs" Inherits="WebApp.Company" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script lang="javascript" type="text/javascript">
        $(function () {
        $('#<%=txtSearchBox.ClientID%>').autocomplete({
            source: function (request, response) {
                op = $("#ddlOption option:selected").val();
                $.ajax({
                    url: "Company.aspx/SearchFor",
                    data: "{ 'pre':'" + request.term + "', 'option': " + op + "}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return { value: item }
                        }))
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert(textStatus);
                    }
                });
            }
        });
    });

</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-sm-9">
        <div class="row">
            <div class="col-sm-6 form-group">
                <asp:TextBox ID="txtSearchBox" CssClass="form-control" TabIndex="1" runat="server" />
            </div>
            <div class="col-sm-3 form-group">
                <asp:DropDownList CssClass="form-control" ID="ddlOption" ClientIDMode="Static" TabIndex="2" runat="server">
                    <asp:ListItem Value="1" Selected="True">Name</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-sm-3 form-group">
                <asp:Button ID="btnSelectedSearch" Text="Select" CssClass="btn btn-lg btn-info" TabIndex="3" runat="server" OnClick="btnSelectedSearch_Click" />
            </div>
        </div>
    </div>
    <div class="col-lg-12 well">
            <h4>Company Info</h4>
            <div class="row" style="font-size:large">
                    <div class="col-sm-12">
                        <div class="row">
                            <div class="col-sm-6 form-group">
                                <label>Name:</label>
                                <asp:HiddenField ID="HiddenCompanyId" runat="server" />
                                <asp:TextBox CssClass="form-control" ID="txtCompanyName" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtCompanyName" ValidationGroup="SubmitCompany" runat="server" />
                            </div>
                            <div class="col-sm-2 form-group">
                                <label>Type:</label>
                                <asp:DropDownList ID="ddlType" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="ddlType_SelectedIndexChanged" runat="server">
                                    <asp:ListItem Text="Customer" Selected="True" Value="Customer" />
                                    <asp:ListItem Text="Vendor" Value="Vendor" />
                                    <asp:ListItem Text="Customer+Vendor" Value="Both" />
                                    <asp:ListItem Text="Consignee" Value="Consignee" />
                                    <asp:ListItem Text="Supplier" Value="Supplier" />
                                    <asp:ListItem Text="Warehouse" Value="Warehouse" />
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="ddlType" ValidationGroup="SubmitCompany" runat="server" />
                            </div>
                        </div>
                        <div class="row">
                            <asp:PlaceHolder ID="PlaceHolder1" runat="server">
                            <div class="col-sm-3 form-group">
                                <label>Company Code:</label>
                                <asp:TextBox CssClass="form-control" ID="txtCode" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtCode" ValidationGroup="SubmitCompany" runat="server" />
                            </div>
                            <div class="col-sm-3 form-group">
                                <label>Federal No.</label>
                                <asp:TextBox CssClass="form-control" ID="txtFederalNum" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtFederalNum" ValidationGroup="SubmitCompany" runat="server" />
                            </div>
                            </asp:PlaceHolder>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 form-group">
                                <label>Address1:</label>
                                <asp:TextBox CssClass="form-control" ID="txtAddress1" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtAddress1" ValidationGroup="SubmitCompany" runat="server" />
                            </div>
                            <div class="col-sm-2 form-group">
                                <label>Address2:</label>
                                <asp:TextBox CssClass="form-control" ID="txtAddress2" ValidationGroup="SubmitCompany" runat="server" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-3 form-group">
                                <label>City:</label>
                                <asp:TextBox CssClass="form-control" ID="txtCity" Width="100%" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtCity" ValidationGroup="SubmitCompany" runat="server" />
                            </div>
                            <div class="col-sm-3 form-group">
                                <label>State:</label>
                                <asp:TextBox CssClass="form-control" ID="txtState" Width="100%" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtState" ValidationGroup="SubmitCompany" runat="server" />
                            </div>
                            <div class="col-sm-3 form-group">
                                <label>Zip Code:</label>
                                <asp:TextBox CssClass="form-control" ID="txtZip" Width="100%" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtZip" ValidationGroup="SubmitCompany" runat="server" />
                            </div>
                            <div class="col-sm-3 form-group">
                                <label>Country:</label>
                                <asp:TextBox CssClass="form-control" ID="txtCountry" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtCountry" ValidationGroup="SubmitCompany" runat="server" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 form-group">
                                <label>Phone:</label>
                                <asp:TextBox CssClass="form-control" ID="txtPhone" Width="50%" runat="server" />
                                <asp:RegularExpressionValidator runat="server" Display="Dynamic" ValidationExpression="([0-9]\-?)*" ControlToValidate="txtPhone" ValidationGroup="SubmitCompany" ForeColor="Red" ErrorMessage="Invalid Phone." />
                            </div>
                            <div class="col-sm-6 form-group">
                                <label>Email:</label>
                                <asp:TextBox CssClass="form-control" ID="txtEmail" runat="server" />
                                <asp:RegularExpressionValidator runat="server" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="txtEmail" ValidationGroup="SubmitCompany" ForeColor="Red" ErrorMessage="Invalid email address." />
                            </div>
                        </div>
                        <asp:Button Text="Submit" CssClass="btn btn-lg btn-info" TabIndex="15" runat="server" ValidationGroup="SubmitCompany" OnClick="AddNewCompany_Click" />
                    </div>
            </div>
        </div>
</asp:Content>
