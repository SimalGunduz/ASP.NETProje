<%@ Page Title="" Language="C#" MasterPageFile="~/AnaSablon.Master" AutoEventWireup="true" CodeBehind="Iletisim.aspx.cs" Inherits="DoktorSite.Iletisim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
    <section id="contact" class="contact">
      <div class="container">

        <div class="section-title">
          <h2>İletişim</h2>
        </div>
      </div>

      <div>
          <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d24489.17663037352!2d32.73800890073954!3d39.89333920459332!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x14d347acc4350fa9%3A0x1e0ece16de5e7e7f!2sAnkara%20%C5%9Eehir%20Hastanesi!5e0!3m2!1str!2str!4v1692651746306!5m2!1str!2str" 
              width="100%" height="350" style="border:0;" allowfullscreen="" ></iframe>
      </div>

      <div class="container">
        <div class="row mt-5">

          <div class="col-lg-4">
            <div class="info">
                <asp:Repeater ID="rptBilgiler" runat="server" DataSourceID="sqlBilgiler">
            <ItemTemplate>
                 <div class="address">
                <i class="bi bi-geo-alt"></i>
                <h4>Adres:</h4>
                <p><%#Eval("adres") %></p>
              </div>

              <div class="email">
                <i class="bi bi-envelope"></i>
                <h4>E-Posta:</h4>
                <p><%#Eval("adres") %></p>
              </div>

              <div class="phone">
                <i class="bi bi-phone"></i>
                <h4>Telefon:</h4>
                <p><%#Eval("telefon") %></p>
              </div>

            </ItemTemplate>

        </asp:Repeater>
                
        <asp:SqlDataSource ID="sqlBilgiler" runat="server" ConnectionString="<%$ ConnectionStrings:doktorDBConnectionString %>"
            SelectCommand="SELECT * FROM [DoktorBilgileri]"></asp:SqlDataSource>
            </div>
          </div>
            <div class="col-lg-8 mt-5 mt-lg-0">

            
              <div class="row">
                <div class="col-md-6 form-group">
                    <label for="txtAdiSoyadi">Ad Soyad</label>
                    <asp:TextBox ID="txtAdiSoyadi" runat="server" Cssclass="form-control" placeholder="Adınız Soyadınız:" ></asp:TextBox>
                </div>
                <div class="col-md-6 form-group mt-3 mt-md-0">
                    <label for="txtEposta">E-Posta</label>
                    <asp:TextBox ID="txtEposta" runat="server" Cssclass="form-control" placeholder="E-Posta Adresiniz:" ></asp:TextBox>
                </div>
              </div>
              <div class="form-group mt-3">
                  <label for="txtKonu">Konu</label>
                   <asp:TextBox ID="txtKonu" runat="server" Cssclass="form-control" placeholder="Konu:" ></asp:TextBox>
              </div>
              <div class="form-group mt-3">
                  <label for="txtMesaj">Mesaj</label>
                  <asp:TextBox ID="txtMesaj" runat="server" CssClass="form-control" placeholder="Mesaj:" TextMode="MultiLine"></asp:TextBox>

              </div>
              <div class="form-group mt-3">
                  <label for="txtMesaj">Ip Adresiniz</label>
                  <asp:Label ID="lblIP" runat="server" Text="" CssClass="form-control"></asp:Label>
              </div>

              <div class="text-center">
                  <asp:Button ID="btnGonder" runat="server" Text="Mesajı Gönder"  CssClass="btn btn-primary mt-1" OnClick="btnGonder_Click"  />
                  <asp:SqlDataSource ID="sdsMesajGonder" runat="server" ConnectionString="<%$ ConnectionStrings:doktorDBConnectionString %>" 
                      DeleteCommand="DELETE FROM [GelenMesajlar] WHERE [mesaj_id] = @mesaj_id"
                      InsertCommand="INSERT INTO [GelenMesajlar] ([mesaj_basligi], [mesaj_icerigi], [cevaplandi], [silindi], [gonderilme_tarihi], 
                      [ekleyen_ip], [ekleyen_eposta], [ekleyen_adisoyadi]) VALUES (@mesaj_basligi, @mesaj_icerigi,0, 0, getdate(), @ekleyen_ip, @ekleyen_eposta, @ekleyen_adisoyadi)" 
                      SelectCommand="SELECT * FROM [GelenMesajlar]"
                      UpdateCommand="UPDATE [GelenMesajlar] SET [mesaj_basligi] = @mesaj_basligi, [mesaj_icerigi] = @mesaj_icerigi, 
                      [cevaplandi] = @cevaplandi, [silindi] = @silindi, [gonderilme_tarihi] = @gonderilme_tarihi, [ekleyen_ip] = @ekleyen_ip, [ekleyen_eposta] = @ekleyen_eposta,
                      [ekleyen_adisoyadi] = @ekleyen_adisoyadi, [faydalibilgiler_id] = @faydalibilgiler_id WHERE [mesaj_id] = @mesaj_id">
                      <DeleteParameters>
                          <asp:Parameter Name="mesaj_id" Type="Int32" />
                      </DeleteParameters>
                      <InsertParameters>
                          <asp:ControlParameter ControlID="txtKonu" Name="mesaj_basligi" PropertyName="Text" />
                          <asp:ControlParameter ControlID="txtMesaj" Name="mesaj_icerigi" PropertyName="Text" />
                          <asp:ControlParameter ControlID="lblIP" Name="ekleyen_ip" PropertyName="Text" />
                          <asp:ControlParameter ControlID="txtEposta" Name="ekleyen_eposta" PropertyName="Text" />
                          <asp:ControlParameter ControlID="txtAdiSoyadi" Name="ekleyen_adisoyadi" PropertyName="Text" />
                      </InsertParameters>
                      <UpdateParameters>
                          <asp:Parameter Name="mesaj_basligi" Type="String" />
                          <asp:Parameter Name="mesaj_icerigi" Type="String" />
                          <asp:Parameter Name="cevaplandi" Type="Boolean" />
                          <asp:Parameter Name="silindi" Type="Boolean" />
                          <asp:Parameter Name="gonderilme_tarihi" Type="DateTime" />
                          <asp:Parameter Name="ekleyen_ip" Type="String" />
                          <asp:Parameter Name="ekleyen_eposta" Type="String" />
                          <asp:Parameter Name="ekleyen_adisoyadi" Type="String" />
                          <asp:Parameter Name="faydalibilgiler_id" Type="Int32" />
                          <asp:Parameter Name="mesaj_id" Type="Int32" />
                      </UpdateParameters>
                  </asp:SqlDataSource>
                  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                      <Triggers>
                          <asp:AsyncPostBackTrigger ControlID="btnGonder">
                          </asp:AsyncPostBackTrigger>
                      </Triggers>
                  </asp:UpdatePanel>
                  <asp:Label ID="lblMesaj" runat="server" Font-Bold="True" ForeColor="#CC0000"></asp:Label> 
          </div>
        </div>

      </div>
    </section><!-- End Contact Section -->

</asp:Content>
