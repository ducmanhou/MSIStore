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
using System.Data.SqlClient;

namespace GUI
{
    public partial class login : Form
    {
        private LoginBL loginBL;

        public login()
        {
            this.StartPosition = FormStartPosition.CenterScreen;
            InitializeComponent();
            loginBL =new LoginBL();
        }
        private bool UserLogin(Account account)
        {
            try
            {
                return (loginBL.Login(account));
            }
            catch (SqlException ex)
            {

                MessageBox.Show(ex.Message);
            }
            return true;
        }



        private void btncancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void btnlogin_Click(object sender, EventArgs e)
        {
            string user, pass;
            user=txtusername.Text.Trim();
            pass=txtpass.Text.Trim();
            Account acc = new Account(user, pass);
            if (UserLogin(acc))
            {
                this.DialogResult = DialogResult.OK;
            }
            else
            {
                DialogResult result = MessageBox.Show("Sai ten dang nhap va mat khau", "Login", MessageBoxButtons.RetryCancel, MessageBoxIcon.Error);
                if (result == DialogResult.Retry)
                {
                    this.txtusername.Clear();
                    this.txtpass.Clear();

                    this.txtusername.Focus();
                }
                else
                {
                    this.DialogResult = DialogResult.Cancel;
                }
            }
        }

        private void login_Load(object sender, EventArgs e)
        {

        }

        private void checkshowpass_CheckedChanged(object sender, EventArgs e)
        {
            if (checkshowpass.Checked)
            {
                txtpass.PasswordChar = '\0';
            }
            else { txtpass.PasswordChar='*'; }
        }
    }
}

