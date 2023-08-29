<%@ Page Title="" Language="C#" MasterPageFile="~/yonetim/yonetim.master" AutoEventWireup="true" CodeBehind="YoneticiIslemleri.aspx.cs" Inherits="DoktorSite.yonetim.YoneticiIslemleri" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Kullanıcı İşlemleri</h1>

    </div>
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Tüm Yöneticiler</h6>
        </div>
        <div class="card-body">
            <asp:GridView ID="grdYonetici" runat="server" AutoGenerateColumns="False" DataKeyNames="yonetici_id" DataSourceID="sdsYonetici" 
                AllowPaging="True" AllowSorting="True" Width="80%" OnSelectedIndexChanged="grdSayfalar_SelectedIndexChanged">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="yonetici_id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="yonetici_id" />
                    <asp:BoundField DataField="adi" HeaderText="Adı" SortExpression="adi" />
                    <asp:BoundField DataField="soyadi" HeaderText="Soyadı" SortExpression="soyadi" />
                    <asp:BoundField DataField="eposta" HeaderText="Eposta" SortExpression="eposta" />
                    <asp:CheckBoxField DataField="aktif" HeaderText="Aktif" SortExpression="aktif" />
                    <asp:BoundField DataField="yetki" HeaderText="Yetki" SortExpression="yetki" />
                </Columns>
            </asp:GridView>
            
            <asp:SqlDataSource ID="sdsYonetici" runat="server" ConnectionString="<%$ ConnectionStrings:doktorDBConnectionString %>" 
                DeleteCommand="update [yonetici] set silindi=1 WHERE [yonetici_id] = @yonetici_id" 
                InsertCommand="INSERT INTO [yonetici] ([adi], [soyadi], [eposta], [parola], [aktif], [silindi], [yetki]) VALUES (@adi, @soyadi, @eposta, @parola, @aktif, 0,@yetki)" 
                SelectCommand="SELECT * FROM [yonetici] ORDER BY [adi], [soyadi], [eposta]" 
                UpdateCommand="UPDATE [yonetici] SET [adi] = @adi, [soyadi] = @soyadi, [eposta] = @eposta, [parola] = @parola, [aktif] = @aktif,  [yetki] = @yetki WHERE [yonetici_id] = @yonetici_id">
                <DeleteParameters>
                    <asp:Parameter Name="yonetici_id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="txtAdi" Name="adi" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtSoyadi" Name="soyadi" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtEPosta" Name="eposta" PropertyName="Text" Type="String" />
                    <asp:Parameter Name="parola" Type="String" />
                    <asp:ControlParameter ControlID="chkAktif" Name="aktif" PropertyName="Checked" Type="Boolean" />
                    <asp:ControlParameter ControlID="ddlYetki" Name="yetki" PropertyName="SelectedValue" Type="Byte" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="txtAdi" Name="adi" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtSoyadi" Name="soyadi" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtEPosta" Name="eposta" PropertyName="Text" Type="String" />
                    <asp:Parameter Name="parola" Type="String" />
                    <asp:ControlParameter ControlID="chkAktif" Name="aktif" PropertyName="Checked" Type="Boolean" />
                    <asp:ControlParameter ControlID="ddlYetki" Name="yetki" PropertyName="SelectedValue" Type="Byte" />
                    <asp:Parameter Name="yonetici_id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            
            <asp:SqlDataSource ID="sdsYoneticiGuncelle" runat="server" ConnectionString="<%$ ConnectionStrings:doktorDBConnectionString %>" 
                DeleteCommand="update [yonetici] set silindi=1 WHERE [yonetici_id] = @yonetici_id" 
                InsertCommand="INSERT INTO [yonetici] ([adi], [soyadi], [eposta], [parola], [aktif], [silindi], [yetki]) VALUES (@adi, @soyadi, @eposta, @parola, @aktif, 0,@yetki)"
                SelectCommand="SELECT * FROM [yonetici] ORDER BY [adi], [soyadi], [eposta]" UpdateCommand="UPDATE [yonetici] SET [adi] = @adi, [soyadi] = @soyadi, [eposta] = @eposta,[aktif] = @aktif,  [yetki] = @yetki WHERE [yonetici_id] = @yonetici_id">
                <DeleteParameters>
                    <asp:Parameter Name="yonetici_id" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="txtAdi" Name="adi" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtSoyadi" Name="soyadi" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtEPosta" Name="eposta" PropertyName="Text" Type="String" />
                    <asp:Parameter Name="parola" Type="String" />
                    <asp:ControlParameter ControlID="chkAktif" Name="aktif" PropertyName="Checked" Type="Boolean" />
                    <asp:ControlParameter ControlID="ddlYetki" Name="yetki" PropertyName="SelectedValue" Type="Byte" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="txtAdi" Name="adi" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtSoyadi" Name="soyadi" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="txtEPosta" Name="eposta" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="chkAktif" Name="aktif" PropertyName="Checked" Type="Boolean" />
                    <asp:ControlParameter ControlID="ddlYetki" Name="yetki" PropertyName="SelectedValue" Type="Byte" />
                    <asp:Parameter Name="yonetici_id" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:Panel ID="pnlDetay" runat="server" BorderStyle="Solid" GroupingText="Detay">
                Adı:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="txtAdi" runat="server" CssClass="form-control"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <br />
                Soyadı:<asp:TextBox ID="txtSoyadi" runat="server" CssClass="form-control"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <br />
                E-Posta:<asp:TextBox ID="txtEPosta" runat="server" CssClass="form-control"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <br />
                &nbsp;Aktif: <asp:CheckBox ID="chkAktif" runat="server" Text="Evet" CssClass="form-control"/> &nbsp;&nbsp;&nbsp;&nbsp;<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <br />
                Yetki:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="ddlYetki" runat="server" CssClass="form-control">
                    <asp:ListItem Value="1">Sistem Yöneticisi</asp:ListItem>
                    <asp:ListItem Value="2">Birim Kullanıcısı</asp:ListItem>
                </asp:DropDownList>
                <br />
&nbsp;<br /> Parola(*Değişirilmeyecekse boş bırakın):<asp:TextBox ID="txtParola" runat="server" CssClass="form-control"></asp:TextBox>
                &nbsp;&nbsp;<br />Parola (Tekrar):<asp:TextBox ID="txtParola2" runat="server" CssClass="form-control"></asp:TextBox>
                <br />
                <br />
                <asp:Button ID="btnYeni" runat="server" Cssclass="btn btn-primary" OnClick="btnYeni_Click" Text="Yeni" Width="49px" />
                &nbsp;&nbsp;<asp:Button ID="btnKaydet" runat="server" Cssclass="btn btn-success" OnClick="btnKaydet_Click" Text="Kaydet" />
                &nbsp;&nbsp;<asp:Button ID="btnSil" runat="server" Cssclass="btn btn-danger" OnClick="btnSil_Click" 
                    OnClientClick="return confirm(&quot;Sayfayı silmek istiyor musunuz?&quot;)" Text="  Sil  " />
                &nbsp;<asp:Label ID="lblMesaj" runat="server" ForeColor="#6600FF"></asp:Label>
                <br />
            </asp:Panel>
        </div>
    </div>
</asp:Content>
