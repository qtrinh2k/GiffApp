<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Booking.aspx.cs" Inherits="WebApp.Booking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery.dynDateTime.min.js" type="text/javascript"></script>
    <script src="Scripts/calendar-en.min.js" type="text/javascript"></script>
    <link href="CSS/calendar-blue.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $("#<%=txtCutOffDate.ClientID %>").dynDateTime({
                showsTime: false,
                ifFormat: "%Y/%m/%d",
                daFormat: "%l;%M %p, %e %m,  %Y",
                align: "BR",
                electric: false,
                singleClick: false,
                displayArea: ".siblings('.dtcDisplayArea')",
                button: ".next()"
            });
            $("#<%=txtCargoCut.ClientID %>").dynDateTime({
                showsTime: false,
                ifFormat: "%Y/%m/%d",
                daFormat: "%l;%M %p, %e %m,  %Y",
                align: "BR",
                electric: false,
                singleClick: false,
                displayArea: ".siblings('.dtcDisplayArea')",
                button: ".next()"
            });
            $("#<%=txtDOC.ClientID %>").dynDateTime({
                showsTime: false,
                ifFormat: "%Y/%m/%d",
                daFormat: "%l;%M %p, %e %m,  %Y",
                align: "BR",
                electric: false,
                singleClick: false,
                displayArea: ".siblings('.dtcDisplayArea')",
                button: ".next()"
            });
            $("#<%=txtVGM.ClientID %>").dynDateTime({
                showsTime: false,
                ifFormat: "%Y/%m/%d",
                daFormat: "%l;%M %p, %e %m,  %Y",
                align: "BR",
                electric: false,
                singleClick: false,
                displayArea: ".siblings('.dtcDisplayArea')",
                button: ".next()"
            });
            $("#<%=txtETD.ClientID %>").dynDateTime({
                showsTime: false,
                ifFormat: "%Y/%m/%d",
                daFormat: "%l;%M %p, %e %m,  %Y",
                align: "BR",
                electric: false,
                singleClick: false,
                displayArea: ".siblings('.dtcDisplayArea')",
                button: ".next()"
            });
            $("#<%=txtETA.ClientID %>").dynDateTime({
                showsTime: false,
                ifFormat: "%Y/%m/%d",
                daFormat: "%l;%M %p, %e %m,  %Y",
                align: "BR",
                electric: false,
                singleClick: false,
                displayArea: ".siblings('.dtcDisplayArea')",
                button: ".next()"
            });
        });
    </script>
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

        document.fmBooking.txtCreatedBy.focus();
        document.getSelection()
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-lg-12 well">
        <h4>New Booking</h4>
        <div class="row">
            <div class="col-sm-12">
                <div class="row">
                    <div class="form-inline">
                        <div class="col-sm-6 form-group">
                            <label>Date: </label>
                            <asp:TextBox ID="txtDate" CssClass="form-control" runat="server" />
                        </div>
                        <div class="col-sm-6 form-group">
                            <label>GIFFI REF:</label>
                            <asp:TextBox ID="txtGiffRef" CssClass="form-control" TabIndex="-1" runat="server" Enabled="false" />
                            <asp:HiddenField ID="hfBookingId" runat="server" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-3 form-group">
                        <label>Person In Charge: </label>
                        <asp:TextBox ID="txtCreatedBy" CssClass="form-control" TabIndex="1" runat="server" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 form-group">
                        <label>Bill To ([.] - to show all): </label>
                        <asp:TextBox ID="txtBillTo" CssClass="form-control" TabIndex="2" runat="server" />
                        <asp:RequiredFieldValidator ID="rfvBillTo" ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtBillTo" runat="server" />
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-6 form-group">
                        <label>Shipper: </label>
                        <asp:TextBox ID="txtShipper" CssClass="form-control" TabIndex="3" runat="server" />
                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtShipper" runat="server" />
                    </div>
                    <div class="col-sm-6 form-group">
                        <label>Shipper Reference: </label>
                        <asp:TextBox ID="txtShipperRef" CssClass="form-control" TabIndex="4" runat="server" />
                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtShipperRef" runat="server" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 form-group">
                        <label>Carrier: </label>
                        <asp:TextBox ID="txtCarrier" CssClass="form-control" TabIndex="5" runat="server" />
                    </div>
                    <div class="col-sm-6 form-group">
                        <label>Carrier Reference: </label>
                        <asp:TextBox ID="txtCarrierRef" CssClass="form-control" TabIndex="5" runat="server" />
                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtCarrierRef" runat="server" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 form-group">
                        <label>Vessel: </label>
                        <asp:TextBox ID="txtVessel" CssClass="form-control" TabIndex="6" runat="server" />
                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtVessel" runat="server" />
                    </div>
                    <div class="col-sm-6 form-group">
                        <label>Voyage: </label>
                        <asp:TextBox ID="txtVoyage" CssClass="form-control" TabIndex="7" runat="server" />
                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtVoyage" runat="server" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 form-group">
                        <label>Origin: </label>
                        <asp:TextBox ID="txtOrigin" CssClass="form-control" TabIndex="8" runat="server" />
                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtOrigin" runat="server" />
                    </div>
                    <div class="col-sm-3 form-group">
                        <label>Load: </label>
                        <asp:TextBox ID="txtLoad" CssClass="form-control" TabIndex="9" runat="server" />
                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtLoad" runat="server" />
                    </div>
                    <div class="col-sm-3 form-group">
                        <label>ETD: </label>
                        <div class="form-group form-inline">
                            <asp:TextBox ID="txtETD" CssClass="form-control" TabIndex="9" runat="server" />
                            <img src="Image/calender.png" />
                        </div>
                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtETD" runat="server" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 form-group">
                        <label>Discharge: </label>
                        <asp:TextBox ID="txtDischarge" CssClass="form-control" TabIndex="10" runat="server" />
                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtDischarge" runat="server" />
                    </div>
                    <div class="col-sm-3 form-group">
                        <label>Destination: </label>
                        <asp:TextBox ID="txtDest" CssClass="form-control" TabIndex="11" runat="server" />
                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtDest" runat="server" />
                    </div>
                    <div class="col-sm-3 form-group">
                        <label>ETA: </label>
                        <div class="form-group form-inline">
                            <asp:TextBox ID="txtETA" CssClass="form-control" TabIndex="11" runat="server" />
                            <img src="Image/calender.png" />
                        </div>
                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtETA" runat="server" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 form-group">
                        <label>Commodity: </label>
                        <asp:TextBox ID="txtCommod" CssClass="form-control" TabIndex="12" runat="server" />
                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtCommod" runat="server" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6 form-group">
                        <label>Equip: </label>
                        <div class="form-inline">
                            <asp:TextBox ID="txtEquiq1" CssClass="form-control" TabIndex="13" runat="server" />
                            <asp:TextBox ID="txtEquiq2" CssClass="form-control" Width="50%" TabIndex="14" runat="server" />
                            <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtEquiq1" runat="server" />
                        </div>
                    </div>
                    <div class="col-sm-3 form-group">
                        <label>Temp: </label>
                        <asp:TextBox ID="txtTemp" CssClass="form-control" TabIndex="15" runat="server" />
                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtTemp" runat="server" />
                    </div>
                    <div class="col-sm-3 form-group">
                        <label>Vents: </label>
                        <asp:TextBox ID="txtVents" CssClass="form-control" TabIndex="16" runat="server" />
                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtVents" runat="server" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-3 form-group">
                        <label>Cut Off Date: </label>
                        <div class="form-group form-inline">
                            <asp:TextBox ID="txtCutOffDate" CssClass="form-control" TabIndex="17" runat="server" />
                            <img src="Image/calender.png" />
                        </div>
                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtCutOffDate" runat="server" />
                    </div>
                    <div class="col-sm-3 form-group">
                        <label>DOC Date: </label>
                        <div class="form-group form-inline">
                            <asp:TextBox ID="txtDOC" CssClass="form-control" TabIndex="18" runat="server" />
                            <img src="Image/calender.png" />
                        </div>
                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtDOC" runat="server" />
                    </div>
                    <div class="col-sm-3 form-group">
                        <label>Cargo Cut Date: </label>
                        <div class="form-group form-inline">
                            <asp:TextBox ID="txtCargoCut" CssClass="form-control" TabIndex="19" runat="server" />
                            <img src="Image/calender.png" />
                        </div>
                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtCargoCut" runat="server" />
                    </div>
                    <div class="col-sm-3 form-group">
                        <label>VGM Cut Of Date: </label>
                        <div class="form-group form-inline">
                            <asp:TextBox ID="txtVGM" CssClass="form-control" TabIndex="20" runat="server" />
                            <img src="Image/calender.png" />
                        </div>
                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtVGM" runat="server" />
                    </div>
                </div>
                <div class="form-group">
                    <label>Notes:</label>
                    <asp:TextBox ID="txtNotes" placeholder="Write note here.." Rows="3" TabIndex="21" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
                <div class="row">
                    <div class="col-sm-6 form-group">
                        <asp:Button ID="btnSubmitBooking" Text="Submit" CssClass="btn btn-lg btn-info" TabIndex="22" runat="server" OnClick="AddNewBooking_Click" />
                    </div>
                     <div class="col-sm-6 form-group">
                        <asp:Button ID="btnClone" Text="DoClone" CssClass="btn btn-lg btn-info" TabIndex="22" runat="server" OnClick="btnClone_Click" Visible="false" />
                    </div>
                    <div class="col-sm-3 form-group">
                        <asp:Button ID="btnClose" Text="Close" CssClass="btn btn-lg btn-info" TabIndex="23" runat="server" OnClick="btnClose_Click" Visible="false" />
                    </div>
                    <div class="col-sm-3 form-group">
                        <asp:Button ID="btnNext" Text="Next >>" CssClass="btn btn-lg btn-info" TabIndex="24" runat="server" OnClick="btnNext_Click" Visible="false" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

