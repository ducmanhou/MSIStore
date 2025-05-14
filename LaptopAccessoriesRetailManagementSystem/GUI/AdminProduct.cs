using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using BLL;
using DTO;
using QRCoder;

namespace GUI
{
    public partial class AdminProduct : UserControl
    {
        private ProductBL productBL;
        private BrandBL brandBL;
        private CategoryBL categoryBL;
        public AdminProduct()
        {
            InitializeComponent();
            productBL = new ProductBL();
            brandBL = new BrandBL();
            categoryBL = new CategoryBL();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
           
        }

        private void AdminProduct_Load(object sender, EventArgs e)
        {
            dataGridView1.DataSource = new ProductBL().GetProducts();
            comboBox1.DataSource= categoryBL.GetCategorys();
            comboBox1.DisplayMember = "Name";
            comboBox1.ValueMember = "id";

            comboBox2.DataSource = brandBL.GetBrands();
            comboBox2.DisplayMember = "Name";
            comboBox2.ValueMember = "id";
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string name = textBox1.Text;
            string discription = textBox2.Text;
            string detail= textBox3.Text;
            int oldprice = int.Parse(textBox4.Text);
            int newprice= int.Parse(textBox5.Text);
            int cateId = Convert.ToInt32(comboBox1.SelectedValue);
            int brandId = Convert.ToInt32(comboBox2.SelectedValue);
            Product product=new Product(name, discription, detail, oldprice, newprice, cateId, brandId);
            try
            {
                int num = productBL.Add(product);
                if (num > 0)
                {
                    dataGridView1.DataSource = new ProductBL().GetProducts();
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }

        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (dataGridView1.CurrentRow != null)
            {
                // Lấy id sản phẩm từ dòng được chọn
                int id = int.Parse(dataGridView1.CurrentRow.Cells["id"].Value.ToString());

                DialogResult result = MessageBox.Show(
                    $"Bạn có chắc muốn xóa sản phẩm: {id}?",
                    "Xác nhận xóa",
                    MessageBoxButtons.YesNo,
                    MessageBoxIcon.Warning);

                if (result == DialogResult.Yes)
                {
                    try
                    {
                        ProductBL productBL = new ProductBL();
                        int rowsAffected = productBL.Delete(id);

                        if (rowsAffected > 0)
                        {
                            MessageBox.Show("Xóa sản phẩm thành công!");
                            dataGridView1.DataSource = productBL.GetProducts(); // Load lại danh sách
                        }
                        else
                        {
                            MessageBox.Show("Không tìm thấy sản phẩm để xóa.");
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
                MessageBox.Show("Vui lòng chọn sản phẩm cần xóa.");
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim();
            List<Product> results = productBL.SearchProductsByName(keyword);
            dataGridView1.DataSource = results;
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = dataGridView1.Rows[e.RowIndex];
                int id = int.Parse(row.Cells["id"].Value.ToString()); // đúng kiểu int
                textBox6.Text = id.ToString();
                textBox6.ReadOnly = true;
                textBox1.Text = row.Cells["Name"].Value.ToString();
                textBox2.Text = row.Cells["Description"].Value.ToString();
                textBox3.Text = row.Cells["Detail"].Value.ToString();
                textBox4.Text = row.Cells["Oldprice"].Value.ToString();
                textBox5.Text = row.Cells["Newprice"].Value.ToString();

                int selectedCategoryId = Convert.ToInt32(row.Cells["CateId"].Value);
                comboBox1.SelectedValue = selectedCategoryId;

                int selectedBrandId = Convert.ToInt32(row.Cells["BrandId"].Value);
                comboBox2.SelectedValue = selectedBrandId;


                //tao qr
                QRCoder.QRCodeGenerator qr = new QRCoder.QRCodeGenerator();
                var qr1 = qr.CreateQrCode(textBox1.Text, QRCodeGenerator.ECCLevel.H);
                var code = new QRCode(qr1);
                pictureBox1.Image = code.GetGraphic(10);
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            string name = textBox1.Text;
            string description = textBox2.Text;
            string detail = textBox3.Text;
            int cateId = Convert.ToInt32(comboBox1.SelectedValue);
            int brandId = Convert.ToInt32(comboBox2.SelectedValue);
            int id = int.Parse(textBox6.Text.ToString());
            if (!int.TryParse(textBox4.Text, out int oldprice) || !int.TryParse(textBox5.Text, out int newprice))
            {
                MessageBox.Show("Giá không hợp lệ.");
                return;
            }

            Product product = new Product(id, name, description, detail, oldprice, newprice, cateId, brandId);

            try
            {
                int result = productBL.Update(product);
                if (result > 0)
                {
                    MessageBox.Show("Cập nhật sản phẩm thành công!");
                    dataGridView1.DataSource = productBL.GetProducts();
                    ClearForm();
                }
                else
                {
                    MessageBox.Show("Không tìm thấy sản phẩm để cập nhật.");
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
            textBox3.Text = "";
            textBox4.Text = "";
            textBox5.Text = "";
            textBox1.ReadOnly = false;
        }
    }
}
