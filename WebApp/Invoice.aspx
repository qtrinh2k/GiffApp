<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" MaintainScrollPositionOnPostback="true" AutoEventWireup="true" CodeBehind="Invoice.aspx.cs" Inherits="WebApp.Invoice1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script lang="javascript" type="text/javascript">
        $(function () {
            $('#<%=txtSearchBox.ClientID%>').autocomplete({
                source: function (request, response) {
                    op = $("#ddlOption option:selected").val();
                    $.ajax({
                        url: "Invoice.aspx/SearchFor",
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

    <div class="panel-group">

        <div class="panel panel-default">
            <div class="row">
                <div class="col-sm-9">
                    <div class="row">
                        <div class="col-sm-6 form-group">
                            <asp:TextBox ID="txtSearchBox" CssClass="form-control" TabIndex="1" runat="server" />
                        </div>
                        <div class="col-sm-3 form-group">
                            <asp:DropDownList CssClass="form-control" ID="ddlOption" ClientIDMode="Static" TabIndex="2" runat="server">
                                <asp:ListItem Value="1" Selected="True">GIFFI REF</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-sm-3 form-group">
                            <asp:Button ID="btnSelectedSearch" AutoPostBack="true" Text="Select" CssClass="btn btn-lg btn-info" TabIndex="3" runat="server" OnClick="SelectedSearch_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-12 well">
            <div style="font-size: large" class="row">

                <div class="col-md-12" style="padding-bottom: 20px">
                    <div class="row text-center">
                        <h1>General International Freight Forwarders, Inc.</h1>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <section>
                                200 W. THOMAS ST.<br />
                                SUITE 430<br />
                                SEATTLE, WA 98119
                            </section>
                        </div>
                        <div class="col-md-4">
                            <section>
                                PHONE: (206) 621-9910<br />
                                FAX: (206) 621-9948
                            </section>
                        </div>
                        <div style="text-align: right" class="form-group col-md-4">FMC NO. 3072F</div>
                    </div>
                </div>

                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-md-8">
                                    <h3 class="panel-title"><strong>Bill To</strong><br />
                                    </h3>
                                    <asp:Label ID="lblBillTo" runat="server"></asp:Label>
                                </div>

                                <div class="col-md-4">
                                    <h3 class="panel-title"><strong>Invoice</strong><br />
                                    </h3>
                                    <asp:Label ID="lblGiffiRef" runat="server"></asp:Label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="panel-heading col-md-10">
                                    <h3 class="panel-title"><strong>Description Of Shipment</strong><br />
                                    </h3>
                                    <asp:Label ID="lblDescription" runat="server"></asp:Label>
                                </div>
                                <div class="panel-heading col-md-2">
                                    <br />
                                    <strong>
                                        <asp:Label ID="lblInvoiceNo" runat="server"></asp:Label></strong>
                                </div>
                            </div>
                        </div>
                        <div class="panel-heading">
                            <div class="row">
                                <div class="panel-heading col-md-4">
                                    <h3 class="panel-title"><strong>Your Reference</strong><br />
                                    </h3>
                                    <asp:Label ID="lblYourRef" runat="server"></asp:Label>
                                </div>
                                <div class="panel-heading col-md-4">
                                    <h3 class="panel-title"><strong>Invoice Date</strong><br />
                                    </h3>
                                    <asp:Label ID="lblInvoiceDate" runat="server"></asp:Label>
                                </div>
                                <div class="panel-heading col-md-4">
                                    <h3 class="panel-title"><strong>Payment Due By</strong><br />
                                    </h3>
                                    <asp:TextBox CssClass="form-control" ID="txtPaymentDueBy" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="panel-heading">
                            <div class="row">
                                <div class="panel-heading col-xs-4">
                                    <h3 class="panel-title"><strong>Voyage</strong><br />
                                    </h3>
                                    <asp:Label ID="lblVoyage" runat="server"></asp:Label>
                                </div>
                                <div class="panel-heading col-xs-2">
                                    <h3 class="panel-title"><strong>Origin</strong><br />
                                    </h3>
                                    <asp:Label ID="lblOrigin" runat="server"></asp:Label>
                                </div>
                                <div class="panel-heading col-xs-2">
                                    <h3 class="panel-title"><strong>Destination</strong><br />
                                    </h3>
                                    <asp:Label ID="lblDestination" runat="server"></asp:Label>
                                </div>
                                <div class="panel-heading col-xs-4">
                                    <h3 class="panel-title"><strong>Bill Of Landing Number</strong><br />
                                    </h3>
                                    <asp:TextBox CssClass="form-control" ID="txtBillLandingNo" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="panel-heading">
                            <div class="row">
                                    <asp:GridView GridLines="None" ShowHeader="true" CssClass="table table-striped" ID="gvInvoice" DataKeyNames="Id" ShowFooter="true" runat="server" AutoGenerateColumns="false"
                                        OnRowEditing="gvInvoice_RowEditing" OnRowUpdating="gvInvoice_RowUpdating" OnRowCancelingEdit="gvInvoice_RowCancelingEdit" OnRowDeleting="gvInvoice_RowDeleting" OnDataBound="gvInvoice_DataBound"
                                        EmptyDataText="No records has been added." Font-Bold="true" BorderWidth="0" BorderStyle="None" ShowHeaderWhenEmpty="true">
                                        <Columns>
                                            <asp:TemplateField ControlStyle-CssClass="form-control col-xs-2" HeaderText="Code">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCode" Width="100px" runat="server" Text='<%# Eval("CodeId") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtCode" Enabled="false" Width="100px" runat="server" Text='<%# Eval("CodeId") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <FooterTemplate>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ControlStyle-CssClass="form-control col-xs-4" HeaderText="Description">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDescription" Width="300px" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtDescription" Width="300px" runat="server" Enabled="true" Text='<%# Eval("Description") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <FooterTemplate>
                                                     <asp:Label ID="lblDescription" Width="300px" runat="server" Text='Total'></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ControlStyle-CssClass="form-control col-xs-2" HeaderText="Billing($)">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBillingAmount" Width="100px" runat="server" Text='<%# String.Format("{0:#,##0.00}", Eval("BillingAmount")) %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtBillingAmount" Width="100px" Enabled="true" runat="server" Text='<%# String.Format("{0:#,##0.00}", Eval("BillingAmount")) %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtBillingAmount" CssClass="form-control" Enabled="false" Width="100px" runat="server"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ControlStyle-CssClass="form-control col-xs-2" HeaderText="PayOut($)">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPayOutAmount" Width="100px" runat="server" Text='<%# String.Format("{0:#,##0.00}", Eval("PayoutAmount")) %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtPayOutAmount" Width="100px" Enabled="true" runat="server" Text='<%# String.Format("{0:#,##0.00}", Eval("PayoutAmount")) %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtPayOutAmount" CssClass="form-control" Enabled="false" Width="100px" runat="server"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ControlStyle-CssClass="form-control col-xs-2" HeaderText="Vendor">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblVendor" Width="100px" runat="server" Text='<%# Eval("Vendor") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtVendor" Width="100px" Enabled="true" runat="server" Text='<%# Eval("Vendor") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtVendor" CssClass="form-control" Enabled="false" Width="100px" runat="server"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>

                                            <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Left" />
                                        </Columns>
                                    </asp:GridView>

                                    <asp:Table ID="tbAddBilling" Visible="false" CssClass="table table-striped" runat="server">
                                        <asp:TableRow CssClass="panel-heading" Font-Bold="true">
                                            <asp:TableCell CssClass="group-control col-xs-2">
                                                Code:<br />
                                                <asp:DropDownList CssClass="form-control" width="120px" ID="ddlAddCode" AutoPostBack="true" OnSelectedIndexChanged="ddlAddCode_SelectedIndexChanged" runat="server">
                                                    <asp:ListItem>Select</asp:ListItem>
                                                </asp:DropDownList>
                                            </asp:TableCell>
                                            <asp:TableCell CssClass="group-control col-xs-3">
                                                Description:<br />
                                                <asp:TextBox CssClass="form-control" ID="txtAddDescription" Width="300px" runat="server"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell CssClass="group-control col-xs-2">
                                                Billing:<br />
                                                <asp:TextBox CssClass="form-control" Width="100px" ID="txtAddBillingAmount" runat="server"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell CssClass="group-control col-xs-2">
                                                PayOut:<br />
                                                <asp:TextBox CssClass="form-control" Width="100px" ID="txtAddPayoutAmount" runat="server"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell CssClass="group-control col-xs-2">
                                                Vendor:<br />
                                                <asp:DropDownList CssClass="form-control" Width="100px" ID="ddlAddVendor" runat="server"></asp:DropDownList>
                                            </asp:TableCell>
                                            <asp:TableCell CssClass="group-group col-md-1">
                                                <br />
                                                <asp:Button ID="btnAddBillingItem" CssClass="btn btn-md btn-info" Visible="true" runat="server" Text="Add" CausesValidation="true" OnClick="btnAddBillingItem_Click" />
                                            </asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                            </div>
                        </div>
                        <div class="panel-heading">
                            <div class="row">
                                <div class="panel-footer form-horizontal right">
                                        <asp:Button ID="btnPreviewInvoice" CssClass="btn btn-lg btn-primary pull-right" Visible="false" runat="server" Text="Preview Invoice" OnClick="btnPreviewInvoice_Click"></asp:Button>
                                    <asp:Button ID="btnPayoutPreview" CssClass="btn btn-lg btn-primary pull-right" Visible="false" runat="server" Text="Preview PayOut" OnClick="btnPreviewPayout_Click"></asp:Button>
                                </div>
                            </div>
                                    
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
