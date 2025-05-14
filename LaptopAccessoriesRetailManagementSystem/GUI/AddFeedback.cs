using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using DTO;
using BLL;

namespace GUI
{
    public partial class AddFeedback : UserControl
    {
        private FeedbackBL feedbackBL;
        private string userId_by_OrderId;
        public AddFeedback()
        {
            InitializeComponent();
            dataGridView1.DataSource = new FeedbackBL().GetAllFeedbacks();
            feedbackBL = new FeedbackBL(); 
            LoadComboBox();
        }

        private void button1_Click(object sender, EventArgs e)
        { 
            try
            {
                int userId = int.Parse(userId_by_OrderId.ToString());
                int orderId = int.Parse(comboBoxOrderId.SelectedValue.ToString());

                string comment = txtComment.Text;
                DateTime createdAt = DateTime.Now;

                Feedback fb = new Feedback(0, userId, orderId, comment, createdAt);


                int result = feedbackBL.Add(fb);
                if (result > 0)
                {
                    MessageBox.Show("Thêm feedback thành công!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    dataGridView1.DataSource = new FeedbackBL().GetAllFeedbacks();
                }
                else
                {
                    MessageBox.Show("Không thêm được feedback.", "Lỗi", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Lỗi: " + ex.Message);
            }
        }
        public void LoadComboBox()
        {           
            OrderBL orderBL = new OrderBL();
            comboBoxOrderId.DataSource=orderBL.GetOrders();
            comboBoxOrderId.DisplayMember= "id";
            comboBoxOrderId.ValueMember = "id";
        }

        private void comboBoxOrderId_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (comboBoxOrderId.SelectedItem is Order selectedOrder)
            {
                label6.Text = "ID: " + selectedOrder.UserId.ToString(); // Hiển thị đơn giá
                userId_by_OrderId = selectedOrder.UserId.ToString();
            }
        }
    }
}
