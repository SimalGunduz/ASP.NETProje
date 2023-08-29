<%@ Page Title="" Language="C#" MasterPageFile="~/yonetim/yonetim.master" AutoEventWireup="true" CodeBehind="sayfaislemleri.aspx.cs" 
    Inherits="DoktorSite.yonetim.sayfaislemleri" %>

<%@ Register assembly="FredCK.FCKeditorV2" namespace="FredCK.FCKeditorV2" tagprefix="FCKeditorV2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Heading -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Sayfa İşlemleri</h1>
        <p class="h3 mb-0 text-gray-800">&nbsp;</p>

    </div>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">Tüm Sayfalar</h6>
        </div>
        <div class="card-body">
            <asp:GridView ID="grdSayfalar" runat="server" AutoGenerateColumns="False" DataKeyNames="sayfa_id" DataSourceID="sdsSayfalar" AllowPaging="True" AllowSorting="True" Width="80%" OnSelectedIndexChanged="grdSayfalar_SelectedIndexChanged">
                <Columns>
                    <asp:CommandField ShowSelectButton="True">
                    <ItemStyle Width="50px" />
                    </asp:CommandField>
                    <asp:BoundField DataField="sayfa_id" HeaderText="sayfa_id" ReadOnly="True" InsertVisible="False" SortExpression="sayfa_id">
                    <ItemStyle Width="50px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="sayfa_basligi" HeaderText="Başlık" SortExpression="sayfa_basligi">
                    <ItemStyle Width="300px" />
                    </asp:BoundField>
                    <asp:CheckBoxField DataField="aktif" HeaderText="Yayında" SortExpression="aktif">
                    <ItemStyle Width="50px" />
                    </asp:CheckBoxField>
                    <asp:BoundField DataField="sira" HeaderText="Sıra" SortExpression="sira">
                    <ItemStyle Width="50px" />
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource runat="server" ID="sdsSayfalar" ConnectionString='<%$ ConnectionStrings:doktorDBConnectionString %>' 
                DeleteCommand="update  [Sayfalar] set silindi=1 WHERE [sayfa_id] = @sayfa_id"
                InsertCommand="INSERT INTO [Sayfalar] ([ust_id], [sayfa_basligi], [sayfa_icerigi], [aktif], [silindi], [sira]) VALUES (@ust_id, @sayfa_basligi, @sayfa_icerigi, @aktif, 0, @sira)" 
                SelectCommand="SELECT * FROM [Sayfalar] WHERE ([silindi] = @silindi) ORDER BY [sayfa_basligi]"
                UpdateCommand="UPDATE [Sayfalar] SET [ust_id] = @ust_id, [sayfa_basligi] = @sayfa_basligi, [sayfa_icerigi] = @sayfa_icerigi, [aktif] = @aktif,[sira] = @sira WHERE [sayfa_id] = @sayfa_id">
                <DeleteParameters>
                    <asp:Parameter Name="sayfa_id" Type="Int32"></asp:Parameter>
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="ddlUst" Name="ust_id" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="txtBaslik" Name="sayfa_basligi" PropertyName="Text" />
                    <asp:Parameter Name="sayfa_icerigi"></asp:Parameter>
                    <asp:ControlParameter ControlID="chkYayinda" Name="aktif" PropertyName="Checked" />
                    <asp:ControlParameter ControlID="txtSira" Name="sira" PropertyName="Text" />
                </InsertParameters>
                <SelectParameters>
                    <asp:Parameter DefaultValue="False" Name="silindi" Type="Boolean"></asp:Parameter>
                </SelectParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="ddlUst" Name="ust_id" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="txtBaslik" Name="sayfa_basligi" PropertyName="Text" Type="String" />
                    <asp:Parameter Name="sayfa_icerigi" Type="String"></asp:Parameter>
                    <asp:ControlParameter ControlID="chkYayinda" Name="aktif" PropertyName="Checked" Type="Boolean" />
                    <asp:ControlParameter ControlID="txtSira" Name="sira" PropertyName="Text" Type="Int32" />
                    <asp:Parameter Name="sayfa_id" Type="Int32"></asp:Parameter>
                </UpdateParameters>
            </asp:SqlDataSource>
            <br />
            <br />
            <asp:Panel ID="pnlDetay" runat="server" GroupingText="Detay:">
                Başlık: <asp:TextBox ID="txtBaslik" runat="server" CssClass="form-control"></asp:TextBox>
                <br />
                <br />
                Üst Menü: <asp:DropDownList CssClass="form-control" ID="ddlUst" runat="server" 
                    DataSourceID="sdsUstMenuler" DataTextField="sayfa_basligi" DataValueField="sayfa_id"></asp:DropDownList>
                <asp:SqlDataSource ID="sdsUstMenuler" runat="server" ConnectionString="<%$ ConnectionStrings:doktorDBConnectionString %>" 
                    SelectCommand="select top (1) NULL as sayfa_id, 'Ust Sayfa Yok' sayfa_basligi from sayfalar
union all 
select sayfa_id,sayfa_basligi from sayfalar where ust_id is NULL"></asp:SqlDataSource>
                <br />
                <br />
                Yayında: <asp:CheckBox ID="chkYayinda" runat="server" Text="Evet"/> <br />
                Sıra: <asp:TextBox ID="txtSira" runat="server" CssClass="form-control"></asp:TextBox>
                <br />
                <br />
                <br />
                İçerik:<FCKeditorV2:FCKeditor ID="fckIcerik" runat="server" Height="400px" Width="80%">
                </FCKeditorV2:FCKeditor>
                <asp:Button ID="btnYeni" runat="server" Text="Yeni" Cssclass="btn btn-primary" OnClick="btnYeni_Click" Width="49px"/>
                &nbsp;&nbsp;<asp:Button ID="btnKaydet" runat="server" Cssclass="btn btn-success" OnClick="btnKaydet_Click" Text="Kaydet" />
                &nbsp;
                <asp:Button ID="btnSil" runat="server" Cssclass="btn btn-danger" OnClick="btnSil_Click" OnClientClick="return confirm(&quot;Sayfayı silmek istiyor musunuz?&quot;)" Text="  Sil  " />
                &nbsp;<asp:Label ID="lblMesaj" runat="server" ForeColor="#6600FF"></asp:Label>
                <br />
            </asp:Panel>
        </div>
    </div>
</asp:Content>
