<%@ Page Title="" Language="C#" MasterPageFile="~/yonetim/yonetim.master" AutoEventWireup="true" CodeBehind="YorumIslemleri.aspx.cs" Inherits="DoktorSite.yonetim.YorumIslemleri" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800" aria-orientation="horizontal">Yorumlar</h1>
        <p class="h3 mb-0 text-gray-800">&nbsp;</p>
        <p class="h3 mb-0 text-gray-800">&nbsp;</p>
        <p class="h3 mb-0 text-gray-800">&nbsp;</p>
        <p class="h3 mb-0 text-gray-800">&nbsp;</p>
        <p class="h3 mb-0 text-gray-800">&nbsp;</p>
        <p class="h3 mb-0 text-gray-800">&nbsp;</p>
        <p class="h3 mb-0 text-gray-800">&nbsp;</p>
        <p class="h3 mb-0 text-gray-800">&nbsp;</p>

    </div>
    <asp:GridView ID="grdYorumlar" runat="server" AutoGenerateColumns="False" DataKeyNames="yorum_id" DataSourceID="sdsYorumlar" AllowPaging="True"
        AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="grdYorumlar_SelectedIndexChanged" Width="90%">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="yorum_id" HeaderText="ID" SortExpression="yorum_id" InsertVisible="False" ReadOnly="True"></asp:BoundField>
            <asp:BoundField DataField="yorum_icerigi" HeaderText="İçerik" SortExpression="yorum_icerigi"></asp:BoundField>
            <asp:CheckBoxField DataField="onaylandi" HeaderText="Onay" SortExpression="onaylandi"></asp:CheckBoxField>
            <asp:BoundField DataField="eklenme_tarihi" HeaderText="Eklenme Tarihi" SortExpression="eklenme_tarihi"></asp:BoundField>
            <asp:BoundField DataField="ekleyen_ip" HeaderText="IP" SortExpression="ekleyen_ip"></asp:BoundField>
            <asp:BoundField DataField="ekleyen_eposta" HeaderText="E-Posta" SortExpression="ekleyen_eposta"></asp:BoundField>
            <asp:BoundField DataField="ekleyen_adisoyadi" HeaderText="Ad Soyad" SortExpression="ekleyen_adisoyadi"></asp:BoundField>
            <asp:BoundField DataField="faydalibilgiler_id" HeaderText="Başlık ID" SortExpression="faydalibilgiler_id"></asp:BoundField>
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <asp:SqlDataSource runat="server" ID="sdsYorumlar" ConnectionString='<%$ ConnectionStrings:doktorDBConnectionString %>'
        SelectCommand="SELECT * FROM [FaydaliBilgiYorumlari]"
        UpdateCommand="UPDATE [FaydaliBilgiYorumlari] SET [yorum_icerigi] = @yorum_icerigi, [onaylandi] = @onaylandi, [silindi] = @silindi,
        [eklenme_tarihi] = @eklenme_tarihi, [ekleyen_ip] = @ekleyen_ip, [ekleyen_eposta] = @ekleyen_eposta, [ekleyen_adisoyadi] = @ekleyen_adisoyadi,[faydalibilgiler_id] = @faydalibilgiler_id WHERE [yorum_id] = @yorum_id" 
        DeleteCommand="DELETE FROM [FaydaliBilgiYorumlari] WHERE [yorum_id] = @yorum_id" 
        InsertCommand="INSERT INTO [FaydaliBilgiYorumlari] ([yorum_icerigi], [onaylandi], [silindi], [eklenme_tarihi], [ekleyen_ip], [ekleyen_eposta], [ekleyen_adisoyadi], [faydalibilgiler_id]) VALUES (@yorum_icerigi, @onaylandi, @silindi, @eklenme_tarihi, 
        @ekleyen_ip, @ekleyen_eposta, @ekleyen_adisoyadi, @faydalibilgiler_id)">
        <DeleteParameters>
            <asp:Parameter Name="yorum_id" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="yorum_icerigi" Type="String"></asp:Parameter>
            <asp:Parameter Name="onaylandi" Type="Boolean"></asp:Parameter>
            <asp:Parameter Name="silindi" Type="Boolean"></asp:Parameter>
            <asp:Parameter Name="eklenme_tarihi" Type="DateTime"></asp:Parameter>
            <asp:Parameter Name="ekleyen_ip" Type="String"></asp:Parameter>
            <asp:Parameter Name="ekleyen_eposta" Type="String"></asp:Parameter>
            <asp:Parameter Name="ekleyen_adisoyadi" Type="String"></asp:Parameter>
            <asp:Parameter Name="faydalibilgiler_id" Type="Int32"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="yorum_icerigi" Type="String" />
            <asp:Parameter Name="onaylandi" Type="Boolean"></asp:Parameter>
            <asp:Parameter Name="silindi" Type="Boolean"></asp:Parameter>
            <asp:Parameter Name="eklenme_tarihi" Type="DateTime"></asp:Parameter>
            <asp:Parameter Name="ekleyen_ip" Type="String"></asp:Parameter>
            <asp:Parameter Name="ekleyen_eposta" Type="String"></asp:Parameter>
            <asp:Parameter Name="ekleyen_adisoyadi" Type="String"></asp:Parameter>
            <asp:Parameter Name="faydalibilgiler_id" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="yorum_id" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
