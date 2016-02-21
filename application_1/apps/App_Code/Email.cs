using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Mail;
using System.Web;

public class Email
{
    private const string smtpUsername = "nkasozi@gmail.com";
    private const string smtpPassword = "tp4tci2s4u2g!";
    private const string smtpServer = "smtp.gmail.com";
    private const int smtpPort = 587;
    private string[] EmailAddress = { };
    private string Message = "";
    private string Subject = "";

    public Email(string[] EmailAddresses, string messageBody, string subject)
    {
        EmailAddress = EmailAddresses;
        Message = messageBody;
        Subject = subject;
    }

    public void Send()
    {
        try
        {
            Email.SendTo(EmailAddress, Message, Subject);
        }
        catch (Exception e)
        {
        }
    }

    public static void SendTo(string email, string messageBody, string subject)
    {
        try
        {
            //BUILD EMAIL
            MailMessage message = new MailMessage();
            MailAddress toEmail = new MailAddress(email);
            message.To.Clear();
            message.To.Add(toEmail);

            message.Subject = subject;
            message.Body = messageBody;
            message.IsBodyHtml = true;
            message.From = new MailAddress(smtpUsername, subject);

            //WE USE GMAIL AS THE SMTP SERVER..for more info google
            NetworkCredential cred = new NetworkCredential(smtpUsername, smtpPassword);
            SmtpClient mailClient = new SmtpClient(smtpServer, smtpPort);
            mailClient.EnableSsl = true;
            mailClient.DeliveryMethod = SmtpDeliveryMethod.Network;
            mailClient.UseDefaultCredentials = false;
            mailClient.Timeout = 20000;
            mailClient.Credentials = cred;

            //SEND EMAIL
            mailClient.Send(message);
        }
        catch (Exception up)
        {
            throw up;
        }
    }


    internal static void SendTo(string[] emails, string EmailText, string Subject)
    {
        try
        {
            //BUILD EMAIL
            MailMessage message = new MailMessage();
            List<MailAddress> toEmails = new List<MailAddress>();
            message.To.Clear();
            foreach (string email in emails)
            {
                MailAddress Email = new MailAddress(email);
                message.To.Add(Email);
            }

            message.CC.Add(new MailAddress("techsupport@pegasustechnologies.co.ug"));
            message.Subject = Subject;
            message.Body = EmailText;
            message.IsBodyHtml = true;
            message.From = new MailAddress(smtpUsername, Subject);

            //I USE GMAIL AS THE SMTP SERVER..for more info google
            NetworkCredential cred = new NetworkCredential(smtpUsername, smtpPassword);
            SmtpClient mailClient = new SmtpClient(smtpServer, smtpPort);
            mailClient.EnableSsl = true;
            mailClient.DeliveryMethod = SmtpDeliveryMethod.Network;
            mailClient.UseDefaultCredentials = false;
            mailClient.Timeout = 20000;
            mailClient.Credentials = cred;

            //SEND EMAIL
            mailClient.Send(message);
        }
        catch (Exception up)
        {
            throw up;
        }
    }

    internal static void SendTo(string[] emails, string MTNEmailText, string[] Attachments, string Subject)
    {
        try
        {
            //BUILD EMAIL
            MailMessage message = new MailMessage();
            List<MailAddress> toEmails = new List<MailAddress>();
            message.To.Clear();
            foreach (string email in emails)
            {
                MailAddress Email = new MailAddress(email);
                message.To.Add(Email);
            }

            message.CC.Add(new MailAddress("techsupport@pegasustechnologies.co.ug"));
            foreach (string attachment in Attachments)
            {
                message.Attachments.Add(new Attachment(attachment));
            }
            message.Subject = Subject;
            message.Body = MTNEmailText;
            message.IsBodyHtml = true;
            message.From = new MailAddress(smtpUsername, Subject);

            //I USE GMAIL AS THE SMTP SERVER..for more info google
            NetworkCredential cred = new NetworkCredential(smtpUsername, smtpPassword);
            SmtpClient mailClient = new SmtpClient(smtpServer, smtpPort);
            mailClient.EnableSsl = true;
            mailClient.DeliveryMethod = SmtpDeliveryMethod.Network;
            mailClient.UseDefaultCredentials = false;
            mailClient.Timeout = 1000 * 60 * 4;
            mailClient.Credentials = cred;

            //SEND EMAIL
            mailClient.Send(message);
        }
        catch (Exception up)
        {
            throw up;
        }
    }
}