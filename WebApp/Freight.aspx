<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Freight.aspx.cs" Inherits="WebApp.Freight" %>
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
                            <asp:TextBox ID="txtSearchBox" CssClass="form-control" TabIndex="1" runat="server" />
                            <%--<asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtSearchBox" runat="server" />--%>
                        </div>
                        <div class="col-sm-3 form-group">
                            <asp:DropDownList CssClass="form-control" ID="ddlOption" ClientIDMode="Static" TabIndex="2" runat="server">
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
                </div>
                <div class="row">
                    <div class="container">
                        <h2>Freight Calculation:</h2>
                        <asp:Label ID="lblAlertSucess" Visible="false" CssClass="alert alert-success alert-dismissable fade in" runat="server">
                        </asp:Label>
                        <asp:Label ID="lblAlertFailure" Visible ="false" CssClass="alert alert-danger alert-dismissable fade in" runat="server">
                        </asp:Label>

                        <asp:GridView CssClass="table table-striped" ID="gvFreight" DataKeyNames="Id" ShowFooter="true" runat="server" AutoGenerateColumns="false" 
                            OnRowEditing="gvFreight_RowEditing" OnRowUpdating="gvFreight_RowUpdating" OnRowCancelingEdit="gvFreight_RowCancelingEdit" OnRowDeleting="gvFreight_RowDeleting"
                            EmptyDataText="No records has been added." Font-Bold="true">
                            <Columns>
                                <asp:TemplateField HeaderText="Code" ItemStyle-Width="100px">
                                   <ItemTemplate>
                                        <asp:Label ID="lblCode" runat="server" Text='<%# Eval("Code") %>'></asp:Label>
                                   </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtCode" Width="98" Enabled="false" runat="server" Text='<%# Eval("Code") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="BS" ItemStyle-Width="40px">
                                   <ItemTemplate>
                                        <asp:Label ID="lblBS" runat="server" Text='<%# Eval("BS") %>'></asp:Label>
                                   </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtBS" Width="98" runat="server" Enabled ="true" Text='<%# Eval("BS") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="P/C" ItemStyle-Width="40px">
                                   <ItemTemplate>
                                        <asp:Label ID="lblPC" runat="server" Text='<%# Eval("PC") %>'></asp:Label>
                                   </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtPC" Width="98" Enabled="false" runat="server" Text='<%# Eval("PC") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Units" ItemStyle-Width="40px">
                                   <ItemTemplate>
                                        <asp:Label ID="lblUnits" runat="server" Text='<%# Eval("Units") %>'></asp:Label>
                                   </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtUnits" Width="98" runat="server" Text='<%# Eval("Units") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rate" ItemStyle-Width="100px">
                                   <ItemTemplate>
                                        <asp:Label ID="lblRate" runat="server" Text='<%# String.Format("{0:0.00}", Eval("Rate")) %>'></asp:Label>
                                   </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtRate" Width="98" runat="server" Text='<%# String.Format("{0:0.00}", Eval("Rate")) %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="AMT. PPD" ItemStyle-Width="100px">
                                   <ItemTemplate>
                                        <asp:Label ID="lblAmtPPD" runat="server" Text='<%# String.Format("{0:0.00}", Eval("AmtPPD")) %>'></asp:Label>
                                   </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtAmtPPD" Width="98" runat="server" Text='<%# String.Format("{0:0.00}", Eval("AmtPPD")) %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="AMT COL" ItemStyle-Width="100px">
                                   <ItemTemplate>
                                        <asp:Label ID="lblAmtCOL" runat="server" Text='<%# String.Format("{0:0.00}", Eval("AmtCOL")) %>'></asp:Label>
                                   </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtAmtCOL" Width="98" runat="server" Text='<%# String.Format("{0:0.00}", Eval("AmtCOL")) %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="BRK Rate" ItemStyle-Width="100px">
                                   <ItemTemplate>
                                        <asp:Label ID="lblBrkRate" runat="server" Text='<%# String.Format("{0:0.00}", Eval("BrkRate")) %>'></asp:Label>
                                   </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtBrkRate" Width="98" runat="server" Text='<%# String.Format("{0:0.00}", Eval("BrkRate")) %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="BRK AMT" ItemStyle-Width="100px">
                                   <ItemTemplate>
                                        <asp:Label ID="lblBrkAmt" runat="server" Text='<%# String.Format("{0:0.00}", Eval("BrkAmt")) %>'></asp:Label>
                                   </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtBrkAmt" Width="98" runat="server" Text='<%# String.Format("{0:0.00}", Eval("BrkAmt")) %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true" ItemStyle-Width="100" />
                            </Columns>
                        </asp:GridView>

                        <asp:Table ID="tbAddFreight" CSSClass="table table-striped" runat="server">
                            <asp:TableRow Font-Bold="true">
                                    <asp:TableCell style="width: 100px">
                                        Code:<br />
                                        <%--<asp:TextBox ID="txtNewCode" runat="server" Width="90" />--%>
                                        <asp:DropDownList ID="ddlNewCode" runat="server" Width ="98">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="ddlNewCode" ValidationGroup="AddFreight" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell style="width: 50px">
                                        BS:<br />
                                        <asp:TextBox ID="txtNewBS" runat="server" Width="98" />
                                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtNewBS" ValidationGroup="AddFreight" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell style="width: 50px">
                                        P/C:<br />
                                        <asp:DropDownList ID="ddlNewPC" OnTextChanged="ddlNewPC_TextChanged" runat="server" Width ="98">
                                            <asp:ListItem>P</asp:ListItem>                                                
                                            <asp:ListItem>C</asp:ListItem>
                                        </asp:DropDownList>                                        
                                    </asp:TableCell>
                                    <asp:TableCell style="width: 50px">
                                        Units:<br />
                                        <asp:TextBox ID="txtNewUnits" runat="server" Width="90" OnTextChanged="txtNewUnits_TextChanged" />
                                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtNewUnits" ValidationGroup="AddFreight" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell style="width: 100px">
                                        Rate:<br />
                                        <asp:TextBox ID="txtNewRate" runat="server" Width="90" OnTextChanged="txtNewRate_TextChanged"/>
                                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtNewRate" ValidationGroup="AddFreight" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell style="width: 100px">
                                        AMT PPD:<br />
                                        <asp:TextBox ID="txtNewAmtPPD" runat="server" Width="90" />
                                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtNewAmtPPD" ValidationGroup="AddFreight" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell style="width: 100px">
                                        AMT COL:<br />
                                        <asp:TextBox ID="txtNewAmtCOL" runat="server" Width="90" />
                                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtNewAmtCOL" ValidationGroup="AddFreight" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell style="width: 100px">
                                        BRK RATE:<br />
                                        <asp:TextBox ID="txtNewBrkRate" runat="server" Width="90" OnTextChanged="txtNewBrkRate_TextChanged" />
                                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtNewBrkRate" ValidationGroup="AddFreight" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell style="width: 100px">
                                        BRK AMT:<br />
                                        <asp:TextBox ID="txtNewBrkAmt" runat="server" Width="90" />
                                        <asp:RequiredFieldValidator ErrorMessage="Required" ForeColor="Red" ControlToValidate="txtNewBrkAmt" ValidationGroup="AddFreight" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell style="width: 100px">
                                        <br />
                                        <asp:Button ID="btnAddFreight" CssClass="btn btn-sm btn-info" Visible="true" runat="server" Text="Add" CausesValidation="true" ValidationGroup="AddFreight" OnClick="AddNewFreight_Click" />
                                    </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </div>
                </div>
</asp:Content>
