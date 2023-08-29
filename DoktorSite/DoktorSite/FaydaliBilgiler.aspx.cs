using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoktorSite
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["id"].ToString() != "") 
                { 
                    pnlSecilibilgi.Visible = true; pnlTumBilgiler.Visible = false;
                }//Secili bilgi var
            }
            catch (Exception)
            {
                pnlSecilibilgi.Visible = false; 
                pnlTumBilgiler.Visible = true; 
            }
            lblIP.Text = ipNedir();
        }
        protected string ipNedir()
        {
            string ipaddress;
            ipaddress = Context.Request.ServerVariables["HTTP_X_FORWARDED FOR"];
            if (ipaddress == "" || ipaddress == null)
                ipaddress = Context.Request.ServerVariables["REMOTE_ADDR"];
            return ipaddress;
        }

        protected void btnGonder_Click(object sender, EventArgs e)
        {
            if (sdsYorumlar.Insert() > 0)//mesaj veri tabanına eklendi
            {
                lblMesaj.Text = "Yorumunuz gönderildi, yönetici onayından sonra yayınlanacaktır";
                txtAdiSoyadi.Text = "";
                txtEposta.Text = "";
                txtMesaj.Text = "";
            }
            else
            {
                lblMesaj.Text = "Yorumunuz gönderilen bir hata olustu, lütfen daha sonra tekrar deneyin";
            }
        }

        protected void rptYorumlar_ItemCommand(object source, RepeaterCommandEventArgs e)
        {

        }
    }
}