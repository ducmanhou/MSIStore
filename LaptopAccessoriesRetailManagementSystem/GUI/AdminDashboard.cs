using BLL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace GUI
{
    public partial class AdminDashboard : UserControl
    {
        public AdminDashboard()
        {
            InitializeComponent();
            LoadSoldProductsPieChart();
            OrderItemsBL bl = new OrderItemsBL();
            UserBL userBL = new UserBL();
            ProductBL productBL = new ProductBL();
            OrderBL orderBL = new OrderBL();
            int totalOrders=orderBL.CountOrders();
            int totalProducts = productBL.CountProducts();
         
            int totalUsers = userBL.CountAccounts();
            label5.Text = totalOrders.ToString();

            decimal totalRevenue = bl.GetTotalAmountFromDb();

            lblTotalRevenue.Text = totalRevenue.ToString();
            lblTodayRevenue.Text = totalProducts.ToString();
            lblTotalUsers.Text = totalUsers.ToString() ;
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void chartRevenue_Click(object sender, EventArgs e)
        {

        }
        private void LoadSoldProductsPieChart()
        {
            OrderItemsBL orderItemsBL = new OrderItemsBL();
            var soldProducts = orderItemsBL.GetAllSoldProducts();

            // Xoá dữ liệu cũ
            chart1.Series.Clear();
            chart1.ChartAreas.Clear();
            chart1.Titles.Clear();

            chart1.ChartAreas.Add("MainArea");

            Series series = new Series("Tỷ lệ sản phẩm bán ra");
            series.ChartType = SeriesChartType.Pie;

            // Hiển thị giá trị số lượng dưới dạng label
            series.IsValueShownAsLabel = true;

            foreach (var product in soldProducts)
            {
                series.Points.AddXY(product.ProductName, product.TotalSold);
            }

            chart1.Series.Add(series);

            chart1.Titles.Add("Biểu đồ hình tròn - Tỷ lệ sản phẩm đã bán");
        }

        private void lblTotalRevenue_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }
    }
}
