<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="WebApp.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
</asp:Content>
