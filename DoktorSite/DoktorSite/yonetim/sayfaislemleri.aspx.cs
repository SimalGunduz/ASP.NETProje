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
    public partial class sayfaislemleri : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSil_Click(object sender, EventArgs e)
        {
            
            if (grdSayfalar.SelectedIndex > -1)
            {
                sdsSayfalar.DeleteParameters["sayfa_id"].DefaultValue = grdSayfalar.SelectedRow.Cells[1].Text;
                if (sdsSayfalar.Delete() > 0)
                {
                    lblMesaj.Text = "Sayfa başarıyla silindi";
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
                lblMesaj.Text = "Lütfen silinecek sayfayı seçiniz";
                return;
            }
        }
        private void bosalt()
        {
            txtBaslik.Text = "";
            txtSira.Text = "";
            fckIcerik.Value = "";
            chkYayinda.Checked = false;

            ddlUst.DataBind();
            ddlUst.SelectedValue = null;

            grdSayfalar.SelectedIndex = -1;
            txtBaslik.Focus();
        }

        protected void btnYeni_Click(object sender, EventArgs e)
        {
            bosalt();
        }

        protected void btnKaydet_Click(object sender, EventArgs e)
        {
            
            if (grdSayfalar.SelectedIndex > -1)//seçili sayfa var güncelleme yapılacak
            {
                sdsSayfalar.UpdateParameters["sayfa_id"].DefaultValue = grdSayfalar.SelectedRow.Cells[1].Text;
                sdsSayfalar.UpdateParameters["sayfa_icerigi"].DefaultValue = fckIcerik.Value;
                if (sdsSayfalar.Update() > 0)
                {
                    lblMesaj.Text = "Sayfa başarıyla güncellendi";
                    sdsSayfalar.DataBind();
                    grdSayfalar.DataBind();
                }
                else
                {
                    lblMesaj.Text = "Güncelleme işlemi tamamlanamadı";
                    //sdssayfalar.Delete();
                }
            }
            else// seçili sayfa yok ekleme yapılacak 
            {
                sdsSayfalar.InsertParameters["sayfa_icerigi"].DefaultValue = fckIcerik.Value;
                if (grdSayfalar.SelectedIndex > -1)//seçili sayfa var güncelleme yapılacak
                {
                    if (sdsSayfalar.Insert() > 0)
                    {
                        lblMesaj.Text = "Sayfa başarıyla eklendi";
                        sdsSayfalar.DataBind();
                        grdSayfalar.DataBind();
                    }
                    else
                    {
                        lblMesaj.Text = "Ekleme işlemi tamamlanamadı";
                        //sdssayfalar.Delete();
                    }
                }
            }
        }

        protected void grdSayfalar_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (grdSayfalar.SelectedIndex > -1)//seçili sayfa var
            {
                SqlConnection baglanti = new SqlConnection(WebConfigurationManager.ConnectionStrings["doktorDBConnectionString"].ConnectionString);
                SqlDataAdapter dap= new SqlDataAdapter("select* from sayfalar where sayfa_id=@sayfa_id and silindi=0", baglanti);
                dap.SelectCommand.Parameters.AddWithValue("@sayfa_id", grdSayfalar.SelectedRow.Cells[1].Text); 
                DataTable dtIcerik = new DataTable();
                try
                {
                    baglanti.Open();
                    dap.Fill(dtIcerik); 
                    baglanti.Close();
                }
                catch (Exception)
                {}
                if (dtIcerik.Rows.Count>0)
                {
                    txtBaslik.Text = dtIcerik.Rows[0]["sayfa_basligi"].ToString();
                    txtSira.Text = dtIcerik.Rows[0]["sira"].ToString();
                    fckIcerik.Value = dtIcerik.Rows[0]["sayfa_icerigi"].ToString();
                    chkYayinda.Checked =Convert.ToBoolean( dtIcerik.Rows[0]["aktif"].ToString());

                    ddlUst.DataBind();
                    ddlUst.SelectedValue = dtIcerik.Rows[0]["ust_id"].ToString();

                }
            }
        }
    }
}