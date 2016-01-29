using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Statement : System.Web.UI.Page
{
    Bussinesslogic bll = new Bussinesslogic();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            DataTable dt = Session["StatementDataTable"] as DataTable;
            dataGridResults.DataSource = dt;
            dataGridResults.DataBind();
            dataGridResults.AllowPaging = false;
            Session["IsError"] = null;
        }
        catch (Exception ex)
        {
            bll.ShowMessage(lblmsg, ex.Message, true, Session);
        }
    }
}