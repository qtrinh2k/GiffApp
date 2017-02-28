<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Booking.aspx.cs" Inherits="WebApp.Booking" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>New Booking Page</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script lang="javascript" type="text/javascript">
        $(function () {
            $('#<%=txtBillTo.ClientID%>').autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "Booking.aspx/GetCompanyName",
                        data: "{ 'pre':'" + request.term + "'}",
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

        $(function () {
            $('#<%=txtShipper.ClientID%>').autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "Booking.aspx/GetCompanyName",
                        data: "{ 'pre':'" + request.term + "'}",
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

        $(function () {
            $('#<%=txtCarrier.ClientID%>').autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "Booking.aspx/GetCarrierCode",
                        data: "{ 'pre':'" + request.term + "'}",
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
</head>
<body>

    <div class="jumbotron text-center">
        <h1>General International Freight Forwarders, Inc.</h1>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <nav class="navbar navbar-default">
                    <div class="container-fluid">
                        <ul class="nav navbar-nav">
                            <li><a href="Index.aspx">Home</a></li>
                            <li class="active"><a href="Booking.aspx">Booking</a></li>
                            <li><a href="Management.aspx">Management</a></li>
                            <li><a href="Accounting.aspx">Accounting</a></li>
                        </ul>
                    </div>
                </nav>

            </div>

            <div class="col-lg-12 well">
                <h4>New Booking</h4>
                <div class="row">
                    <form runat="server">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="form-inline">
                                    <div class="col-sm-6 form-group">
                                        <label>Date: </label>
                                        <asp:TextBox ID="txtDate" Cssclass="form-control" runat="server" />
                                    </div>
                                    <div class="col-sm-6 form-group">
                                        <label>GIFFI REF:</label>
                                        <asp:TextBox ID="txtGiffRef" Cssclass="form-control" TabIndex="0" runat="server" Enabled="false" />
                                    </div>
                                </div>

                            </div>
                            <div class="row">
                                <div class="col-sm-3 form-group">
                                    <label>Person In Charge: </label>
                                    <asp:TextBox ID="txtCreatedBy" Cssclass="form-control" TabIndex="1" runat="server" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6 form-group">
                                    <label>Bill To (* -show all): </label>
                                    <asp:TextBox ID="txtBillTo"  Cssclass="form-control" TabIndex="2" runat="server" />
                                    <asp:RequiredFieldValidator ID="rfvBillTo" ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtBillTo" runat="server" />
                                    <%--                                    <asp:DropDownList ID="ddlBillTo" Cssclass="form-control" TabIndex="2" runat="server">
                                    </asp:DropDownList>--%>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-sm-6 form-group">
                                    <label>Shipper: </label>
                                    <asp:TextBox ID="txtShipper" Cssclass="form-control" TabIndex="3" runat="server" />
                                    <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtShipper" runat="server" />                                     
                                </div>
                                 <div class="col-sm-6 form-group">
                                    <label>Reference Number: </label>
                                    <asp:TextBox ID="txtShipperRef" Cssclass="form-control" TabIndex="8" runat="server" />
                                    <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtDest" runat="server" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6 form-group">
                                    <label>Carrier: </label>
                                    <asp:TextBox ID="txtCarrier" Cssclass="form-control" TabIndex="4" runat="server" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6 form-group">
                                    <label>Vessel: </label>
                                    <asp:TextBox ID="txtVessel" Cssclass="form-control" TabIndex="5" runat="server" />
                                    <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtVessel" runat="server" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label>VSL: </label>
                                    <asp:TextBox ID="txtVSL" Cssclass="form-control" TabIndex="6" runat="server" />
                                    <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtVSL" runat="server" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6 form-group">
                                    <label>Origin: </label>
                                    <asp:TextBox ID="txtOrigin" Cssclass="form-control" TabIndex="9" runat="server" />
                                    <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtOrigin" runat="server" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label>Load: </label>
                                    <asp:TextBox ID="txtLoad" Cssclass="form-control" TabIndex="10" runat="server" />
                                    <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtLoad" runat="server" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6 form-group">
                                    <label>Discharge: </label>
                                    <asp:TextBox ID="txtDischarge" Cssclass="form-control" TabIndex="7" runat="server" />
                                    <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtDischarge" runat="server" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label>Destination: </label>
                                    <asp:TextBox ID="txtDest" Cssclass="form-control" TabIndex="8" runat="server" />
                                    <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtDest" runat="server" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6 form-group">
                                    <label>Commodity: </label>
                                    <asp:TextBox ID="txtCommod" Cssclass="form-control" TabIndex="11" runat="server" />
                                    <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtCommod" runat="server" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-inline">
                                    <div class="col-sm-6 form-group">
                                        <label>Equiq: </label>
                                        <asp:TextBox ID="txtEquiq1" Cssclass="form-control" TabIndex="12" runat="server" />
                                        <asp:TextBox ID="txtEquiq2" Cssclass="form-control" TabIndex="13" runat="server" />
                                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtEquiq1" runat="server" />
                                    </div>
                                    <div class="col-sm-3 form-group">
                                        <label>Temp: </label>
                                        <asp:TextBox ID="txtTemp" Cssclass="form-control" TabIndex="14" runat="server" />
                                    </div>
                                    <div class="col-sm-3 form-group">
                                        <label>Vents: </label>
                                        <asp:TextBox ID="txtVents" Cssclass="form-control" TabIndex="15" runat="server" />
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Notes:</label>
                                <asp:TextBox ID="txtNotes" placeholder="Write note here.." Rows="3" TabIndex="14" Cssclass="form-control" runat="server"></asp:TextBox>
                            </div>
                            <asp:Button Text="Submit" CssClass="btn btn-lg btn-info" TabIndex="15" runat="server" OnClick="AddNewBooking_Click" />
                        </div>
                    </form>
                </div>
            </div>

        </div>

    </div>

</body>
</html>
