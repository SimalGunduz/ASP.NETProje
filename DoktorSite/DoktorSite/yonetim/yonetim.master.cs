using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoktorSite.yonetim
{
    public partial class yonetim : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["yonetici_adi"].ToString().Trim() != "")
                {
                    lblKullaniciAdi.Text = Session["yonetici_adi"].ToString();
                }
            }
            catch
            {
                Response.Redirect("../giris.aspx");
            }
        }

        protected void btnCikis_Click(object sender, EventArgs e)
        {
            Session.RemoveAll(); 
            Session.Abandon();
            FormsAuthentication.SignOut();
            Response.Redirect("yonetim/Default.aspx");
        }
    }
}