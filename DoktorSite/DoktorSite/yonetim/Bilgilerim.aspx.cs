using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoktorSite.yonetim
{
    public partial class Bilgilerim : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string yonetici_id = "1";
                //yonetici_id = Session["yonetici_id"].ToString();
                SqlConnection baglanti = new SqlConnection(WebConfigurationManager.ConnectionStrings["doktorDBConnectionString"].ConnectionString);
                SqlDataAdapter dap = new SqlDataAdapter("select* from yonetici where yonetici_id=@yonetici_id and silindi=0", baglanti);
                dap.SelectCommand.Parameters.AddWithValue("@yonetici_id", yonetici_id);
                DataTable dtIcerik = new DataTable();
                try
                {
                    baglanti.Open();
                    dap.Fill(dtIcerik);
                    baglanti.Close();
                }
                catch (Exception)
                { }
                if (dtIcerik.Rows.Count > 0)
                {
                    txtAdi.Text = dtIcerik.Rows[0]["adi"].ToString();
                    txtSoyadi.Text = dtIcerik.Rows[0]["soyadi"].ToString();
                    txtEPosta.Text = dtIcerik.Rows[0]["eposta"].ToString();
                    //txtParola.Text = dtIcerik.Rows[0]["parola"].ToString();
                    //txtParola2.Text = dtIcerik.Rows[0]["parola2"].ToString();
                    ddlYetki.DataBind();
                    chkAktif.Checked = Convert.ToBoolean(dtIcerik.Rows[0]["aktif"].ToString());
                    ddlYetki.SelectedValue = dtIcerik.Rows[0]["yetki"].ToString();
                }
            
            }
        }
        protected void btnKaydet_Click(object sender, EventArgs e)
        {
            string yonetici_id = "1";
            if (txtParola.Text.Trim().Length == 0)//parola eskisi  gibi kalacak
            {
                sdsYoneticiGuncelle.UpdateParameters["yonetici_id"].DefaultValue = yonetici_id;
                if (sdsYoneticiGuncelle.Update() > 0)
                {
                    lblMesaj.Text = "Kayıt güncellendi.";
                    
                }
            }
            else//parola değişecek
            {
                if (txtParola.Text.Trim() != txtParola2.Text.Trim())
                {
                    lblMesaj.Text = "Parolalar uyuşmuyor.";
                    return;
                }
                sdsYonetici.UpdateParameters["parola"].DefaultValue = MD5Sifrele(txtParola.Text.Trim());
                sdsYonetici.UpdateParameters["yonetici_id"].DefaultValue = yonetici_id;
                if (sdsYonetici.Update() > 0)
                {
                    lblMesaj.Text = "Kayıt güncellendi.";
                    
                }
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