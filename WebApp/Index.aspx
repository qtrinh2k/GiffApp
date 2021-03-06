﻿<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="WebApp.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <asp:Label ID="lbUser" Text="" runat="server"></asp:Label>
    </div>
    <div class="col-sm-9">
        <div class="row">
            <div class="col-sm-6 form-group">
                <asp:TextBox ID="txtSearchBox" CssClass="form-control" TabIndex="1" runat="server" />
            </div>
            <div class="col-sm-3 form-group">
                <asp:DropDownList CssClass="form-control" ID="DropDownList1" ClientIDMode="Static" TabIndex="2" runat="server">
                    <asp:ListItem Value="1" Text="GiffiRef" Selected="True">GIFFI Ref</asp:ListItem>
                    <asp:ListItem Value="2" Text="ShipperRefNo">ShipperRefNo</asp:ListItem>
                    <asp:ListItem Value="3" Text="CarrierRefNo">CarrierRefNo</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="col-sm-3 form-group">
                <asp:Button ID="btnSelectedSearch" Text="Search" CssClass="btn btn-lg btn-info" TabIndex="3" runat="server" OnClick="SelectedSearch_Click" />
            </div>
        </div>
    </div>
    <div class="row">
        <asp:GridView ID="gvIndex"
            DataKeyNames="BookingId"
            CssClass="table table-striped"
            AutoGenerateColumns="false"
            OnPageIndexChanging="gvIndex_PageIndexChanging"
            AllowPaging="true"
            AllowSorting="true"
            PageSize="10"
            OnDataBound="gvIndex_DataBound"
            runat="server">
            <PagerStyle BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="2px"  Font-Bold="true" Font-Size="Large" />
            <Columns>
                <asp:TemplateField HeaderText="GiffiRef" ItemStyle-Width="100px">
                    <ItemTemplate>                        
                        <asp:LinkButton ID="btlGiffiRef" OnClick="btlGiffiRef_Click"  runat="server" Text='<%# Eval("GiffiId") %>'></asp:LinkButton> 
                        <asp:HiddenField ID="hiddenBookingId" Value='<%# Eval("BookingId") %>' runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="BillTo" ItemStyle-Width="40px">
                    <ItemTemplate>
                        <asp:Label ID="lblBillTo" runat="server" Text='<%# Eval("BillTo") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ShipperRef" ItemStyle-Width="40px">
                    <ItemTemplate>
                        <asp:Label ID="lblShipperRef" runat="server" Text='<%# Eval("ShipperRefNo") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Carrier" ItemStyle-Width="40px">
                    <ItemTemplate>
                        <asp:Label ID="lblBS" runat="server" Text='<%# Eval("CarrierCode") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="CarrierRef" ItemStyle-Width="40px">
                    <ItemTemplate>
                        <asp:Label ID="lblCarrierRef" runat="server" Text='<%# Eval("CarrierRefNo") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Discharge" ItemStyle-Width="40px">
                    <ItemTemplate>
                        <asp:Label ID="lblDischarge" runat="server" Text='<%# Eval("Discharge") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Destination" ItemStyle-Width="40px">
                    <ItemTemplate>
                        <asp:Label ID="lblDestination" runat="server" Text='<%# Eval("Destination") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="CutOffDate" ItemStyle-Width="40px">
                    <ItemTemplate>
                        <asp:Label ID="lblCutOffDate" runat="server" Text='<%# Eval("CutOffDate") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="LastModified" ItemStyle-Width="40px">
                    <ItemTemplate>
                        <asp:Label ID="lblLastModified" runat="server" Text='<%# Eval("ModifiedTime") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Status" ItemStyle-Width="40px">
                    <ItemTemplate>
                        <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
