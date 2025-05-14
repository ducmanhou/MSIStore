using BLL;
using DTO;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Drawing.Text;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace GUI
{
    public partial class AdminAddUsers : UserControl
    {
        private UserBL userBL;
        public AdminAddUsers()
        {
            
            InitializeComponent();
            userBL = new UserBL();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        private void AdminAddUsers_Load(object sender, EventArgs e)
        {
            dataGridView1.DataSource = new UserBL().GetAccounts_ID();
            dataGridView1.BackgroundColor = Color.White;

            // Tắt màu dòng xen kẽ
            dataGridView1.RowsDefaultCellStyle.BackColor = Color.White;
            dataGridView1.AlternatingRowsDefaultCellStyle.BackColor = Color.White;

            // Màu chữ (tùy chỉnh nếu muốn)
            dataGridView1.DefaultCellStyle.ForeColor = Color.Black;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string user=textBox1.Text;
            string pass=textBox2.Text;
            Account account=new Account(user, pass);
            try
            {
                int num = userBL.Add(account);
                if (num > 0)
                {
                    dataGridView1.DataSource = new UserBL().GetAccounts_ID();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

            
        }

        private void btndelete_Click(object sender, EventArgs e)
        {
            // Kiểm tra xem đã chọn dòng nào chưa
            if (dataGridView1.CurrentRow != null)
            {
                // Lấy giá trị Username từ dòng được chọn
                string username = dataGridView1.CurrentRow.Cells["Username"].Value.ToString();

                // Hỏi xác nhận
                DialogResult result = MessageBox.Show(
                    "Bạn có chắc muốn xóa người dùng: " + username + "?",
                    "Xác nhận xóa",
                    MessageBoxButtons.YesNo,
                    MessageBoxIcon.Warning);

                if (result == DialogResult.Yes)
                {
                    try
                    {
                        int rowsAffected = userBL.Delete(username);

                        if (rowsAffected > 0)
                        {
                            MessageBox.Show("Xóa thành công!");
                            dataGridView1.DataSource = userBL.GetAccounts_ID(); // Load lại dữ liệu
                        }
                        else
                        {
                            MessageBox.Show("Không tìm thấy người dùng để xóa.");
                        }
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Lỗi khi xóa: " + ex.Message);
                    }
                }
            }
            else
            {
                MessageBox.Show("Vui lòng chọn người dùng cần xóa.");
            }
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            {
                if (e.RowIndex >= 0)
                {
                    DataGridViewRow row = dataGridView1.Rows[e.RowIndex];
                    textBox1.Text = row.Cells["Username"].Value.ToString();
                    textBox2.Text = row.Cells["Password"].Value.ToString();
                    textBox1.ReadOnly = true; // Không cho sửa Username
                }
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string user = textBox1.Text.Trim();
            string pass = textBox2.Text.Trim();

            if (string.IsNullOrEmpty(user) || string.IsNullOrEmpty(pass))
            {
                MessageBox.Show("Vui lòng nhập đầy đủ thông tin.");
                return;
            }

            Account account = new Account(user, pass);

            try
            {
                int result = userBL.Update(account);
                if (result > 0)
                {
                    MessageBox.Show("Cập nhật thành công!");
                    dataGridView1.DataSource = userBL.GetAccounts_ID(); // Làm mới danh sách
                    ClearForm();
                }
                else
                {
                    MessageBox.Show("Không tìm thấy người dùng để cập nhật.");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi khi cập nhật: " + ex.Message);
            }
        }
        private void ClearForm()
        {
            textBox1.Text = "";
            textBox2.Text = "";
            textBox1.ReadOnly = false;
        }
    }
}
