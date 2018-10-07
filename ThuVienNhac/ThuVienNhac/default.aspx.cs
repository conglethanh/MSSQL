using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;
namespace ThuVienNhac
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        SqlConnection con;
        protected void btnXemBaiHat_Click(object sender, EventArgs e)
        {
            hl_insert.Visible = true;
            
            string conString = WebConfigurationManager.ConnectionStrings["QLNhacConnectionString"].ConnectionString.ToString();

            con = new SqlConnection(conString);
            con.Open();
            string sqlquery = "dsBaiHatCuaTheLoai";
            SqlCommand cmd = new SqlCommand(sqlquery, con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("matheloai", SqlDbType.Int)).Value = ddl_theloai.SelectedItem.Value;

            cmd.ExecuteNonQuery();
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);

            DataSet da = new DataSet();
            adapter.Fill(da);

            grid_danhsachBaihat.DataSource = da.Tables[0];
            grid_danhsachBaihat.DataBind();

            con.Close();
        }

        protected void grid_danhsachBaihat_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void grid_danhsachBaihat_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName=="Select")
            {
                Int32 num = Convert.ToInt32(e.CommandArgument);
                txtMaBH.Text = HttpUtility.HtmlDecode(grid_danhsachBaihat.Rows[num].Cells[2].Text);
                txtTenBH.Text = HttpUtility.HtmlDecode(grid_danhsachBaihat.Rows[num].Cells[3].Text);
                txtCaSi.Text = HttpUtility.HtmlDecode(grid_danhsachBaihat.Rows[num].Cells[4].Text);
            }
        }
        void HienThi()
        {
            hl_insert.Visible = true;
            
            string conString = WebConfigurationManager.ConnectionStrings["QLNhacConnectionString"].ConnectionString.ToString();

            con = new SqlConnection(conString);
            con.Open();
            string sqlquery = "dsBaiHatCuaTheLoai";
            SqlCommand cmd = new SqlCommand(sqlquery, con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("matheloai", SqlDbType.Int)).Value = ddl_theloai.SelectedItem.Value;

            cmd.ExecuteNonQuery();
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);

            DataSet da = new DataSet();
            adapter.Fill(da);

            grid_danhsachBaihat.DataSource = da.Tables[0];
            grid_danhsachBaihat.DataBind();

            con.Close();
        }
        void deleteBH(int rowIndex)
        {
            txtMaBH.Text = HttpUtility.HtmlDecode(grid_danhsachBaihat.Rows[rowIndex].Cells[2].Text);

            string conString = WebConfigurationManager.ConnectionStrings["QLNhacConnectionString"].ConnectionString.ToString();

            con = new SqlConnection(conString);
            con.Open();
            string sqlquery = "delete from baihat where baihat.ma_baihat=@mabh";
            SqlCommand cmd = new SqlCommand(sqlquery, con);

            cmd.Parameters.AddWithValue("mabh",txtMaBH.Text);

            cmd.ExecuteNonQuery();
            
            con.Close();
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void grid_danhsachBaihat_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
                deleteBH(e.RowIndex);
                HienThi();
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('Successfully');", true);
        }

        protected void grid_danhsachBaihat_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void grid_danhsachBaihat_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {

        }

        protected void grid_danhsachBaihat_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void ListView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnedit_Click(object sender, EventArgs e)
        {

            Response.Redirect("edit.aspx?id="+txtMaBH.Text);
        }

      
    }
}