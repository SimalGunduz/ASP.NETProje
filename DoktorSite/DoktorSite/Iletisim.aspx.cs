using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoktorSite
{
    public partial class Iletisim : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            lblIP.Text= ipNedir();
                       
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
            if (sdsMesajGonder.Insert() > 0)//mesaj veri tabanına eklendi
            {
                lblMesaj.Text = "Mesajınız gönderildi, ilginiz için teşekkürler";
                txtAdiSoyadi.Text = "";
                txtEposta.Text = "";
                txtKonu.Text = "";
                txtMesaj.Text = "";

                    
            }
            else
            {
                lblMesaj.Text = "Mesajınız gönderilen bir hata olustu, lütfen daha sonra tekrar deneyin";

            }
        }
    }
}