using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoktorSite
{
    public partial class giris : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnGiris_Click(object sender, EventArgs e)
        {
            SqlConnection baglanti = new SqlConnection(WebConfigurationManager.ConnectionStrings["doktorDBConnectionString"].ConnectionString);
            SqlDataAdapter dap = new SqlDataAdapter("select* from yonetici where eposta=@eposta and parola=@parola and silindi=0 and aktif=1", baglanti);
            dap.SelectCommand.Parameters.AddWithValue("@eposta", txtEposta.Text.Trim());
            dap.SelectCommand.Parameters.AddWithValue("@parola", MD5Sifrele(txtParola.Text.Trim()));
            DataTable dtYonetici = new DataTable();
            try
            {
                baglanti.Open();
                dap.Fill(dtYonetici);
                baglanti.Close();
            }
            catch (Exception)
            { }
            if (dtYonetici.Rows.Count > 0)//boyle bi kullanıcı var
            {
                Session["yonetici_id"] = dtYonetici.Rows[0]["yonetici_id"].ToString(); 
                Session["yonetici_adi"] = dtYonetici.Rows[0]["adi"].ToString() + " " + dtYonetici.Rows[0]["soyadi"].ToString(); 
                FormsAuthentication.RedirectFromLoginPage(txtEposta.Text.Trim(),true); 
                Response.Redirect("yonetim/sayfaislemleri.aspx");
            }
            else
            {
                lblMesaj.Text = "Kullanıcı bulunamadı";
                return;
            }

        }
        public static string MD5Sifrele(string sifrelenecekMetin)
        {

            // MD5CryptoServiceProvider sınıfının bir örneğini oluşturduk.
            MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();
            //Parametre olarak gelen veriyi byte dizisine dönüştürdük.
            byte[] dizi = Encoding.UTF8.GetBytes(sifrelenecekMetin);
            //dizinin hash'ini hesaplattık.
            dizi = md5.ComputeHash(dizi);
            //Hashlenmiş verileri depolamak için StringBuilder nesnesi oluşturduk.
            StringBuilder sb = new StringBuilder();
            //Her byte'i dizi içerisinden alarak string türüne dönüştürdük.

            foreach (byte ba in dizi)
            {
                sb.Append(ba.ToString("x2").ToLower());
            }

            //hexadecimal(onaltılık) stringi geri döndürdük.
            return sb.ToString();
        }
    }
}