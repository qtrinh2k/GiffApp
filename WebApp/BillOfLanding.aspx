<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="BillOfLanding.aspx.cs" Inherits="WebApp.BillOfLanding" %>

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
            <div class="col-lg-12" style="font-size: large; vertical-align: super; border-width: 0px">
                <div class="row">
                    <div class="panel panel-heading col-sm-6">
                        <label class="small" style="vertical-align: super;">Shipper:</label>
                        <asp:Label ID="lblBillTo" runat="server">
                                    <section>
                                        Bloom Global Corporation<br />
                                        1234 1st Ave<br />
                                        Seattle, WA 98012<br />
                                    </section>
                        </asp:Label>
                    </div>
                    <div class="panel panel-heading col-sm-6">
                        <h2 class="panel-title"><strong>Invoice</strong><br />
                        </h2>
                        <asp:Label ID="lblInvoiceNo" runat="server"></asp:Label>

                    </div>
                </div>
                <div class="panel panel-default col-md-12">
                    <div class="form-group col-md-6">
                        <label>Shipper:</label>
                        <section>
                            Address1
                        </section>
                    </div>
                    <div class="col-md-6">Cairrer's Ref</div>
                </div>
                <div class="col-md-12">
                    <div class="col-md-6">
                        <label>Consignee:</label>
                        <section>
                            Address1
                        </section>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            Export Reference
                        </div>
                        <div class="form-group">
                            Forwarding Agent:
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-md-6">Notify Address</div>
                    <div class="col-md-6">
                        <div class="form-group">Consignee's Ref</div>
                        <div class="form-group">Place of Receipt:</div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div>
                            <label>Vessel(s):</label>
                        </div>
                        <div>Port Of Loading:</div>
                        <div>Port Of Dischard:</div>
                    </div>
                    <div class="col-md-6">Place Of Delivery:</div>
                </div>
                <div class="col-md-12">
                    <asp:TextBox Rows="5" runat="server"></asp:TextBox>
                </div>
            </div>
        </div>
    </form>
</body>
</html>

