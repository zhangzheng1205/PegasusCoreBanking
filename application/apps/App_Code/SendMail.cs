using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.IO;
using System.Text.RegularExpressions;

/// <summary>
/// Summary description for SendMail
/// </summary>
public class SendMail
{
    DataLogin datafile = new DataLogin();
    BusinessLogin bll = new BusinessLogin();
	public SendMail()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public void Alert(string Message,int Who)
    {


    }
    public string SendeMail(string MailTo, string Subject, string Body)
    {
        string ret = "";
        try
        {
            int GlobalCode = 1;
            int ValueCode = 2;
            SmtpClient client = new SmtpClient();
            string smtpIP = datafile.GetSystemParameter(GlobalCode, ValueCode);
            if (smtpIP.Equals(""))
            {
                smtpIP = "10.0.0.6";
            }
            client.Host = smtpIP;
            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("inteface@umeme.co.ug", "UMEME INTERFACE");
            msg.ReplyTo = new MailAddress("interface@umeme.co.ug");
            msg.To.Add(new MailAddress(MailTo));
            msg.Subject = Subject;
            msg.IsBodyHtml = true;
            msg.Body = Body;
            client.Send(msg);
            ret = "SENT";
        }
        catch (Exception ex)
        {
            ret = ex.Message;
        }
        return ret;
    }

    internal string GoogleMail(string mailto, string subject, string message, string name)
    {
        string ret = "";
        try
        {           
            MailMessage mailMessage = new MailMessage();
            // Email to send to
            MailAddress toEmail = new MailAddress(mailto, name);
            mailMessage.To.Add(toEmail);
            // set subject
            mailMessage.Subject = subject;
            // set body
            mailMessage.Body = message;
            mailMessage.IsBodyHtml = true;
            // set from email
            mailMessage.From = new MailAddress("info@pegasustechnologies.co.ug", "PEGPAY PAYMENTS INTERFACE");
            // Identify the credentials to login to the gmail account 
            string sendEmailsFrom = bll.DecryptString(datafile.GetSystemParameter(2,5));//"jab.arajab@gmail.com";
            string sendEmailsFromPassword = bll.DecryptString(datafile.GetSystemParameter(2,6));//"jabqas@2012";
            string host = bll.DecryptString(datafile.GetSystemParameter(2, 4));
            NetworkCredential cred = new NetworkCredential(sendEmailsFrom, sendEmailsFromPassword);
            SmtpClient mailClient = new SmtpClient(host, 587);
            mailClient.EnableSsl = true;
            mailClient.DeliveryMethod = SmtpDeliveryMethod.Network;
            mailClient.UseDefaultCredentials = false;
            mailClient.Timeout = 20000;
            mailClient.Credentials = cred;
            mailClient.Send(mailMessage);
            ret = "SENT";
        }
        catch (Exception ex)
        {
            ret = ex.Message;
        }
        return ret;
    }
    public void SendUserEmail(string sendTo, string subject, string messagebody)
    {
        try
        {

            MailMessage mm = new MailMessage();
            MailAddress toEmail2 = new MailAddress(sendTo);
            mm.To.Clear();
            mm.To.Add(toEmail2);
            mm.From = new MailAddress("info@pegasustechnologies.co.ug", "PEGPAY PORTAL INTERFACE");
            mm.Subject = subject;
            mm.Body = messagebody;

            mm.IsBodyHtml = true;
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.EnableSsl = true;
            smtp.Timeout = 200000;
            string sendEmailsFrom = bll.DecryptString(datafile.GetSystemParameter(2, 5));//"jab.arajab@gmail.com";
            string sendEmailsFromPassword = bll.DecryptString(datafile.GetSystemParameter(2, 6));//"jabqas@2012";
            NetworkCredential NetworkCred = new NetworkCredential(sendEmailsFrom, sendEmailsFromPassword);

            //NetworkCred.UserName = bll.DecryptString(datafile.GetSystemParameter(2, 19)); //"antheamarthy@gmail.com";
            //NetworkCred.Password = bll.DecryptString(datafile.GetSystemParameter(2, 20));//"PasswordForEmail";
            smtp.UseDefaultCredentials = true;
            smtp.Credentials = NetworkCred;
            smtp.Port = 587;
            smtp.Send(mm);


        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
}
