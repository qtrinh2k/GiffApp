<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BillOfLanding.aspx.cs" Inherits="WebApp.BillOfLanding" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="col-lg-12 well">
        <div style="font-size: large" class="row">
            <div class="col-sm-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-sm-6">
                                <h3 class="panel-title"></><br />
                                </h3>
                                <asp:Label ID="lblBillTo" runat="server"></asp:Label>
                            </div>

                            <div class="col-sm-6">
                                <h2 class="panel-title"><strong>Invoice</strong><br />
                                </h2>
                                <asp:Label ID="lblInvoiceNo" runat="server"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-default col-md-6">
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
                    <div><label>Vessel(s):</label></div>
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
</asp:Content>
