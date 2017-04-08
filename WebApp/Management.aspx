<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Management.aspx.cs" Inherits="WebApp.Management" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
    <div class="col-sm-3">
        <div class="panel panel-default">
            <div class="panel-heading"><a href="Company.aspx">Add Company</a></div>
            <div class="panel-heading">Update Accounting Code</div>
        </div>
    </div>
</div>
    <div class="row">
        <asp:GridView ID="gvMgmt"
            DataKeyNames="Id" AutoGenerateColumns="false"
            CssClass="table table-striped"
            runat="server">
            <Columns>
                <asp:TemplateField HeaderText="Name" ItemStyle-Width="100px">
                    <ItemTemplate>                        
                        <asp:LinkButton ID="btnName" OnClick="btnName_Click"  runat="server" Text='<%# Eval("CompanyName") %>'></asp:LinkButton> 
                        <asp:HiddenField ID="hiddenCompanyId" Value='<%# Eval("Id") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Code">
                    <ItemTemplate>
                        <asp:Label ID="lblCode" runat="server" Text='<%# Eval("Code") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="FederalNo">
                    <ItemTemplate>
                        <asp:Label ID="lblFederalNo" runat="server" Text='<%# Eval("FederalNumber") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="CompanyType">
                    <ItemTemplate>
                        <asp:Label ID="lblCompanyType" runat="server" Text='<%# Eval("CompanyType") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Address">
                    <ItemTemplate>
                        <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="City">
                    <ItemTemplate>
                        <asp:Label ID="lblCity" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="State">
                    <ItemTemplate>
                        <asp:Label ID="lblState" runat="server" Text='<%# Eval("State") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Phone">
                    <ItemTemplate>
                        <asp:Label ID="lblPhone" runat="server" Text='<%# Eval("Phone") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

