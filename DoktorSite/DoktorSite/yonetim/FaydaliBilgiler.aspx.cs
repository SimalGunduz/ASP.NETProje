using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoktorSite.yonetim
{
    public partial class FaydaliBilgiler : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void grdIcerikler_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (grdIcerikler.SelectedIndex > -1)//seçili sayfa var
            {
                SqlConnection baglanti = new SqlConnection(WebConfigurationManager.ConnectionStrings["doktorDBConnectionString"].ConnectionString);
                SqlDataAdapter dap = new SqlDataAdapter("select* from FaydaliBilgiler where faydalibilgiler_id=@faydalibilgiler_id and silindi=0", baglanti);
                dap.SelectCommand.Parameters.AddWithValue("@faydalibilgiler_id", grdIcerikler.SelectedRow.Cells[1].Text);
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
                    txtBaslik.Text = dtIcerik.Rows[0]["faydalibilgiler_basligi"].ToString();
                    txtSira.Text = dtIcerik.Rows[0]["sira"].ToString();
                    fckIcerik.Value = dtIcerik.Rows[0]["faydalibilgiler_icerigi"].ToString();
                    chkYayinda.Checked = Convert.ToBoolean(dtIcerik.Rows[0]["aktif"].ToString());
                }
            }
        }

        protected void btnYeni_Click(object sender, EventArgs e)
        {
            bosalt();
        }
        protected void btnKaydet_Click(object sender, EventArgs e)
        {
            
            if (grdIcerikler.SelectedIndex > -1)//seçili sayfa var güncelleme yapılacak
            {
                sdsIcerikler.UpdateParameters["faydalibilgiler_id"].DefaultValue = grdIcerikler.SelectedRow.Cells[1].Text;
                sdsIcerikler.UpdateParameters["sayfa_icerigi"].DefaultValue = fckIcerik.Value;
                if (sdsIcerikler.Update() > 0)
                {
                    lblMesaj.Text = "İçerik başarıyla güncellendi";
                    sdsIcerikler.DataBind();
                    grdIcerikler.DataBind();
                }
                else
                {
                    lblMesaj.Text = "Güncelleme işlemi tamamlanamadı";
                    //sdssayfalar.Delete();
                }
            }
            else// seçili sayfa yok ekleme yapılacak 
            {
                sdsIcerikler.InsertParameters["faydalibilgiler_icerigi"].DefaultValue = fckIcerik.Value;
                if (grdIcerikler.SelectedIndex > -1)//seçili sayfa var güncelleme yapılacak
                {
                    if (sdsIcerikler.Insert() > 0)
                    {
                        lblMesaj.Text = "İçerik başarıyla eklendi";
                        sdsIcerikler.DataBind();
                        grdIcerikler.DataBind();
                    }
                    else
                    {
                        lblMesaj.Text = "Ekleme işlemi tamamlanamadı";
                        //sdssayfalar.Delete();
                    }
                }
            }    
    }
        protected void btnSil_Click(object sender, EventArgs e)
        {
            
            if (grdIcerikler.SelectedIndex > -1)
            {
                sdsIcerikler.DeleteParameters["faydalibilgiler_id"].DefaultValue = grdIcerikler.SelectedRow.Cells[1].Text;
                if (sdsIcerikler.Delete() > 0)
                {
                    lblMesaj.Text = "İçerik başarıyla silindi";
                    bosalt();
                }
                else
                {
                    lblMesaj.Text = "Silme işlemi tamamlanamadı";
                    //sdssayfalar.Delete();
                }
            }
            else
            {
                lblMesaj.Text = "Lütfen silinecek içeriği seçiniz";
                return;
            }
        }
        private void bosalt()
        {
            txtBaslik.Text = "";
            txtSira.Text = "";
            fckIcerik.Value = "";
            chkYayinda.Checked = false;

            grdIcerikler.SelectedIndex = -1;
            txtBaslik.Focus();
        }

    }
}