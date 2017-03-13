<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Container.aspx.cs" Inherits="WebApp.Container" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
                <div class="col-sm-9">
                <div class="row">
                    <div class="col-sm-6 form-group">
                        <asp:TextBox ID="txtSearchBox" CssClass="form-control" TabIndex="1" runat="server"/>
                        <%--<asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtSearchBox" runat="server" />--%>                                     
                    </div>
                    <div class="col-sm-3 form-group">                        
                        <asp:DropDownList CssClass="form-control" id="ddlOption" ClientIDMode="Static" TabIndex="2" runat="server">
                            <asp:ListItem Value= "1" Selected="True">GIFFI REF</asp:ListItem> 
                            <asp:ListItem Value= "2" Text="Shipper REF">Shipper REF</asp:ListItem> 
                            <asp:ListItem Value= "3" Text="Container REF">Container REF</asp:ListItem> 
                        </asp:DropDownList>
                    </div>

                    <div class="col-sm-3 form-group">
                        <asp:Button ID="btnSelectedSearch" Text="Select" CssClass="btn btn-lg btn-info" TabIndex="3" runat="server" OnClick="SelectedSearch_Click" />
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
                                <asp:Label ID="lblAlertSucess" Visible="false" CssClass="alert alert-success alert-dismissable fade in" runat="server">
                                </asp:Label>
                                <asp:Label ID="lblAlertFailure" Visible ="false" CssClass="alert alert-danger alert-dismissable fade in" runat="server">
                                </asp:Label>

                                <asp:GridView CssClass="table table-striped" ID="gvContainer" DataKeyNames="Id" runat="server" AutoGenerateColumns="false"
                                    OnRowEditing="gvContainer_RowEditing" OnRowDeleting="gvContainer_RowDeleting" OnRowUpdating="gvContainer_RowUpdating" OnRowCancelingEdit="gvContainer_RowCancelEditing"
                                    EmptyDataText="No records has been added." Font-Bold="true">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Container No." ItemStyle-Width="130px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblContainerNo" runat="server" Text='<%# Eval("ContainerNo") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtContainerNo" Width="120" runat="server" Text='<%# Eval("ContainerNo") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Seal No." ItemStyle-Width="130px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSealNo" runat="server" Text='<%# Eval("SealNo") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtSealNo" Width="120" runat="server" Text='<%# Eval("SealNo") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Packages" ItemStyle-Width="130px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPkgsWeight" runat="server" Text='<%# Eval("PkgsWeight") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtPkgsWeight" Width="120" runat="server" Text='<%# Eval("PkgsWeight") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="NET (Kg)" ItemStyle-Width="130px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNetWeight" runat="server" Text='<%# Eval("NetWeight") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtNetWeight" Width="120" runat="server" Text='<%# Eval("NetWeight") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="GRS (Kg)" ItemStyle-Width="130px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblGRS" Width="120" runat="server" Text='<%# Eval("GRS") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtGRS" Width="120" runat="server" Text='<%# Eval("GRS") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Truck" ItemStyle-Width="130px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTruck" Width="120" runat="server" Text='<%# Eval("Truck") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtTruck" Width="120" runat="server" Text='<%# Eval("Truck") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Invoice" ItemStyle-Width="130px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblInvoice" Width="120" runat="server" Text='<%# Eval("Invoice") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtInvoice" Width="120" runat="server" Text='<%# Eval("Invoice") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="CreatedDate" ItemStyle-Width="130px">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCreatedDate" runat="server" Text='<%# Eval("CreatedDate") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtCreatedDate" Width="120" runat="server" Text='<%# Eval("CreatedDate") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true" ItemStyle-Width="150" />
                                    </Columns>
                                </asp:GridView>
                                
                                <asp:Table id="tbNewContainer" CSSClass="table table-striped" runat="server">
                                    <asp:TableRow Font-Bold="true">

                                    <asp:TableCell style="width: 130px">
                                        Contaner No:<br />
                                        <asp:TextBox ID="txtNewContainerNo" runat="server" Width="120" />
                                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtNewContainerNo" ValidationGroup="NewContainer" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell style="width: 130px">
                                        Seal No.<br />
                                        <asp:TextBox ID="txtNewSealNo" runat="server" Width="120" />
                                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtNewSealNo" ValidationGroup="NewContainer" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell style="width: 130px">
                                        Packages:<br />
                                        <asp:TextBox ID="txtNewPackage" runat="server" Width="120" />
                                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtNewPackage" ValidationGroup="NewContainer" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell style="width: 130px">
                                        Net (Kg):<br />
                                        <asp:TextBox ID="txtNewNet" runat="server" Width="120" />
                                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtNewNet" ValidationGroup="NewContainer" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell style="width: 130px">
                                        GRS:<br />
                                        <asp:TextBox ID="txtNewGRS" runat="server" Width="120" />
                                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtNewGRS" ValidationGroup="NewContainer" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell style="width: 130px">
                                        Truck:<br />
                                        <asp:TextBox ID="txtNewTruck" runat="server" Width="120" />
                                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtNewTruck" ValidationGroup="NewContainer" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell style="width: 130px">
                                        Invoice:<br />
                                        <asp:TextBox ID="txtNewInvoice" runat="server" Width="120" />
                                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtNewInvoice" ValidationGroup="NewContainer" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell style="width: 150px">
                                        Date:<br />
                                        <asp:TextBox ID="txtNewCreatedDate" runat="server" Width="130" />
                                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtNewCreatedDate" ValidationGroup="NewContainer" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell style="width: 130px">
                                        <br />
                                        <asp:Button ID="btnSubmitContainer" CssClass="btn btn-sm btn-info" runat="server" Text="Add" CausesValidation="true" ValidationGroup="NewContainer" OnClick="AddNewContainer_Click" />
                                    </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </div>
                        </div>

                    </div>
                </div>
</asp:Content>

