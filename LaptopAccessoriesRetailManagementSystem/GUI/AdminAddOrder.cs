using BLL;
using DTO;
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
using static System.Windows.Forms.VisualStyles.VisualStyleElement.TaskbarClock;
using QRCoder;
using AForge;
using AForge.Video.DirectShow;
using ZXing;
using AForge.Video;

namespace GUI
{
    public partial class AdminAddOrder : UserControl
    {
        private OrderItemsBL orderItemsBL;
        private OrderBL orderBL;
        private UserBL userBL;
        private List<OrderItems> tempOrderList = new List<OrderItems>();
        FilterInfoCollection filterInfoCollection;
        VideoCaptureDevice captureDevice;
        public AdminAddOrder()
        {

            InitializeComponent();
            orderItemsBL = new OrderItemsBL();
            orderBL = new OrderBL();
            userBL = new UserBL();
        }
        private void LoadProductsIntoComboBox()
        {
            try
            {
                // Gọi phương thức từ ProductBL để lấy danh sách sản phẩm
                ProductBL productBL = new ProductBL();
                List<Product> products = productBL.GetProducts(); // Lấy tất cả sản phẩm

                // Cài đặt các thuộc tính DisplayMember và ValueMember cho ComboBox
                comboBoxProducts.DisplayMember = "Name";  // Hiển thị tên sản phẩm
                comboBoxProducts.ValueMember = "id";    // Có thể dùng ProductId nếu muốn lưu giá trị ProductId
                comboBoxProducts.DataSource = products;   // Gán danh sách sản phẩm vào ComboBox

            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi khi tải danh sách sản phẩm: " + ex.Message);
            }
        }
        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            //if (dataGridView1.CurrentRow != null)
            //{
            //    int orderId=
            //}
        }
        private void comboBoxProducts_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBoxProducts.SelectedItem is Product selectedProduct)
            {
                label1.Text = selectedProduct.NewPrice.ToString(); // Hiển thị đơn giá
            }

        }

        private void AdminAddOrder_Load(object sender, EventArgs e)
        {
            LoadProductsIntoComboBox();
            LoadData();
            dataGridView1.DataSource = new OrderBL().GetOrders();
            comboBox_UserID.DataSource = userBL.GetAccounts_ID();
            comboBox_UserID.DisplayMember = "username";
            comboBox_UserID.ValueMember = "id";
            filterInfoCollection = new FilterInfoCollection(FilterCategory.VideoInputDevice);
            foreach (FilterInfo filterInfo in filterInfoCollection)
            {
                comboBox1.Items.Add(filterInfo.Name);
            }
            comboBox1.SelectedIndex = 0;

        }
        private void LoadData()
        {
            try
            {
                // Lấy dữ liệu từ BLL
                var orderItemsList = orderItemsBL.GetOrderItems();

                // Binding dữ liệu vào DataGridView
                dataGridView2.DataSource = orderItemsList;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi khi load dữ liệu: " + ex.Message);
            }
        }



        private void dataGridView2_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            int UserId;
            UserId = int.Parse(comboBox_UserID.SelectedValue.ToString());
            Order order = new Order(UserId);

            try
            {
                int num = orderBL.Add(order);

                if (num > 0)
                {
                    // Cập nhật DataGridView toàn bộ đơn hàng từ DB
                    dataGridView1.DataSource = orderBL.GetOrders();
                    dataGridView2.DataSource = orderItemsBL.GetOrderItems();
                
                }
            }
            catch (SqlException ex)
            {
                MessageBox.Show("Lỗi khi thêm đơn hàng: " + ex.Message);
            }
 
        }

        private void printDocument1_PrintPage(object sender, System.Drawing.Printing.PrintPageEventArgs e)
        {
            Font font = new Font("Arial", 12);
            int startX = 10;
            int startY = 20;
            int offsetY = 30;

            // Lấy danh sách sản phẩm từ ProductBL
            ProductBL productBL = new ProductBL();
            List<Product> productList = productBL.GetProducts();

            // Tiêu đề hóa đơn
            e.Graphics.DrawString("HÓA ĐƠN BÁN HÀNG", new Font("Arial", 16, FontStyle.Bold), Brushes.Black, startX, startY);
            startY += offsetY + 10;

            // Tiêu đề các cột
            e.Graphics.DrawString("Tên SP", font, Brushes.Black, startX, startY);
            e.Graphics.DrawString("Số lượng", font, Brushes.Black, startX + 200, startY);
            e.Graphics.DrawString("Đơn giá", font, Brushes.Black, startX + 320, startY);
            e.Graphics.DrawString("Thành tiền", font, Brushes.Black, startX + 440, startY);
            startY += offsetY;

            decimal tongTien = 0;

            foreach (var item in tempOrderList)
            {
                string productName = "Không tìm thấy";

                // Tìm tên sản phẩm từ productList
                var product = productList.FirstOrDefault(p => p.Id == item.ProductId);
                if (product != null)
                {
                    productName = product.Name;
                }

                int sl = item.Quatity;
                decimal gia = item.UnitPrice;
                decimal thanhTien = sl * gia;
                tongTien += thanhTien;

                e.Graphics.DrawString(productName, font, Brushes.Black, startX, startY);
                e.Graphics.DrawString(sl.ToString(), font, Brushes.Black, startX + 200, startY);
                e.Graphics.DrawString(gia.ToString("N0"), font, Brushes.Black, startX + 320, startY);
                e.Graphics.DrawString(thanhTien.ToString("N0"), font, Brushes.Black, startX + 440, startY);

                startY += offsetY;
            }

            // Tổng tiền
            startY += 20;
            e.Graphics.DrawString("Tổng tiền: " + tongTien.ToString("N0") + " VNĐ", new Font("Arial", 14, FontStyle.Bold), Brushes.Black, startX, startY);
        }
        private void button2_Click(object sender, EventArgs e)
        {
            if (tempOrderList.Count == 0)
            {
                MessageBox.Show("Không có dữ liệu để in.");
                return;
            }

            printPreviewDialog1.Document = printDocument1;
            printPreviewDialog1.ShowDialog(); 
        }

        private void dataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = dataGridView1.Rows[e.RowIndex];
                int OrderId = int.Parse(row.Cells["id"].Value.ToString()); // đúng kiểu int
                txtOrderID.Text = row.Cells["id"].Value.ToString();
                txtOrderID.ReadOnly = true;
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            int OrderId = int.Parse(txtOrderID.Text);
            int quantity = int.Parse(txtquantity.Text);
            int productid = int.Parse(comboBoxProducts.SelectedValue.ToString());
            int unitprice=int.Parse(label1.Text);
            OrderItems orderItem = new OrderItems(quantity, OrderId, productid, unitprice);
            try
            {
                int num=orderItemsBL.Add(orderItem);
                if (num > 0)
                {
                    dataGridView2.DataSource = orderItemsBL.GetOrderItems();
                    tempOrderList.Add(orderItem);
                    dataGridView3.DataSource = null; // reset binding
                    dataGridView3.DataSource = tempOrderList;
                }
            }
            catch (SqlException ex)
            {
                throw ex;
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            captureDevice = new VideoCaptureDevice(filterInfoCollection[comboBox1.SelectedIndex].MonikerString);
            captureDevice.NewFrame += VideoCaptureDevice_NewFrame;
            captureDevice.Start();
        }
        private void VideoCaptureDevice_NewFrame(object sender, NewFrameEventArgs eventArgs)
        {
            Bitmap bitmap = (Bitmap)eventArgs.Frame.Clone();
            BarcodeReader reader = new BarcodeReader();
            var result = reader.Decode(bitmap);

            if (result != null)
            {
                string qrValue = result.Text;

                comboBoxProducts.Invoke(new MethodInvoker(delegate ()
                {
                    int index = comboBoxProducts.FindStringExact(qrValue);
                    if (index != -1)
                    {
                        comboBoxProducts.SelectedIndex = index;
                        //MessageBox.Show("Quét thành công");
                    }
                    else
                    {
                        MessageBox.Show($"Sản phẩm có ten '{qrValue}' không có trong danh sách.", "Không tìm thấy", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    }
                }));
            }

            pictureBox1.Image = bitmap;
        }

        private void button5_Click(object sender, EventArgs e)
        {
            tempOrderList.Clear();
            dataGridView3.DataSource = null;
        }

        private void comboBox_UserID_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBox_UserID.SelectedItem is Account selectedUser)
            {
                label12.Text = "ID: " + selectedUser.Id.ToString(); // Hiển thị đơn giá
            }
        }
    }
}
