<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Container.aspx.cs" Inherits="WebApp.Container" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Container</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script lang="javascript" type="text/javascript">
        $(function () {
        $('#<%=txtSearchBox.ClientID%>').autocomplete({
            source: function (request, response) {
                op = $("#ddlOption option:selected").val();
                $.ajax({
                    url: "Container.aspx/SearchFor",
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
</head>
<body>
    <div class="jumbotron text-center">
        <h1>General International Freight Forwarders, Inc.</h1>
    </div>
    <form id="fmContainer" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <nav class="navbar navbar-default">
                        <div class="container-fluid">
                            <ul class="nav navbar-nav">
                                <li><a href="Index.aspx">Home</a></li>
                                <li><a href="Booking.aspx">Booking</a></li>
                                <li class="active"><a href="Container.aspx">Container</a></li>
                                <li><a href="Management.aspx">Management</a></li>
                                <li><a href="Accounting.aspx">Accounting</a></li>
                            </ul>
                        </div>
                    </nav>
                </div>
<%--                <div class="col-sm-12 well">
                    <div class="row"><h4>Search Container By:</h4></div>
                    <div class="col-sm-4 form-group">
                        <label>GIFFI Ref:</label>
                        <asp:TextBox ID="txtByGiffiRef" CssClass="form-control" TabIndex="-1" runat="server" />
                    </div>
                    <div class="col-sm-4 form-group">
                        <label>Container No:</label>
                        <asp:TextBox ID="txtByContainer" CssClass="form-control" TabIndex="-1" runat="server" OnFocus="SelectedContainer_OnFocus" />
                    </div>
                    <div class="col-sm-4 form-group">
                        <label>Shipper Ref:</label>
                        <asp:TextBox ID="txtByShipperRef" CssClass="form-control" TabIndex="-1" runat="server" />
                    </div>
                    <asp:Button ID="btnSelectedSearch" Text="Select" CssClass="btn btn-lg btn-info" TabIndex="-1" runat="server" OnClick="SelectedSearch_Click" />
                </div>--%>

            <div class="col-sm-9">
                <div class="row">
                    <div class="col-sm-6 form-group">
                        <asp:TextBox ID="txtSearchBox" CssClass="form-control" TabIndex="-1" runat="server"/>
                        <%--<asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtSearchBox" runat="server" />--%>                                     
                    </div>
                    <div class="col-sm-3 form-group">                        
                        <asp:DropDownList CssClass="form-control" id="ddlOption" ClientIDMode="Static" runat="server">
                            <asp:ListItem Value= "1" Selected="True">GIFFI REF</asp:ListItem> 
                            <asp:ListItem Value= "2" Text="Shipper REF">Shipper REF</asp:ListItem> 
                            <asp:ListItem Value= "3" Text="Container REF">Container REF</asp:ListItem> 
                        </asp:DropDownList>
                    </div>

                    <div class="col-sm-3 form-group">
                        <asp:Button ID="btnSelectedSearch" Text="Select" CssClass="btn btn-lg btn-info" TabIndex="-1" runat="server" OnClick="SelectedSearch_Click" />
                    </div>
                </div>
            </div>
                <div class="col-lg-12 well">

                    <div class="row">
                        <div class="row">
                            <div class="form-inline">
                                <div class="col-sm-6 form-group">
                                    <label>Date: </label>
                                    <asp:TextBox ID="txtDate" CssClass="form-control" runat="server" />
                                </div>
                                <div class="col-sm-6 form-group">
                                    <label>GIFFI REF:</label>
                                    <asp:TextBox ID="txtGiffRef" CssClass="form-control" TabIndex="-1" runat="server" Enabled="false" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="container">
                                <h2>Container Summary:</h2>
                                
                                <asp:GridView CssClass="panel-default" ID="gvContainer" runat="server" AutoGenerateColumns="true" AutoGenerateEditButton="true">

                                </asp:GridView>
                                <asp:PlaceHolder ID="phContainer" runat="server"></asp:PlaceHolder>
                            </div>
                        </div>

                    </div>

                </div>

                <asp:Panel ID="panelNewContainer" runat="server">
                                    <div id="rowNewContainer" class="col-lg-12 well">
                    <h4>New/Edit Container:</h4>
                    <div class="row">
                            <div class="col-sm-3 form-group">
                                <label>Contaner No:</label>
                                <asp:TextBox CssClass="form-control" ID="txtContainerNo" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtContainerNo" ValidationGroup="NewContainer" runat="server" />
                            </div>
                            <div class="col-sm-3 form-group">
                                <label>Seal No.</label>
                                <asp:TextBox CssClass="form-control" ID="txtSealNo" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtSealNo" ValidationGroup="NewContainer" runat="server" />
                            </div>
                    </div>
                    <div class="row">
                            <div class="col-sm-3 form-group">
                                <label>Packages:</label>
                                <asp:TextBox CssClass="form-control" ID="txtPackages" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtPackages" ValidationGroup="NewContainer" runat="server" />
                            </div>
                            <div class="col-sm-3 form-group">
                                <label>NET(Kg.)</label>
                                <asp:TextBox CssClass="form-control" ID="txtNet" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtNet" ValidationGroup="NewContainer" runat="server" />
                            </div>
                    </div>
                    <div class="row">
                            <div class="col-sm-3 form-group">
                                <label>Truck:</label>
                                <asp:TextBox CssClass="form-control" ID="txtTruck" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtTruck" ValidationGroup="NewContainer" runat="server" />
                            </div>
                            <div class="col-sm-3 form-group">
                                <label>Invoice No.</label>
                                <asp:TextBox CssClass="form-control" ID="txtInvoice" runat="server" />
                                <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtInvoice" ValidationGroup="NewContainer" runat="server" />
                            </div>
                    </div>
                    <div class="row">
                                <div class="col-sm-6 form-group">
                                    <asp:Button ID="btnSubmitContainer" Text="Submit" CssClass="btn btn-lg btn-info" TabIndex="-1" runat="server" CausesValidation="true" ValidationGroup="NewContainer"  OnClick="AddNewContainer_Click" />
                             </div>  
                    </div>
                </div>
                </asp:Panel>

            </div>
        </div>
    </form>
</body>
</html>
