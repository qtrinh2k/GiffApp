<%@ Page Title="Certificate Of Origin" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CertOfOrigin.aspx.cs" Inherits="WebApp.CertOfOrigin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-lg-12" style="font-size: large; border-width: 0px">
            <table class="table table-bordered">
                <tr>
                    <td rowspan="2">
                        <label class="small">Shipper/Expoter:</label><br />
                        <asp:Label ID="lblShipper" runat="server"></asp:Label>
                    </td>
                    <td>
                        <div class="form-group col-sm-6">
                            <label class="small">Booking No:</label><br />
                            <asp:Label ID="lblBookingNo" runat="server"></asp:Label>
                        </div>
                        <div class="form-group col-sm-6">
                            <label class="small">B/L No:</label><br />
                            <asp:Label ID="lblBLNo" runat="server"></asp:Label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="small">Certificate No:</label><br />
                        <asp:Label ID="lblCertificateNo" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-group">
                            <label class="small">Consignee: </label>
                            <br />
                            <asp:DropDownList ID="ddlConsigneeSearch" CssClass="form-control" Width="35%" runat="server"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="tbxConsigneeAddress" CssClass="form-control" Width="65%" TextMode="MultiLine" runat="server" />
                        </div>
                    </td>
                    <td>
                        <label class="small">Exports Ref: </label>
                        <br />
                        <label class="small">Exports Ref: </label>
                        <asp:Label ID="lblGiffiRef" CssClass="label-default" runat="server"></asp:Label>
                        <hr />
                        <label class="small">Shippers Ref:</label>
                        <asp:Label ID="lblShipperRef" CssClass="label-default" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
