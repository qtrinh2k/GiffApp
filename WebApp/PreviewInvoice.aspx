<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PreviewInvoice.aspx.cs" Inherits="WebApp.PreviewInvoice" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Invoice Preview</title>
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
                        </div>
                        <div class="row">
                            <div class="col-sm-4">
                                <section>
                                    200 W. THOMAS ST.<br />
                                    SUITE 430<br />
                                    SEATTLE, WA 98119
                                </section>
                            </div>
                            <div class="col-sm-4">
                                <section>
                                    PHONE: (206) 621-9910<br />
                                    FAX: (206) 621-9948
                                </section>
                            </div>
                            <div style="text-align: right" class="form-group col-sm-4">FMC NO. 3072F</div>
                        </div>
                    </div>

                    <div class="col-sm-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-sm-8">
                                        <h3 class="panel-title"><strong>Bill To</strong><br />
                                        </h3>
                                        <asp:Label ID="lblBillTo" runat="server"></asp:Label>
                                    </div>

                                    <div class="col-sm-4">
                                        <h2 class="panel-title"><strong>Invoice</strong><br />
                                        </h2>
                                        <asp:Label ID="lblInvoiceNo" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <table class="table table-bordered">
                            <tr>
                                <td colspan="4">
                                    <h3 class="panel-title"><strong>Description Of Shipment</strong><br />
                                    </h3>
                                    <asp:Label ID="lblDescription" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <h3 class="panel-title"><strong>Your Reference</strong><br />
                                    </h3>

                                    <asp:Label ID="lblYourRef" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <h3 class="panel-title"><strong>Invoice Date</strong><br />
                                    </h3>

                                    <asp:Label ID="lblInvoiceDate" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <h3 class="panel-title"><strong>Payment Due By</strong><br />
                                    </h3>
                                    <asp:Label ID="lblPaymentDueBy" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <h3 class="panel-title"><strong>Carrier/Voyage</strong><br />
                                    </h3>
                                    <asp:Label ID="lblCarrier" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <h3 class="panel-title"><strong>Origin</strong><br />
                                    </h3>
                                    <asp:Label ID="lblOrigin" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <h3 class="panel-title"><strong>Destination</strong><br />
                                    </h3>
                                    <asp:Label ID="lblDestination" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <h3 class="panel-title"><strong>Bill Of Landing Number</strong><br />
                                    </h3>
                                    <asp:Label ID="lblBillOfLanding" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <table class="table table-bordered">
                            <asp:Repeater ID="rptInvoice" runat="server">
                                <HeaderTemplate>
                                    <tr>
                                        <td>Code</td>
                                        <td colspan="2">Description</td>
                                        <td>Price</td>
                                    </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <strong><asp:Label ID="lblCode" Width="100px" runat="server" Text='<%# Eval("CodeId") %>'></asp:Label></strong>
                                        </td>
                                        <td colspan="2">
                                            <strong><asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>'></asp:Label></strong>
                                        </td>
                                        <td>
                                            <strong><asp:Label ID="lblBillingAmount" runat="server" Text='<%# String.Format("{0:0.00}", Eval("BillingAmount")) %>'></asp:Label></strong>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                    <tr>
                                        <td colspan="3" style="text-align:right; padding-right:60px; padding-top:100px">
                                            <strong>TOTAL (USD)</strong>
                                        </td>
                                        <td style="padding-top:100px">
                                            <strong><asp:Label ID="lblTotal" runat="server"></asp:Label></strong>
                                        </td>
                                    </tr>
                                </FooterTemplate>
                            </asp:Repeater>
                        </table>
                        <section>
                            GENERAL INTERNATIONAL FREIGHT FORWARDERS, INC. HAS A POLICY AGAINST PAYMENT, SOLICITATION OR RECEIPT OF ANY REBATE, DIRECTLY OR INDIRECTLY, WHICH WOULD BE UNLAWFUL UNDER THE ACT, 1984, AS AMMENDED.<br /><br />
                            <strong>TERMS OF PAYMENT:</strong><br />
                            THIS INVOICE MAY INCLUDE DISBURSEMENTS ADVANCED FOR YOUR ACCOUNT. TO INSURE TIMELY PAYMENTS TO CARRIERS AND OTHERS, WE MUST HAVE YOUR PAYMENT BY THE ABOVE DUE DATE. ALL DELIQUENT ACCOUNTS ARE SUBJECT 
                            TO ANNULA FINANCE CHARGE OF EIGHTEEN (18%) AND SUCH CHARGES WILL BE ASSESSED ON A MONTHLY BASIS. UPON REQUEST WE SHALL PROVIDE A DETAILED BREAKOUT OF THE COMPONENTS OF ALL CHARGES ASSESSED AND A TRUE 
                            COPY OF EACH PERTINENT DOCUMENT RELATING TO THESE CHARGES.
                        </section>
                    </div>
                </div>
            </div>

            <div class="page-break"></div>
            <hr />

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
                                <td colspan="4">
                                    <h3 class="panel-title"><strong>Description Of Shipment</strong><br />
                                    </h3>
                                    <asp:Label ID="lblDescription2" runat="server"></asp:Label>
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
                                        <td>Code</td>
                                        <td colspan="2">Description</td>
                                        <td>Price</td>
                                    </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <strong><asp:Label ID="lblCode" Width="100px" runat="server" Text='<%# Eval("MapId") %>'></asp:Label></strong>
                                        </td>
                                        <td colspan="2">
                                            <strong><asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>'></asp:Label></strong>
                                        </td>
                                        <td>
                                            <strong><asp:Label ID="lblPayoutAmount" runat="server" Text='<%# String.Format("{0:0.00}", Eval("PayoutAmount")) %>'></asp:Label></strong>
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
                                    </tr>
                                </FooterTemplate>
                            </asp:Repeater>
                        </table>
                    </div>
                </div>
            </div>

            <asp:Button ID="btnPrintInvoice" Text="Print Invoice" runat="server" OnClientClient="return PrintPanel();"></asp:Button>
        </div>
    </form>
</body>
</html>
