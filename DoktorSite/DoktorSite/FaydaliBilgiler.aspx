<%@ Page Title="" Language="C#" MasterPageFile="~/AnaSablon.Master" AutoEventWireup="true" CodeBehind="FaydaliBilgiler.aspx.cs" Inherits="DoktorSite.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <section id="faq" class="faq section-bg">
        <div class="container">

            <div class="section-title" style="margin-top: 80px">
                <h2>Faydalı Bilgiler</h2>

            </div>

            <div class="faq-list">
                <asp:Panel ID="pnlTumBilgiler" runat="server">
                    <ul>
                        <asp:Repeater ID="rptBilgiler" runat="server" DataSourceID="sdsBilgiler">
                            <ItemTemplate>
                                <li>
                                    <i class="bx bx-help-circle icon-help"></i>
                                    <a href="FaydaliBilgiler.aspx?id=<%#Eval("faydalibilgiler_id") %>">
                                        <%#Eval("faydalibilgiler_basligi") %> <i class="bx bx-chevron-down icon-show"></i>
                                        <i class="bx bx-chevron-up icon-close"></i></a>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:SqlDataSource runat="server" ID="sdsBilgiler" ConnectionString='<%$ ConnectionStrings:doktorDBConnectionString %>'
                            SelectCommand="SELECT * FROM [FaydaliBilgiler] WHERE ([aktif] = @aktif) AND ([silindi] = @silindi) ORDER BY [silindi]">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="True" Name="aktif" Type="Boolean"></asp:Parameter>
                                <asp:Parameter DefaultValue="False" Name="silindi" Type="Boolean"></asp:Parameter>
                            </SelectParameters>
                        </asp:SqlDataSource>

                    </ul>

                </asp:Panel>
                <asp:Panel ID="pnlSecilibilgi" runat="server">
                    <ul>
                        <asp:Repeater ID="rptSeciliBilgi" runat="server" DataSourceID="sdsSeciliBilgiler">
                            <ItemTemplate>
                                <li>
                                    <h3><%#Eval("faydalibilgiler_basligi")%></h3>
                                    <div>
                                        <%#Eval("faydalibilgiler_icerigi")%>
                                    </div>
                                    <i class="bx bx-chevron-down icon-show"></i>
                                    <i class="bx bx-chevron-up icon-close"></i>
                            </ItemTemplate>
                        </asp:Repeater>

                        <asp:Repeater ID="rptYorumlar" runat="server" DataSourceID="sdsYorumlar" OnItemCommand="rptYorumlar_ItemCommand">
                            <HeaderTemplate>
                                <h6>Yorumlar:</h6>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <%#Eval("yorum_icerigi") %><br />
                                <span style="font-size: 8px"><%#Eval("ekleyen_adisoyadi") %> tarafından <%#Eval("eklenme_tarihi","0:dd/MM/yyyy hh:mm") %> eklendi</span>
                            </ItemTemplate>
                            <SeparatorTemplate>
                                <br />
                            </SeparatorTemplate>
                        </asp:Repeater>
                        <asp:Panel ID="pnlYorumYap" runat="server" GroupingText="Yorum Yap" BorderStyle="Solid">
                            <div class="row">
                                <div class="col-lg-8 mt-5 mt-lg-0">


                                    <div class="row">
                                        <div class="col-md-6 form-group">
                                            <label for="txtAdiSoyadi">Ad Soyad</label>
                                            <asp:TextBox ID="txtAdiSoyadi" runat="server" CssClass="form-control" placeholder="Adınız Soyadınız:"></asp:TextBox>
                                        </div>
                                        <div class="col-md-6 form-group mt-3 mt-md-0">
                                            <label for="txtEposta">E-Posta</label>
                                            <asp:TextBox ID="txtEposta" runat="server" CssClass="form-control" placeholder="E-Posta Adresiniz:"></asp:TextBox>
                                        </div>
                                    </div>

                                    <div class="form-group mt-3">
                                        <label for="txtMesaj">Yorum</label>
                                        <asp:TextBox ID="txtMesaj" runat="server" CssClass="form-control" placeholder="Yorumunuz:" TextMode="MultiLine"></asp:TextBox>

                                    </div>
                                    <div class="form-group mt-3">
                                        <label for="txtMesaj">Ip Adresiniz</label>
                                        <asp:Label ID="lblIP" runat="server" Text="" CssClass="form-control"></asp:Label>
                                    </div>

                                    <div class="text-center">
                                        <asp:Button ID="btnGonder" runat="server" Text="Yorumu Gönder" CssClass="btn btn-primary mt-1" OnClick="btnGonder_Click" />

                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="btnGonder"></asp:AsyncPostBackTrigger>
                                            </Triggers>
                                        </asp:UpdatePanel>
                                        <asp:Label ID="lblMesaj" runat="server" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <asp:SqlDataSource runat="server" ID="sdsYorumlar" ConnectionString='<%$ ConnectionStrings:doktorDBConnectionString %>'
                            SelectCommand="SELECT * FROM [FaydaliBilgiYorumlari] WHERE (([faydalibilgiler_id] = @faydalibilgiler_id) AND ([onaylandi] = @onaylandi) AND ([silindi] = @silindi)) ORDER BY [eklenme_tarihi]"
                            InsertCommand="insert into FaydaliBilgi Yorumlari 
                            (yorum icerigi,eklenme_tarihi,ekleyen_ip,ekleyen_eposta ekleyen_adisoyadi ,faydali bilgiler_id)
                            values( @yorum_icerigi,getdate(),@ekleyen_ip,@ekleyen_eposta, @ekleyen_adisoyadi,@faydalibilgiler_id)">
                            <InsertParameters>
                                <asp:ControlParameter ControlID="txtMesaj" Name="yorum_icerigi" PropertyName="Text" />
                                <asp:ControlParameter ControlID="lblIP" Name="ekleyen_ip" PropertyName="Text" />
                                <asp:ControlParameter ControlID="txtEposta" Name="ekleyen_eposta" PropertyName="Text" />
                                <asp:ControlParameter ControlID="txtAdiSoyadi" Name="ekleyen_adisoyadi" PropertyName="Text" />
                                <asp:QueryStringParameter DefaultValue="0" Name="faydalibilgiler_id" QueryStringField="id" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:QueryStringParameter DefaultValue="0" Name="faydalibilgiler_id" Type="Int32" />
                                <asp:Parameter DefaultValue="True" Name="onaylandi" Type="Boolean"></asp:Parameter>
                                <asp:Parameter DefaultValue="False" Name="silindi" Type="Boolean"></asp:Parameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource runat="server" ID="sdsSeciliBilgiler"
                            ConnectionString='<%$ ConnectionStrings:doktorDBConnectionString %>'
                            SelectCommand="SELECT * FROM [FaydaliBilgiler] WHERE ([aktif] = @aktif) AND ([silindi] = @silindi) AND ([faydalibilgiler_id] = @faydalibilgiler_id) ORDER BY [silindi]">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="True" Name="aktif" Type="Boolean"></asp:Parameter>
                                <asp:Parameter DefaultValue="False" Name="silindi" Type="Boolean"></asp:Parameter>
                                <asp:QueryStringParameter DefaultValue="0" Name="faydalibilgiler_id" QueryStringField="id" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ul>
                    <a href="Faydalibilgiler.aspx">Geri</a>
                </asp:Panel>

            </div>
    </section>
</asp:Content>
