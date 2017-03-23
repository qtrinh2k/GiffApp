<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InvoiceSample.aspx.cs" Inherits="WebApp.Invoice" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
.invoice-title h2, .invoice-title h3 {
    display: inline-block;
}

.table > tbody > tr > .no-line {
    border-top: none;
}
    
.table > thead > tr > .no-line {
    border-bottom: none;
}

.table > tbody > tr > .thick-line {
    border-top: 2px solid;
}
    </style>
    <script lang="javascript" type="text/javascript">
        $(function () {
            $('#<%=txtSearchBox.ClientID%>').autocomplete({
                source: function (request, response) {
                    op = $("#ddlOption option:selected").val();
                    $.ajax({
                        url: "Index.aspx/SearchFor",
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
    <div class="row"><asp:Label ID="lbUser" Text="" runat="server"></asp:Label></div>
    <div class="col-sm-9">
        <div class="row">
            <div class="col-sm-6 form-group">
                <asp:TextBox ID="txtSearchBox" CssClass="form-control" TabIndex="1" runat="server" />
                <%--<asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtSearchBox" runat="server" />--%>
            </div>
            <div class="col-sm-3 form-group">
                <asp:DropDownList CssClass="form-control" ID="DropDownList1" ClientIDMode="Static" TabIndex="2" runat="server">
                    <asp:ListItem Value="1" Selected="True">GIFFI REF</asp:ListItem>
                    <asp:ListItem Value="2" Text="Shipper REF">Shipper REF</asp:ListItem>
                    <asp:ListItem Value="3" Text="Container REF">Container REF</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="col-sm-3 form-group">
                <asp:Button ID="btnSelectedSearch" Text="Select" CssClass="btn btn-lg btn-info" TabIndex="3" runat="server" OnClick="SelectedSearch_Click" />
            </div>
        </div>
    </div>
    <div class="col-lg-12 well">
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
            <div class="col-xs-12">
    		    <div class="invoice-title">
    			    <h2 class="pull-right">Invoice</h2>
                    <h3 class="pull-right">Order # 12345</h3>
    		    </div>
    		    <hr/>
    		    <div class="row">
    			    <div class="col-xs-6">
                        <asp:Literal  runat="server">
                            				    <address>
    				    <strong>Billed To:</strong><br>
    					    John Smith<br>
    					    1234 Main<br>
    					    Apt. 4B<br>
    					    Springfield, ST 54321
    				    </address>
                        </asp:Literal>

                        <asp:Panel runat="server">
                            <address>

                            </address>
                        </asp:Panel>
    			    </div>
    			    <div class="col-xs-6 text-right">
    				    <address>
        			    <strong>Shipped To:</strong><br>
    					    Jane Smith<br>
    					    1234 Main<br>
    					    Apt. 4B<br>
    					    Springfield, ST 54321
    				    </address>
    			    </div>
    		    </div>
    		    <div class="row">
    			    <div class="col-xs-6">
    				    <address>
    					    <strong>Payment Method:</strong><br>
    					    Visa ending **** 4242<br>
    					    jsmith@email.com
    				    </address>
    			    </div>
    			    <div class="col-xs-6 text-right">
    				    <address>
    					    <strong>Order Date:</strong><br>
    					    March 7, 2014<br><br>
    				    </address>
    			    </div>
    		    </div>
    	    </div>
        </div>
    
        <div class="row">
    	    <div class="col-md-12">
    		    <div class="panel panel-default">
    			    <div class="panel-heading">
    				    <h3 class="panel-title"><strong>Order summary</strong></h3>
    			    </div>
    			    <div class="panel-body">
    				    <div class="table-responsive">
    					    <table class="table table-condensed">
    						    <thead>
                                    <tr>
        							    <td><strong>Item</strong></td>
        							    <td class="text-center"><strong>Price</strong></td>
        							    <td class="text-center"><strong>Quantity</strong></td>
        							    <td class="text-right"><strong>Totals</strong></td>
                                    </tr>
    						    </thead>
    						    <tbody>
    							    <!-- foreach ($order->lineItems as $line) or some such thing here -->
    							    <tr>
    								    <td>BS-200</td>
    								    <td class="text-center">$10.99</td>
    								    <td class="text-center">1</td>
    								    <td class="text-right">$10.99</td>
    							    </tr>
                                    <tr>
        							    <td>BS-400</td>
    								    <td class="text-center">$20.00</td>
    								    <td class="text-center">3</td>
    								    <td class="text-right">$60.00</td>
    							    </tr>
                                    <tr>
            						    <td>BS-1000</td>
    								    <td class="text-center">$600.00</td>
    								    <td class="text-center">1</td>
    								    <td class="text-right">$600.00</td>
    							    </tr>
    							    <tr>
    								    <td class="thick-line"></td>
    								    <td class="thick-line"></td>
    								    <td class="thick-line text-center"><strong>Subtotal</strong></td>
    								    <td class="thick-line text-right">$670.99</td>
    							    </tr>
    							    <tr>
    								    <td class="no-line"></td>
    								    <td class="no-line"></td>
    								    <td class="no-line text-center"><strong>Shipping</strong></td>
    								    <td class="no-line text-right">$15</td>
    							    </tr>
    							    <tr>
    								    <td class="no-line"></td>
    								    <td class="no-line"></td>
    								    <td class="no-line text-center"><strong>Total</strong></td>
    								    <td class="no-line text-right">$685.99</td>
    							    </tr>
    						    </tbody>
    					    </table>
    				    </div>
    			    </div>
    		    </div>
    	    </div>
        </div>
    </div>
</asp:Content>
