using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ThuVienNhac
{
    public partial class insert : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void FormInsert_PageIndexChanging(object sender, FormViewPageEventArgs e)
        {
           
        }

        protected void FormInsert_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Successfully');", true);
        }

        protected void FormInsert_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
                Response.Redirect("default.aspx");
        }
    }
}