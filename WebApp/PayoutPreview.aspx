<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PayoutPreview.aspx.cs" Inherits="WebApp.PayoutPreview" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payout Preview</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="Content/bootstrap.min.css" />
    <link rel="stylesheet" href="CSS/main.css" />
    <link rel="stylesheet" href="CSS/style.css" media="print" />
    <script src="Scripts/jquery-3.1.1.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
</head>
<body>
    <form id="form1" runat="server">
       <div class="container">
            <div class="col-sm-12">
                <div style="font-size: large" class="row">

                    <div class="col-sm-12" style="padding-bottom: 20px">
                        <div class="row text-center">
                            <h1>General International Freight Forwarders, Inc.</h1>
                            <h2>PAYOUT</h2>
                        </div>
                    </div>

                    <div class="col-sm-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <h3 class="panel-title"><strong>Bill To</strong><br />
                                        </h3>
                                        <asp:Label ID="lblBillTo2" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <table class="table table-bordered">
                            <tr>
                                <td colspan="3">
                                    <h3 class="panel-title"><strong>Description Of Shipment</strong><br />
                                    </h3>
                                    <asp:Label ID="lblDescription2" runat="server"></asp:Label>
                                </td>
                                <td>
                                        <strong><asp:Label ID="lblInvoiceNo" runat="server"></asp:Label></strong>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <h3 class="panel-title"><strong>Your Reference</strong><br />
                                    </h3>

                                    <asp:Label ID="lblYourRef2" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <h3 class="panel-title"><strong>Invoice Date</strong><br />
                                    </h3>

                                    <asp:Label ID="lblInvoiceDate2" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <h3 class="panel-title"><strong>Payment Due By</strong><br />
                                    </h3>
                                    <asp:Label ID="lblPaymentDueBy2" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <h3 class="panel-title"><strong>Carrier/Voyage</strong><br />
                                    </h3>
                                    <asp:Label ID="lblCarrier2" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <h3 class="panel-title"><strong>Origin</strong><br />
                                    </h3>
                                    <asp:Label ID="lblOrigin2" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <h3 class="panel-title"><strong>Destination</strong><br />
                                    </h3>
                                    <asp:Label ID="lblDestination2" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <h3 class="panel-title"><strong>Bill Of Landing Number</strong><br />
                                    </h3>
                                    <asp:Label ID="lblBillOfLanding2" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <table class="table table-bordered">
                            <asp:Repeater ID="rptPayout" runat="server">
                                <HeaderTemplate>
                                    <tr>
                                        <td>Id</td>
                                        <td colspan="2">Code</td>
                                        <td>POUT</td>
                                        <td>NET</td>
                                    </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <strong><asp:Label ID="lblCode" Width="100px" runat="server" Text='<%# Eval("MapId") %>'></asp:Label></strong>
                                        </td>
                                        <td colspan="2">
                                            <strong><asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Code") %>'></asp:Label></strong>
                                        </td>
                                        <td>
                                            <strong><asp:Label ID="lblPayoutAmount" runat="server" Text='<%# String.Format("{0:#,##0.00}", Eval("PayoutAmount")) %>'></asp:Label></strong>
                                        </td>
                                        <td>
                                            <strong><asp:Label ID="lblNET" runat="server" Text='<%# String.Format("{0:#,##0.00}", Eval("NET")) %>'></asp:Label></strong>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <tr>
                                        <td colspan="3" style="text-align:right; padding-right:60px; padding-top:100px">
                                            <strong>TOTAL (USD)</strong>
                                        </td>
                                        <td style="padding-top:100px">
                                            <strong><asp:Label ID="lblPayoutTotal" runat="server"></asp:Label></strong>
                                        </td>
                                        <td style="padding-top:100px">
                                            <strong><asp:Label ID="lblNETTotal" runat="server"></asp:Label></strong>
                                        </td>
                                    </tr>
                                </FooterTemplate>
                            </asp:Repeater>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
