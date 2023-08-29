using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DoktorSite.yonetim
{
    public partial class YorumIslemleri : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        protected void grdYorumlar_SelectedIndexChanged(object sender, EventArgs e)
        {
            sdsYorumlar.UpdateParameters["yorum_id"].DefaultValue = grdYorumlar.SelectedRow.Cells[1].Text;
            sdsYorumlar.Update();
            sdsYorumlar.DataBind();
            grdYorumlar.DataBind();
        }
    }
}