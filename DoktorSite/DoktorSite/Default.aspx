<%@ Page Title="" Language="C#" MasterPageFile="~/AnaSablon.Master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="DoktorSite.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="breadcrumbs">
        <div class="container">
            <asp:Repeater ID="rptIcerik" runat="server" DataSourceID="sqlBilgiler">
                <ItemTemplate>
                    <%#Eval("sayfa_icerigi") %>
                </ItemTemplate>
            </asp:Repeater>
            <asp:SqlDataSource runat="server" ID="sqlBilgi"></asp:SqlDataSource>
        </div>
    </section>
    <asp:SqlDataSource runat="server" ID="sqlBilgiler" 
        ConnectionString='<%$ ConnectionStrings:doktorDBConnectionString %>'
        SelectCommand="SELECT * FROM [Sayfalar] WHERE (([aktif] = @aktif) AND ([silindi] = @silindi) AND ([sayfa_id] = @sayfa_id))">
        <SelectParameters>
            <asp:Parameter DefaultValue="True" Name="aktif" Type="Boolean"></asp:Parameter>
            <asp:Parameter DefaultValue="False" Name="silindi" Type="Boolean"></asp:Parameter>
            <asp:QueryStringParameter QueryStringField="id" DefaultValue="1" Name="sayfa_id" Type="Int32"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
