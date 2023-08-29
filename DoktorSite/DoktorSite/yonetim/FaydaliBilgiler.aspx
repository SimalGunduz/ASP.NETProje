<%@ Page Title="" Language="C#" MasterPageFile="~/yonetim/yonetim.master" AutoEventWireup="true" CodeBehind="FaydaliBilgiler.aspx.cs" 
    Inherits="DoktorSite.yonetim.FaydaliBilgiler" %>
<%@ Register assembly="FredCK.FCKeditorV2" namespace="FredCK.FCKeditorV2" tagprefix="FCKeditorV2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Faydalı Bilgiler</h1>

    </div>
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Tüm İçerikler</h6>
        </div>
        <div class="card-body">
            <asp:GridView ID="grdIcerikler" runat="server" AutoGenerateColumns="False" DataKeyNames="faydalibilgiler_id"
                DataSourceID="sdsIcerikler" AllowPaging="True" AllowSorting="True" Width="80%" OnSelectedIndexChanged="grdIcerikler_SelectedIndexChanged">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="faydalibilgiler_id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="faydalibilgiler_id" />
                    <asp:BoundField DataField="faydalibilgiler_basligi" HeaderText="BAŞLIK" SortExpression="faydalibilgiler_basligi" />
                    <asp:CheckBoxField DataField="aktif" HeaderText="Yayında" SortExpression="aktif" />
                    <asp:BoundField DataField="sira" HeaderText="SIRA" SortExpression="sira" />
                    <asp:BoundField DataField="eklenme_tarihi" DataFormatString="{0: dd/MM/yyyy}" HeaderText="EKLENME TARİHİ" SortExpression="eklenme_tarihi" />
                </Columns>
            </asp:GridView>

            <asp:SqlDataSource runat="server" ID="sdsIcerikler" ConnectionString='<%$ ConnectionStrings:doktorDBConnectionString %>' DeleteCommand="update FROM [FaydaliBilgiler] set silindi=1 WHERE [faydalibilgiler_id] = @faydalibilgiler_id"
                InsertCommand="INSERT INTO [FaydaliBilgiler] ([faydalibilgiler_basligi], [faydalibilgiler_icerigi], [aktif], [silindi], [sira], [eklenme_tarihi]) VALUES (@faydalibilgiler_basligi, @faydalibilgiler_icerigi, @aktif, 0,@sira, getdate())" 
                SelectCommand="SELECT * FROM [FaydaliBilgiler]"
                UpdateCommand="UPDATE [FaydaliBilgiler] SET [faydalibilgiler_basligi] = @faydalibilgiler_basligi, [faydalibilgiler_icerigi] = @faydalibilgiler_icerigi, [aktif] = @aktif, [sira] = @sira, [eklenme_tarihi] = getdate()
                WHERE [faydalibilgiler_id] = @faydalibilgiler_id">
                <DeleteParameters>
                    <asp:Parameter Name="faydalibilgiler_id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="txtBaslik" Name="faydalibilgiler_basligi" PropertyName="Text" Type="String" />
                    <asp:Parameter Name="faydalibilgiler_icerigi" Type="String" />
                    <asp:ControlParameter ControlID="chkYayinda" Name="aktif" PropertyName="Checked" Type="Boolean" />
                    <asp:ControlParameter ControlID="txtSira" Name="sira" PropertyName="Text" Type="Int32" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="txtBaslik" Name="faydalibilgiler_basligi" PropertyName="Text" />
                    <asp:Parameter Name="faydalibilgiler_icerigi" />
                    <asp:ControlParameter ControlID="chkYayinda" Name="aktif" PropertyName="Checked" />
                    <asp:ControlParameter ControlID="txtSira" Name="sira" PropertyName="Text" />
                    <asp:Parameter Name="faydalibilgiler_id" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Panel ID="pnlDetay" runat="server" BorderStyle="Solid" GroupingText="Detay">
                Başlık:
                <asp:TextBox ID="txtBaslik" runat="server" CssClass="form-control"></asp:TextBox>
                <br />
                <br />
                &nbsp;<br />
                <br />
                Yayında:
                <asp:CheckBox ID="chkYayinda" runat="server" Text="Evet" />
                <br />
                Sıra:
                <asp:TextBox ID="txtSira" runat="server" CssClass="form-control"></asp:TextBox>
                <br />
                <br />
                <br />
                İçerik:<fckeditorv2:fckeditor id="fckIcerik" runat="server" height="400px" width="80%">
                </fckeditorv2:fckeditor>
                <asp:Button ID="btnYeni" runat="server" Text="Yeni" CssClass="btn btn-primary" OnClick="btnYeni_Click" Width="49px" />
                &nbsp;&nbsp;<asp:Button ID="btnKaydet" runat="server" CssClass="btn btn-success" OnClick="btnKaydet_Click" Text="Kaydet" />
                &nbsp;
                <asp:Button ID="btnSil" runat="server" CssClass="btn btn-danger" OnClick="btnSil_Click" OnClientClick="return confirm(&quot;Sayfayı silmek istiyor musunuz?&quot;)" Text="  Sil  " />
                &nbsp;<asp:Label ID="lblMesaj" runat="server" ForeColor="#6600FF"></asp:Label>
                <br />
            </asp:Panel>
        </div>
    </div>
</asp:Content>
