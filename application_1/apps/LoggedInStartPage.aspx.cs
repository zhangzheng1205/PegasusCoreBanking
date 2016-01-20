using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using InterLinkClass.CoreBankingApi;

public partial class Admin : System.Web.UI.Page
{
    BankUser user;
    Bussinesslogic bll = new Bussinesslogic();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["User"] == null)
            {
                Response.Redirect("Default.aspx");
            }
            else 
            {
                user = (BankUser)Session["User"];
                lblUsername.Text = user.FullName;
            }
            
        }
        catch (NullReferenceException exe)
        {
            Response.Redirect("Default.aspx?login=1", false);
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblUsername, ex.Message, true);
        }
    }
    
}
