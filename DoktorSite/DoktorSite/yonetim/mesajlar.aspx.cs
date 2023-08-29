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
    public partial class mesajlar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {}
        protected void grdMesajlar_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (grdMesajlar.SelectedIndex > -1)//seçili sayfa var
            {
                SqlConnection baglanti = new SqlConnection(WebConfigurationManager.ConnectionStrings
                    ["doktorDBConnectionString"].ConnectionString);
                SqlDataAdapter dap = new SqlDataAdapter
                    ("select* from GelenMesajlar where mesaj_id=@mesaj_id and silindi=0", baglanti);
                dap.SelectCommand.Parameters.AddWithValue("@mesaj_id", grdMesajlar.SelectedRow.Cells[1].Text);
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
                    lblBaslik.Text = dtIcerik.Rows[0]["mesaj_basligi"].ToString();
                    ltrMesaj.Text = dtIcerik.Rows[0]["mesaj_icerigi"].ToString();
                    
                    lblGonderen.Text = dtIcerik.Rows[0]["ekleyen_adisoyadi"].ToString();
                    lblGonderenEPosta.Text = dtIcerik.Rows[0]["ekleyen_eposta"].ToString();

                    lblIP.Text = dtIcerik.Rows[0]["ekleyen_ip"].ToString();
                    lblTarih.Text = dtIcerik.Rows[0]["gonderilme_tarihi"].ToString();
                    chkCevaplandi.Checked = Convert.ToBoolean(dtIcerik.Rows[0]["cevaplandi"].ToString());
                }
            }
        }

        protected void btnKaydet_Click(object sender, EventArgs e)
        {
            sdsMesajlar.UpdateParameters["mesaj_id"].DefaultValue = grdMesajlar.SelectedRow.Cells[1].Text;
            if (sdsMesajlar.Update() > 0)
            {
                lblMesaj.Text = "Mesaj bilgisi güncellendi.";

            }
        }

        protected void btnSil_Click(object sender, EventArgs e)
        {
            sdsMesajlar.DeleteParameters["mesaj_id"].DefaultValue = grdMesajlar.SelectedRow.Cells[1].Text;
            if (sdsMesajlar.Delete() > 0)
            {
                lblMesaj.Text = "Mesaj silindi";
            }
        }
    }
}