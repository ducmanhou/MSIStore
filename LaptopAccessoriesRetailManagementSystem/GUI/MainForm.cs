using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace GUI
{
    public partial class MainForm : Form
    {
        public MainForm()
        {
            InitializeComponent();
            this.WindowState = FormWindowState.Maximized;
            AddUserControl(new AdminDashboard());
        }
       
      

        private void MainForm_Load(object sender, EventArgs e)
        {
            this.Enabled = false;
            this.Visible = false;
            login login = new login();

            DialogResult result = login.ShowDialog();
            if (result == DialogResult.OK)
            {
                this.Show();
                this.Enabled = true;

            }
            else
            {
                Application.Exit();
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        private void AddUserControl(UserControl userControl)
        {
            pnlMain.Controls.Clear();
            pnlMain.Controls.Add(userControl);  
            userControl.Dock= DockStyle.Fill;
            userControl.Show();
        }

        private void btnDashboard_Click(object sender, EventArgs e)
        {
            AddUserControl(new AdminDashboard());
        }

        private void button2_Click(object sender, EventArgs e)
        {
            AddUserControl(new AdminAddUsers());
        }

        private void button3_Click(object sender, EventArgs e)
        {
            AddUserControl(new AdminProduct());
        }

        private void button4_Click(object sender, EventArgs e)
        {
            AddUserControl(new AdminAddOrder());
        }

        private void button5_Click(object sender, EventArgs e)
        {
            AddUserControl(new AddFeedback());
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }
    }
}
