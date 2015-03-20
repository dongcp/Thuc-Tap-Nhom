using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PresentationLayer
{
    public partial class RM : Form
    {
        private static int state=1;

        public RM()
        {
            InitializeComponent();
            Initiate();
        }

        private void btnFood_Click(object sender, EventArgs e)
        {
            panelFood.Dock = DockStyle.Fill;
            panelFood.BringToFront();
            dgvFood.Height = 290;
            DisableButton(btnTable);
            DisableButton(btnPay);
            DisableButton(btnPrint);
            DisableButton(btnDetail);
            btnFood.BackColor = Color.Cyan;
            setToNormal(btnMenu, btnPromotion, btnStaff, btnBill, btnAccounting, btnBookTable);
            state = 1;
        }

        private void btnMenu_Click(object sender, EventArgs e)
        {
            panelMenu.Dock = DockStyle.Fill;
            panelMenu.BringToFront();
            dgvMenu.Height = 290;
            EnableButton(btnDetail);
            EnableButton(btnPrint);
            btnMenu.BackColor = Color.Cyan;
            setToNormal(btnFood, btnPromotion, btnStaff, btnBill, btnAccounting, btnBookTable);
            state = 2;
        }

        private void btnPromotion_Click(object sender, EventArgs e)
        {
            panelPromotion.Dock = DockStyle.Fill;
            panelPromotion.BringToFront();
            dgvPromotion.Height = 290;
            EnableButton(btnDetail);
            btnPromotion.BackColor = Color.Cyan;
            setToNormal(btnMenu, btnFood, btnStaff, btnBill, btnAccounting, btnBookTable);
            state = 3;
        }

        private void btnBill_Click(object sender, EventArgs e)
        {
            panelBill.Dock = DockStyle.Fill;
            panelBill.BringToFront();
            dgvBill.Height = 290;
            EnableButton(btnDetail);
            EnableButton(btnPrint);
            EnableButton(btnTable);
            EnableButton(btnPay);
            btnBill.BackColor = Color.Cyan;
            setToNormal(btnMenu, btnPromotion, btnStaff, btnFood, btnAccounting, btnBookTable);
            state = 4;
        }

        private void btnBookTable_Click(object sender, EventArgs e)
        {
            panelBookTable.Dock = DockStyle.Fill;
            panelBookTable.BringToFront();
            dgvBookTable.Height = 290;
            DisableButton(btnPrint);
            DisableButton(btnDetail);
            DisableButton(btnPay);
            EnableButton(btnTable);
            btnAccounting.BackColor = Color.Cyan;
            setToNormal(btnMenu, btnPromotion, btnStaff, btnBill, btnFood, btnAccounting);
            state = 5;
        }

        private void btnStaff_Click(object sender, EventArgs e)
        {
            panelStaff.Dock = DockStyle.Fill;
            panelStaff.BringToFront();
            dgvStaff.Height = 290;
            DisableButton(btnTable);
            DisableButton(btnPay);
            DisableButton(btnPrint);
            DisableButton(btnDetail);
            btnStaff.BackColor = Color.Cyan;
            setToNormal(btnMenu, btnPromotion, btnFood, btnBill, btnAccounting, btnBookTable);
            state = 6;
        }

        private void btnAccounting_Click(object sender, EventArgs e)
        {
            tlpAccounting.Dock = DockStyle.Fill;
            tlpAccounting.BringToFront();
            btnAccounting.BackColor = Color.Cyan;
            setToNormal(btnMenu, btnPromotion, btnStaff, btnBill, btnFood, btnBookTable);
            state = 7;
        }

        private void Initiate()
        {
            panelFood.Dock = DockStyle.Fill;
            panelFood.BringToFront();
            dgvFood.Height = 290;
            DisableButton(btnTable);
            DisableButton(btnPay);
            DisableButton(btnPrint);
            DisableButton(btnDetail);
            btnFood.BackColor = Color.Cyan;
        }

        private void EnableButton(Button btn)
        {
            btn.Enabled = true;
            btn.Visible = true;
        }

        private void DisableButton(Button btn)
        {
            btn.Enabled = false;
            btn.Visible = false;
        }

        private void setToNormal(Button btn1, Button btn2, Button btn3, Button btn4, Button btn5, Button btn6)
        {
            btn1.BackColor = Color.Transparent;
            btn2.BackColor = Color.Transparent;
            btn3.BackColor = Color.Transparent;
            btn4.BackColor = Color.Transparent;
            btn5.BackColor = Color.Transparent;
            btn6.BackColor = Color.Transparent;
        }

        private void btnClose_Click(object sender, EventArgs e)
        {
            this.Close();
            Application.Exit();
        }

        private void btnMinimize_Click(object sender, EventArgs e)
        {
            this.WindowState = FormWindowState.Minimized;
        }

        private void btnSize_Click(object sender, EventArgs e)
        {
            if(this.Size==Screen.PrimaryScreen.WorkingArea.Size)
            {
                this.WindowState = FormWindowState.Normal;
                btnSize.Image = new Bitmap("Icons\\Maximize_icon.png");
            }
            else
            {
                this.WindowState = FormWindowState.Maximized;
                btnSize.Image = new Bitmap("Icons\\Restore_icon.png");
            }
        }

        private void DisableGroupBox(GroupBox groupBox)
        {
            groupBox.Visible = false;
            groupBox.Enabled = false;
        }

        private void EnableGroupBox(GroupBox groupBox)
        {
            groupBox.Visible = true;
            groupBox.Enabled = true;
        }

        private void CloseFind(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            btn.Parent.Visible = false;
            btn.Parent.Enabled = false;
        }

        private void OpenFind(object sender, EventArgs e)
        {
            switch(state)
            {
                case 1:
                    EnableGroupBox(gbFindFood);
                    cbFind1.SelectedIndex = 0;
                    break;
                case 2:
                    EnableGroupBox(gbFind2);
                    cbFind2.SelectedIndex = 0;
                    break;
                case 3:
                    EnableGroupBox(gbFind3);
                    cbFind3.SelectedIndex = 0;
                    break;
                case 4:
                    EnableGroupBox(gbFind4);
                    cbFind4.SelectedIndex = 0;
                    break;
                case 5:
                    EnableGroupBox(gbFind5);
                    cbFind5.SelectedIndex = 0;
                    break;
                case 6:
                    EnableGroupBox(gbFind6);
                    cbFind6.SelectedIndex = 0;
                    break;
            }
        }

        private void FindSomething(object sender, EventArgs e)
        {

        }

        private void btnAdd_Click(object sender, EventArgs e)
        {

        }

        private void btnFix_Click(object sender, EventArgs e)
        {

        }

        private void btnDelete_Click(object sender, EventArgs e)
        {

        }

        private void btnDetail_Click(object sender, EventArgs e)
        {

        }

        private void btnPrint_Click(object sender, EventArgs e)
        {

        }

        private void btnTable_Click(object sender, EventArgs e)
        {

        }

        private void btnPay_Click(object sender, EventArgs e)
        {

        }

        private void ItemChange(object sender, EventArgs e)
        {
            ComboBox cb=(ComboBox)sender;
            switch(cb.Name)
            {
                case "cbFind1":
                    lbFind1.Text = cb.SelectedItem.ToString();
                    break;
                case "cbFind2":
                    switch(cb.SelectedIndex)
                    {
                        case 0:
                            lbFind2.Text = cb.SelectedItem.ToString();
                            txtFind2.Visible = true;
                            lbEnd.Visible = false;
                            dtpFindEndMenu.Visible = false;
                            dtpFindBeginMenu.Visible = false;
                            break;
                        case 1:
                            lbFind2.Text = cb.SelectedItem.ToString();
                            txtFind2.Visible = false;
                            lbEnd.Visible = true;
                            dtpFindEndMenu.Visible = true;
                            dtpFindBeginMenu.Visible = true;
                            break;
                    }
                    break;
                case "cbFind3":
                    switch(cb.SelectedIndex)
                    {
                        case 2:
                            txtFind3.Visible = false;
                            lbFind3.Text = "Từ";
                            dtpFindBeginPromotion.Visible = true;
                            dtpFindEndPromotion.Visible = true;
                            lbToPromotion.Visible=true;
                            break;
                        default:
                            txtFind3.Visible = true;
                            lbFind3.Text = cb.SelectedItem.ToString();
                            dtpFindBeginPromotion.Visible = false;
                            dtpFindEndPromotion.Visible = false;
                            lbToPromotion.Visible = false;
                            break;
                    }
                    break;
                case "cbFind4":
                    switch(cb.SelectedIndex)
                    {
                        case 2:
                            lbFind4.Text = "Từ";
                            txtFind4.Visible = false;
                            dtpFindBeginBill.Visible = true;
                            dtpFindBeginBill.Format = DateTimePickerFormat.Short;
                            dtpFindEndBill.Visible = true;
                            dtpFindEndBill.Format = DateTimePickerFormat.Short;
                            lbEndBill.Visible = true;
                            break;
                        case 3:
                            lbFind4.Text = "Từ";
                            txtFind4.Visible = false;
                            dtpFindBeginBill.Visible = true;
                            dtpFindBeginBill.Format = DateTimePickerFormat.Time;
                            dtpFindEndBill.Visible = true;
                            dtpFindEndBill.Format = DateTimePickerFormat.Time;
                            lbEndBill.Visible = true;
                            break;
                        default:
                            lbFind4.Text = cb.SelectedItem.ToString();
                            txtFind4.Visible = true;
                            dtpFindBeginBill.Visible = false;
                            dtpFindEndBill.Visible = false;
                            lbEndBill.Visible = false;
                            break;
                    }
                    break;
                case "cbFind5":

                    lbFind5.Text = cb.SelectedItem.ToString();
                    switch(cb.SelectedIndex)
                    {
                        case 5:
                            txtFind5.Visible = false;
                            dtpFind.Visible = true;
                            break;
                        default:
                            txtFind5.Visible = true;
                            dtpFind.Visible = false;
                            break;
                    }
                    break;
                case "cbFind6":
                    lbFind6.Text = cb.SelectedItem.ToString();
                    switch(cb.SelectedIndex)
                    {
                        case 3:
                            dtpFindBirthday.Visible = true;
                            txtFind6.Visible = false;
                            break;
                        default:
                            dtpFindBirthday.Visible = false;
                            txtFind6.Visible = true;
                            break;
                    }
                    break;
            }
        }
    }
}
