using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ThuVienNhac
{
    public partial class edit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void FormViewEdit_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName=="Cancel")
            {
                Response.Redirect("default.aspx");
            }
        }

        protected void FormViewEdit_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            //ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Successfully');",true);

            Response.Write("<script>alert('edit successful');</script>");
            Response.Write("<script>alert('hehe');</script>");
        }
    }
}