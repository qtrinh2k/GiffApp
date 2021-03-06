﻿<%@ Page Title="Bill Of Landing" Language="C#" MasterPageFile="~/Site.Master" MaintainScrollPositionOnPostback="true" AutoEventWireup="true" CodeBehind="BillOfLanding.aspx.cs" Inherits="WebApp.BillOfLanding" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script lang="javascript" type="text/javascript">
        $(function () {
            $('#<%=txtSearchBox.ClientID%>').autocomplete({
                source: function (request, response) {
                    op = $("#ddlSearchOption option:selected").val();
                    $.ajax({
                        url: "BillOfLanding.aspx/SearchBy",
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
    <style>
        .panel-body .label {
            display: inline-block;
            padding-top: 0;
            padding-bottom: 0;
            line-height: 1.5em;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-sm-3 form-group">
            <asp:TextBox ID="txtSearchBox" CssClass="form-control" TabIndex="1" runat="server" />
            <asp:HiddenField ID="hfSearchBookingId" runat="server" />
            <asp:HiddenField ID="hfBOLId" runat="server" />
        </div>
        <div class="col-sm-3 form-group">
            <asp:DropDownList CssClass="form-control" ID="ddlSearchOption" ClientIDMode="Static" TabIndex="2" runat="server">
                <asp:ListItem Value="1" Text="GiffiRef" Selected="True">GIFFI Ref</asp:ListItem>
                <asp:ListItem Value="2" Text="ShipperRefNo">ShipperRefNo</asp:ListItem>
                <asp:ListItem Value="3" Text="CarrierRefNo">CarrierRefNo</asp:ListItem>
                <asp:ListItem Value="4" Text="BilOfLandingRefNo">BLRefNo</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-sm-3 form-group">
            <asp:Button ID="btnSelectedSearch" Text="Select" CssClass="btn btn-lg btn-info" TabIndex="3" runat="server" OnClick="btnSelectedSearch_Click" />
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12" style="font-size: large; border-width: 0px">
            <table class="table table-bordered">
                <tr>
                    <td rowspan="2">
                        <label class="small">Shipper:</label><br />
                        <asp:Label ID="lblShipper" runat="server"></asp:Label>
                    </td>
                    <td>
                        <div class="row">
                            <div class="form-group col-sm-6">
                                <label class="small">Carrier's Ref:</label><br />
                                <asp:Label ID="lblCarrierRef" runat="server"></asp:Label>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="small">B/L-No:</label><br />
                                <asp:TextBox ID="txtBLNo" CssClass="form-control" TabIndex="4" runat="server" />
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-group col-sm-6">
                            <label class="small">Export Ref:</label><br />
                            <asp:Label ID="lblGiffiRef" runat="server"></asp:Label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="row">
                            <div class="form-group col-sm-12">
                                <label class="small">Consignee: </label>
                                <br />
                                <asp:DropDownList ID="ddlConsignee" CssClass="form-control" Width="35%" TabIndex="4" OnSelectedIndexChanged="ddlConsignee_SelectedIndexChanged" AutoPostBack="true" runat="server"></asp:DropDownList>
                            </div>
                            <div class="form-group col-sm-12">
                                <asp:TextBox ID="txtConsignee" CssClass="form-control" Width="75%" Rows="5" TextMode="MultiLine" runat="server" />
                            </div>
                        </div>
                    </td>
                    <td>
                        <label class="small">Consignee's Ref: </label>
                        <br />
                        <asp:TextBox ID="txtConsigneeRef" CssClass="form-control" TabIndex="6" Width="65%" runat="server" />
                        <hr />
                        <label class="small">Place Of Receipt:</label><br />
                        <asp:TextBox ID="txtPlaceOfReceipt" CssClass="form-control" TabIndex="7" Width="65%" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-group">
                            <label class="small">Notify Of Address:</label><br />
                            <asp:DropDownList ID="ddlNotify" CssClass="form-control" TabIndex="8" Width="35%" OnSelectedIndexChanged="ddlNotify_SelectedIndexChanged" AutoPostBack="true" runat="server"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtNotify" CssClass="form-control" Width="75%" TabIndex="9" TextMode="MultiLine" Rows="4" runat="server" />
                        </div>
                    </td>
                    <td>
                        <div class="form-group">
                            <label class="small">Place Of Delivery:</label><br />
                            <asp:TextBox ID="txtPlaceOfDelivery" CssClass="form-control" Width="65%" TabIndex="10" runat="server" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="form-group">
                            <label class="small">Supplier:</label><br />
                            <asp:DropDownList ID="ddlSupplier" CssClass="form-control" Width="35%" TabIndex="11" OnSelectedIndexChanged="ddlSupplier_SelectedIndexChanged" AutoPostBack="true" runat="server"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtSupplier" CssClass="form-control" Width="75%" TextMode="MultiLine" TabIndex="12" Rows="4" runat="server" />
                        </div>
                    </td>
                    <td>
                        <div class="form-group">
                            <label class="small">Warehouse:</label><br />
                            <asp:DropDownList ID="ddlWarehouse" CssClass="form-control" Width="35%" TabIndex="13" OnSelectedIndexChanged="ddlWarehouse_SelectedIndexChanged" AutoPostBack="true" runat="server"></asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <asp:TextBox ID="txtWarehouse" CssClass="form-control" Width="75%" TabIndex="514" TextMode="MultiLine" Rows="4" runat="server" />
                        </div>
                    </td>
                </tr>

                <tr>
                    <td>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label class="small">Container No:</label><br />
                                <asp:TextBox ID="txtContainerNo" CssClass="form-control" Enabled="false" runat="server" />
                            </div>
                            <div class="form-group col-md-6">
                                <label class="small">SEAL No:</label><br />
                                <asp:TextBox ID="txtSEALNo" CssClass="form-control" Enabled="false" runat="server" />
                            </div>
                        </div>
                    </td>
                    <td>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label class="small">Place of Issue:</label><br />
                                <asp:TextBox ID="txtPlaceOfIssue" CssClass="form-control" runat="server" />
                            </div>
                            <div class="form-group col-md-6">
                                <label class="small">Date of Issue:</label><br />
                                <asp:TextBox ID="txtDateOfIssue" CssClass="form-control" runat="server" />
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <div class="form-group">
                            <label class="small">Notes:</label><br />
                            <asp:TextBox ID="txtNotes" CssClass="form-control" TextMode="MultiLine" Rows="4" runat="server" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="padding-top: 60px">
                        <div class="form-group col-md-4"></div>
                        <div class="form-group col-md-8">
                            <asp:Button ID="btnSubmit" Text="Submit" OnClick="btnSubmit_Click" CssClass="btn btn-md btn-info" runat="server" />
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
