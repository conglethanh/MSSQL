using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Configuration;
using System.Data.SqlClient;
namespace Revision_WiF
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();

        }
        SqlConnection con;
        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void trangChủToolStripMenuItem_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Đây là trang chủ quản lí Sản phẩm", "Trang chủ", MessageBoxButtons.OK, MessageBoxIcon.Information);
        }

        private void thôngTinToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Form2 f2 = new Form2();
            f2.ShowDialog();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            string conString = ConfigurationManager.ConnectionStrings["QuanLySP"].ConnectionString.ToString();
            con = new SqlConnection(conString);

            con.Open();


            HienThi();
            if (txtmasp.Text == "")
            {
                btnThem.Enabled = false;
                btnSua.Enabled = false;
                btnXoa.Enabled = false;
            }
            timer1.Start();

            cbxSearch.Text = "";
        }

        public void HienThi()
        {
            try
            {
                string sql = "select* from sanpham";
                SqlCommand cmd = new SqlCommand(sql, con);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataSet da = new DataSet();
                adapter.Fill(da);
                if (da.Tables.Count > 0)
                {
                    thongTinSp.DataSource = da.Tables[0];

                    thongTinSp.CurrentRow.Selected = true;
                    thongTinSp.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
                    thongTinSp.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCells;

                    cbxSearch.DataSource = da.Tables[0];
                    cbxSearch.DisplayMember = "tenSP";
                    cbxSearch.ValueMember = "maSP";
                
                }
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Lỗi" + ex.Message.ToString(), "Báo Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            con.Close();
        }

        private void thongTinSp_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void btnThem_Click(object sender, EventArgs e)
        {
            try
            {

                string sqlThem = "insert into Sanpham values (@maSP, @tenSp,@soluong,@sdt)";
                SqlCommand cmd = new SqlCommand(sqlThem, con);
                cmd.Parameters.AddWithValue("maSP", txtmasp.Text);
                cmd.Parameters.AddWithValue("tenSP", txttensp.Text);
                cmd.Parameters.AddWithValue("soluong", txtsoluong.Text);
                cmd.Parameters.AddWithValue("sdt", txtsdt.Text);
                cmd.ExecuteNonQuery();

                HienThi();
                txtReset();
            }
            catch(SqlException ex)
            {

                MessageBox.Show("Lỗi: " + ex.Message.ToString(), "Báo Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        public void txtReset()
        {
            txtmasp.Text = "";
            txtsdt.Text = "";
            txttensp.Text = "";
            txtsoluong.Text = "";
        }
        private void timer1_Tick(object sender, EventArgs e)
        {
            if (txtmasp.Text != "")
            {
                btnThem.Enabled = true;
                btnSua.Enabled = true;
                btnXoa.Enabled = true;
            }
            else
            {
                btnThem.Enabled = false;
                btnSua.Enabled = false;
                btnXoa.Enabled = false;
            }
        }

        private void btnSua_Click(object sender, EventArgs e)
        {
            string sqlSua = "update sanpham set tenSP=@tenSP, soLuong=@soluong,soDienThoai=@sdt where maSP=@maSP";
            SqlCommand cmd = new SqlCommand(sqlSua, con);
            cmd.Parameters.AddWithValue("maSP", txtmasp.Text);
            cmd.Parameters.AddWithValue("tenSP", txttensp.Text);
            cmd.Parameters.AddWithValue("soluong", txtsoluong.Text);
            cmd.Parameters.AddWithValue("sdt", txtsdt.Text);
            cmd.ExecuteNonQuery();

            HienThi();
            txtReset();
        }

        private void btnXoa_Click(object sender, EventArgs e)
        {
            string sqlXoa = "delete from sanpham where maSP=@maSP";
            SqlCommand cmd = new SqlCommand(sqlXoa, con);
            cmd.Parameters.AddWithValue("maSP", txtmasp.Text);
            cmd.Parameters.AddWithValue("tenSP", txttensp.Text);
            cmd.Parameters.AddWithValue("soluong", txtsoluong.Text);
            cmd.Parameters.AddWithValue("sdt", txtsdt.Text);
            cmd.ExecuteNonQuery();

            HienThi();
            txtReset();
        }

        private void thongTinSp_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            try
            {
                int index = e.RowIndex;
                DataGridViewRow selectedRow = thongTinSp.Rows[index];
                txtmasp.Text = selectedRow.Cells[0].Value.ToString();
                txttensp.Text = selectedRow.Cells[1].Value.ToString();
                txtsoluong.Text = selectedRow.Cells[2].Value.ToString();
                txtsdt.Text = selectedRow.Cells[3].Value.ToString();
            }
            catch(SqlException ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message.ToString(), "Báo lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            string sqlSearch = "timSP";
            SqlCommand cmd = new SqlCommand(sqlSearch, con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("masp", SqlDbType.NVarChar)).Value = cbxSearch.SelectedValue.ToString();

            cmd.ExecuteNonQuery();
            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataSet da = new DataSet();
            adapter.Fill(da);
            thongTinSp.DataSource = da.Tables[0];
        }

        private void cbxSearch_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
