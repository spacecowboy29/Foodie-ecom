using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Foodie.User
{
    public partial class Payment : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader dr;
        DataTable dt;
        SqlTransaction transaction = null;
        string _name = string.Empty; string _cardNo = string.Empty; string _expiryDate = string.Empty; string _cvv = string.Empty;
        string _address = string.Empty; string _paymentMode = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userId"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    if (Session["grandTotalPrice"] != null)
                    {
                        decimal orderTotal = Convert.ToDecimal(Session["grandTotalPrice"]);
                        orderTotalHidden.Value = orderTotal.ToString();
                    }
                }
            }
        }

        protected void lbCardSubmit_Click(object sender, EventArgs e)
        {
            _name = txtName.Text.Trim();
            _cardNo = txtCardNo.Text.Trim();
            _cardNo = $"************{_cardNo.Substring(12, 4)}";
            _expiryDate = txtExpMonth.Text.Trim() + "/" + txtExpYear.Text.Trim();
            _cvv = txtCvv.Text.Trim();
            _address = txtAddress.Text.Trim();
            _paymentMode = "card";
            if (Session["userId"] != null)
            {
                OrderPayment(_name, _cardNo, _expiryDate, _cvv, _address, _paymentMode);
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void lbCodSubmit_Click(object sender, EventArgs e)
        {
            _address = txtCODAddress.Text.Trim();
            _paymentMode = "cod";
            if (Session["userId"] != null)
            {
                OrderPayment(_name, _cardNo, _expiryDate, _cvv, _address, _paymentMode);
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        void OrderPayment(string name, string cardNo, string expiryDate, string cvv, string address, string paymentMode)
        {
            int paymentId; int productId; int quantity;
            dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[7] 
            {
                new DataColumn("OrderNo", typeof(string)),
                new DataColumn("ProductId", typeof(int)),
                new DataColumn("Quantity", typeof(int)),
                new DataColumn("UserId", typeof(int)),
                new DataColumn("Status", typeof(string)),
                new DataColumn("PaymentId", typeof(int)),
                new DataColumn("OrderDate", typeof(DateTime)),
            });
            con = new SqlConnection(Connection.GetConnectionString());
            con.Open();
            transaction = con.BeginTransaction();

            try
            {
                // Save Payment
                cmd = new SqlCommand("Save_Payment", con, transaction);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@CardNo", cardNo);
                cmd.Parameters.AddWithValue("@ExpiryDate", expiryDate);
                cmd.Parameters.AddWithValue("@Cvv", cvv);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@PaymentMode", paymentMode);
                cmd.Parameters.Add("@InsertedId", SqlDbType.Int);
                cmd.Parameters["@InsertedId"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                paymentId = Convert.ToInt32(cmd.Parameters["@InsertedId"].Value);

                //Getting Cart Items       
                DataTable cartItems = new DataTable();
                cmd = new SqlCommand("Cart_Crud", con, transaction);
                cmd.Parameters.AddWithValue("@Action", "SELECT");
                cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(cartItems);
     
                    // Update Product Quantity and Delete Cart Items
                    foreach (DataRow row in cartItems.Rows)
                    {
                        productId = (int)row["ProductId"];
                        quantity = (int)row["Quantity"];

                        UpdateQuantity(productId, quantity, transaction, con);
                        DeleteCartItem(productId, transaction, con);

                        dt.Rows.Add(Utils.GetUniqueId(), productId, quantity, (int)Session["userId"], "Pending", paymentId, DateTime.Now);
                    }

                    // Save Orders
                    if (dt.Rows.Count > 0)
                    {
                        cmd = new SqlCommand("Save_Orders", con, transaction);
                        cmd.Parameters.AddWithValue("@tblOrders", dt);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.ExecuteNonQuery();
                    }

                    transaction.Commit();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Your Item Ordered Successfully!";
                    lblMsg.CssClass = "alert alert-success";
                    Response.AddHeader("REFRESH", "1;URL=Invoice.aspx?id=" + paymentId);

                }
            catch (Exception e)
            {
                try
                {
                    transaction.Rollback();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script>");
                }
                Response.Write("<script>alert('" + e.Message + "');</script>");
            }
            finally
            {
                con.Close();
            }
        }

        void UpdateQuantity(int _productId, int _quantity, SqlTransaction sqlTransaction, SqlConnection sqlConnection)
        {
            int dbQuantity;
            cmd = new SqlCommand("Product_Crud", sqlConnection, sqlTransaction);
            cmd.Parameters.AddWithValue("@Action", "GETBYID");
            cmd.Parameters.AddWithValue("@ProductId", _productId);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    dbQuantity = (int)dr["Quantity"];
                    dr.Close();

                    if (dbQuantity > _quantity && dbQuantity > 2)
                    {
                        dbQuantity -= dbQuantity - _quantity;
                        cmd = new SqlCommand("Product_Crud", sqlConnection, sqlTransaction);
                        cmd.Parameters.AddWithValue("@Action", "QTYUPDATE");
                        cmd.Parameters.AddWithValue("@Quantity", dbQuantity);
                        cmd.Parameters.AddWithValue("@ProductId", _productId);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.ExecuteNonQuery();
                    }
                }
                else
                {
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                if (!dr.IsClosed) dr.Close();
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void lbPayPalSubmit_Click(object sender, EventArgs e)
        {
            _name = hiddenPayerName.Value.Trim();
            _address = txtPaypalAddress.Text.Trim();
            _paymentMode = "paypal";
            if (Session["userId"] != null)
            {
                OrderPayment(_name, _cardNo, _expiryDate, _cvv, _address, _paymentMode);
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        void DeleteCartItem(int _productId, SqlTransaction sqlTransaction, SqlConnection sqlConnection)
        {
            cmd = new SqlCommand("Cart_Crud", sqlConnection, sqlTransaction);
            cmd.Parameters.AddWithValue("@Action", "DELETE");
            cmd.Parameters.AddWithValue("@ProductId", _productId);
            cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }
    }
}