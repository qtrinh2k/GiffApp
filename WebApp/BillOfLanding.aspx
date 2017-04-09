<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BillOfLanding.aspx.cs" Inherits="WebApp.BillOfLanding" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script lang="javascript" type="text/javascript">
        $(function () {
            $('#<%=txtConsignee.ClientID%>').autocomplete({
                source: function (request, response) {
                    op = 3;
                    $.ajax({
                        url: "BillOfLanding.aspx/SearchFor",
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
            $('#<%=txtNotify.ClientID%>').autocomplete({
                source: function (request, response) {
                    op = 3;
                    $.ajax({
                        url: "BillOfLanding.aspx/SearchFor",
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
            $('#<%=txtSupplier.ClientID%>').autocomplete({
                source: function (request, response) {
                    op = 4;
                    $.ajax({
                        url: "BillOfLanding.aspx/SearchFor",
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
            $('#<%=txtWarehouse.ClientID%>').autocomplete({
                source: function (request, response) {
                    op = 5;
                    $.ajax({
                        url: "BillOfLanding.aspx/SearchFor",
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
  display:inline-block;
  padding-top:0;
  padding-bottom:0;
  line-height:1.5em;
} 
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-lg-12" style="font-size: large; vertical-align: super; border-width: 0px">
            <div class="row">
                <div class="col-sm-6 form-group">
                    <label>Consignee ([.] - to show all): </label>
                    <asp:TextBox ID="txtConsignee" Width="50%" CssClass="form-control" TabIndex="1" runat="server" />
                    <asp:Label ID="lblConsignee" runat="server"></asp:Label>
                    <asp:RequiredFieldValidator ID="rfvConsignee" ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtConsignee" runat="server" />
                </div>
                <div class="col-sm-6 form-group">
                    <label>Notify Of Address ([.] - to show all): </label>
                    <asp:TextBox ID="txtNotify" Width="50%" CssClass="form-control" TabIndex="2" runat="server" />
                    <asp:Label ID="lblNotify" runat="server"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtNotify" runat="server" />
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 form-group">
                    <label>Supplier ([.] - to show all): </label>
                    <asp:TextBox ID="txtSupplier" Width="50%" CssClass="form-control" TabIndex="3" runat="server" />
                    <asp:Label ID="lblSupplier" runat="server"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtSupplier" runat="server" />
                </div>
                <div class="col-sm-6 form-group">
                    <label>Warehouse ([.] - to show all): </label>
                    <asp:TextBox ID="txtWarehouse" Width="50%" CssClass="form-control" TabIndex="4" runat="server" />
                    <asp:Label ID="lblWarehouse" runat="server"></asp:Label>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtWarehouse" runat="server" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
