<%@ Page Title="" Language="C#" MasterPageFile="~/yonetim/yonetim.master" AutoEventWireup="true" CodeBehind="mesajlar.aspx.cs" Inherits="DoktorSite.yonetim.mesajlar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Mesaj İşlemleri</h1>

    </div>
    <asp:GridView ID="grdMesajlar" runat="server" DataSourceID="sdsMesajlar" AutoGenerateColumns="False" DataKeyNames="mesaj_id" AllowPaging="True" AllowSorting="True" CellPadding="4" ForeColor="#333333" GridLines="None" 
        OnSelectedIndexChanged="grdMesajlar_SelectedIndexChanged" Width="90%">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="mesaj_id" HeaderText="ID" ReadOnly="True" InsertVisible="False" SortExpression="mesaj_id"></asp:BoundField>
            <asp:BoundField DataField="mesaj_basligi" HeaderText="BAŞLIK" SortExpression="mesaj_basligi"></asp:BoundField>
            <asp:CheckBoxField DataField="cevaplandi" HeaderText="Cevaplandı" SortExpression="cevaplandi"></asp:CheckBoxField>
            <asp:BoundField DataField="gonderilme_tarihi" HeaderText="TARİH" SortExpression="gonderilme_tarihi"></asp:BoundField>
            <asp:BoundField DataField="ekleyen_ip" HeaderText="IP" SortExpression="ekleyen_ip"></asp:BoundField>
            <asp:BoundField DataField="ekleyen_adisoyadi" HeaderText="GÖNDEREN" SortExpression="ekleyen_adisoyadi"></asp:BoundField>
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
    <asp:SqlDataSource runat="server" ID="sdsMesajlar" ConnectionString='<%$ ConnectionStrings:doktorDBConnectionString %>' SelectCommand="SELECT * FROM [GelenMesajlar] WHERE ([silindi]=0) ORDER BY [cevaplandi], [gonderilme_tarihi] DESC" 
        DeleteCommand="update [GelenMesajlar] set silindi=1 WHERE [mesaj_id] = @mesaj_id" InsertCommand="INSERT INTO [GelenMesajlar] ([mesaj_basligi], [mesaj_icerigi], [cevaplandi], [silindi], [gonderilme_tarihi], [ekleyen_ip], [ekleyen_eposta],
        [ekleyen_adisoyadi]) VALUES (@mesaj_basligi, @mesaj_icerigi, @cevaplandi, @silindi, @gonderilme_tarihi, @ekleyen_ip, @ekleyen_eposta, @ekleyen_adisoyadi)" UpdateCommand="UPDATE [GelenMesajlar] SET  [cevaplandi] = @cevaplandi WHERE [mesaj_id] = @mesaj_id">
        <DeleteParameters>
            <asp:Parameter Name="mesaj_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="mesaj_basligi" Type="String" />
            <asp:Parameter Name="mesaj_icerigi" Type="String" />
            <asp:Parameter Name="cevaplandi" Type="Boolean" />
            <asp:Parameter Name="silindi" Type="Boolean" />
            <asp:Parameter Name="gonderilme_tarihi" Type="DateTime" />
            <asp:Parameter Name="ekleyen_ip" Type="String" />
            <asp:Parameter Name="ekleyen_eposta" Type="String" />
            <asp:Parameter Name="ekleyen_adisoyadi" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="chkCevaplandi" Name="cevaplandi" PropertyName="Checked" />
            <asp:Parameter Name="mesaj_id" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:Panel ID="pnlDetay" runat="server" BorderStyle="Double" GroupingText="Mesaj Detayı">
        Konu:&nbsp;&nbsp;
        <asp:Label ID="lblBaslik" runat="server"></asp:Label>
        <br />
        <br />
        İçerik:<br />
        <asp:Literal ID="ltrMesaj" runat="server"></asp:Literal>
        <br />
        Gönderen:
        <asp:Label ID="lblGonderen" runat="server"></asp:Label>
        <br />
        Gönderen E-Posta:<asp:Label ID="lblGonderenEPosta" runat="server"></asp:Label>
        <br />
        Tarih:<asp:Label ID="lblTarih" runat="server"></asp:Label>
        <br />
        IP Adresi:<asp:Label ID="lblIP" runat="server"></asp:Label>
        <br />
        Cevaplandı:<asp:CheckBox ID="chkCevaplandi" runat="server" />
        <br />
        <br />
        &nbsp;&nbsp;<asp:Button ID="btnKaydet" runat="server" CssClass="btn btn-success" OnClick="btnKaydet_Click" Text="Cevaplandı Olrak İşaretle" />
&nbsp;&nbsp;<asp:Button ID="btnSil" runat="server" CssClass="btn btn-danger" OnClick="btnSil_Click" OnClientClick="return confirm(&quot;Sayfayı silmek istiyor musunuz?&quot;)" Text="Mesajı Sil" />
        &nbsp;<asp:Label ID="lblMesaj" runat="server" ForeColor="#6600FF"></asp:Label>
    </asp:Panel>
</asp:Content>
