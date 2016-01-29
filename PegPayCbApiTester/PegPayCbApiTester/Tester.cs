using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;
using PegPayCbApiTester.CbApi;
using System.Threading;
using iTextSharp.text.pdf;
using iTextSharp.text;
using System.IO;
using System.Data;
using iTextSharp.text.html.simpleparser;
using System.Text.RegularExpressions;

namespace PegPayCbApiTester
{
    [TestFixture]
    public class Tester
    {
        ServiceSoapClient client = new ServiceSoapClient();
        string BankCode = "TESTBANK";
        string Password = "TEST";

        public Tester()
        {

        }

        [Test]
        public void TestGetAll()
        {
            //List<Object> obj = 

            BaseObject[] bo = client.GetAll("BankUser", "TESTBANK", "TEST");
            foreach (BaseObject obj in bo)
            {
                BankUser user = obj as BankUser;
                Assert.AreEqual(user.StatusCode, "0");
            }
        }

        [Test]
        public void TestGetById()
        {
            //List<Object> obj = 
            BaseObject bo = client.GetById("BANKUSER", "1", "TESTBANK", "TEST");
            BankUser user = bo as BankUser;
            Assert.AreEqual(user.StatusCode, "0");
        }

        [Test]
        public void TestSaveBankBranchDetails()
        {
            BankBranch branch = new BankBranch();
            branch.BankBranchId = "0";
            branch.BankCode = "TESTBANK";
            branch.BranchCode = "TESTBRANCH";
            branch.BranchName = "TESTBRANCH";
            branch.CreatedBy = "TEST";
            branch.CreatedOn = "27/12/2015";
            branch.Location = "KANSANGA";
            branch.ModifiedBy = "TEST";
            Result result = client.SaveBankBranchDetails(branch, BankCode, Password);
            Assert.AreEqual(result.StatusCode, "0");
        }

        [Test]
        public void TestSaveBankTellerDetails()
        {
            BankTeller teller = new BankTeller();
            teller.BranchCode = "TESTBRANCH";
            teller.CanHaveAccount = "True";
            teller.DateOfBirth = "17/02/1991";
            teller.FullName = "NSUBUGA KASOZI";
            teller.Gender = "MALE";
            teller.IsActive = "True";
            teller.ModifiedBy = "TEST";
            teller.Password = "TEST";
            teller.PhoneNumber = "256794132389";
            teller.StatusCode = "0";
            teller.Id = "0";
            teller.Email = "nsubugak@yahoo.com";
            teller.Usertype = "TELLER";
            teller.BranchCode = "MY";
            teller.TransactionLimit = "1000";

            Result result = client.SaveBankTellerDetails(teller, BankCode, Password);
            Assert.AreEqual(result.StatusCode, "0");
        }

        public void TestSaveUserDetails()
        {
            BankUser user = new BankUser();
            user.BranchCode = "TESTBRANCH";
            user.CanHaveAccount = "True";
            user.DateOfBirth = "17/02/1991";
            user.Email = "nsubugak@yahoo.com";
            user.FullName = "Nsubuga Kasozi";
            user.Gender = "MALE";
            user.Id = "100";
            user.IsActive = "True";
            user.ModifiedBy = "TEST";
            user.Password = "TEST";
            user.PhoneNumber = "256785975800";
            user.Usertype = "CUSTOMER";

            Result result = client.SaveBankUserDetails(user, BankCode, Password);
            Assert.AreEqual(result.StatusCode, "0");
        }

        public void TestSaveCustomerDetails()
        {
            BankCustomer user = new BankCustomer();
            user.BranchCode = "TESTBRANCH";
            user.CanHaveAccount = "True";
            user.DateOfBirth = "17/02/1991";
            user.Email = "nsubugak@yahoo.com";
            user.FullName = "Nsubuga Kasozi";
            user.Gender = "MALE";
            user.Id = "100";
            user.IsActive = "True";
            user.ModifiedBy = "TEST";
            user.Password = "TEST";
            user.PhoneNumber = "256785975800";
            user.Usertype = "CUSTOMER";

            Result result = client.SaveBankCustomerDetails(user, BankCode, Password);
            Assert.AreEqual(result.StatusCode, "0");
        }

        public void TestSaveAccountDetails()
        {
            BankAccount acc = new BankAccount();
            acc.AccountBalance = "300";
            acc.AccountId = "12";
            acc.AccountNumber = "482136";
            acc.AccountType = "TEST";
            acc.BankCode = "TESTBANK";
            acc.UserId = "100";

            Result result = client.SaveBankAccountDetails(acc, BankCode, Password);
            Assert.AreEqual(result.StatusCode, "0");
        }

        public void TestTransact_DuplicateTranRef()
        {
            TransactionRequest req = new TransactionRequest();
            req.ApprovedBy = "admin";
            req.BankCode = "TESTBANK";
            req.BankTranId = "133329";
            req.CustomerId = "";
            req.CustomerName = "TEST CUSTOMER";
            req.DigitalSignature = "";
            req.FromAccount = "0140586848601";
            req.ToAccount = "0140586848602";
            req.Teller = "TEST";
            req.TranAmount = "500";
            req.TranCategory = "WITHDRAW";
            req.BranchCode = "TESTBRANCH";
            req.Narration = "TEST NARRATION";
            req.PaymentDate = "28/12/2015";
            req.Password = "TEST";
            req.Currency = "UGS";

            //transact using same bank tranid
            Result result = client.Transact(req);
            if (result.StatusDesc.Contains("DUPLICATE"))
            {
                Assert.Pass();
            }
            else
            {
                Assert.Fail("RESPONSE DOESNT INDICATE DUPLICATE TRANSACTION REF ERROR");
            }
        }

        public void TestTransact_SuspectedDoublePosting()
        {
            TransactionRequest req = new TransactionRequest();
            req.ApprovedBy = "admin";
            req.BankCode = "TESTBANK";
            req.BankTranId = "133330";
            req.CustomerId = "";
            req.CustomerName = "TEST CUSTOMER";
            req.DigitalSignature = "";
            req.FromAccount = "0140586848601";
            req.ToAccount = "0140586848602";
            req.Teller = "TEST";
            req.TranAmount = "500";
            req.TranCategory = "WITHDRAW";
            req.BranchCode = "TESTBRANCH";
            req.Narration = "TEST NARRATION";
            req.PaymentDate = "28/12/2015";
            req.Password = "TEST";
            req.Currency = "UGS";

            Result result = client.Transact(req);
            req.BankTranId += "1";

            //transact same amount,same account in 10 min
            result = client.Transact(req);
            if (result.StatusDesc.Contains("SUSPECTED"))
            {
                Assert.Pass();
            }
            else
            {
                Assert.Fail("RESPONSE DOESNT INDICATE SUSPECTED DOUBLE POSTING");
            }
        }

        public void TestTransact_SuspectedDoublePostingGoesAwayAfter10min()
        {
            TransactionRequest req = new TransactionRequest();
            req.ApprovedBy = "admin";
            req.BankCode = "TESTBANK";
            req.BankTranId = "133330";
            req.CustomerId = "";
            req.CustomerName = "TEST CUSTOMER";
            req.DigitalSignature = "";
            req.FromAccount = "0140586848601";
            req.ToAccount = "0140586848602";
            req.Teller = "TEST";
            req.TranAmount = "500";
            req.TranCategory = "WITHDRAW";
            req.BranchCode = "TESTBRANCH";
            req.Narration = "TEST NARRATION";
            req.PaymentDate = "28/12/2015";
            req.Password = "TEST";
            req.Currency = "UGS";

            Result result = client.Transact(req);
            req.BankTranId += "1";

            Console.WriteLine("Testing if Suspected double posting dissapears after 10 min");
            Console.WriteLine("Sleeping for 11 minutes");
            Thread.Sleep(new TimeSpan(0, 11, 0));
            Console.WriteLine("Waking Up");
            //transact same amount,same account in 10 min
            result = client.Transact(req);
            if (result.StatusDesc.Contains("SUSPECTED"))
            {
                Assert.Fail("RESPONSE INDICATES SUSPECTED DOUBLE POSTING AFTER 10 MIIN");
            }
            else
            {
                Assert.Pass();
            }
        }

        public void TestTransact()
        {
            TransactionRequest req = new TransactionRequest();
            req.ApprovedBy = "admin";
            req.BankCode = "TESTBANK";
            req.BankTranId = "133334";
            req.CustomerId = "";
            req.CustomerName = "TEST CUSTOMER";
            req.DigitalSignature = "";
            req.FromAccount = "0140586848602";
            req.ToAccount = "0140586848601";
            req.Teller = "admin";
            req.TranAmount = "612";
            req.TranCategory = "WITHDRAW";
            req.BranchCode = "TESTBRANCH";
            req.Narration = "TEST NARRATION";
            req.PaymentDate = "28/12/2015";
            req.Password = "TEST";
            req.Currency = "UGS";

            Result result = client.Transact(req);
            Assert.AreEqual(result.StatusCode, "0");
        }

        public void TestReverseTransaction()
        {
            TransactionRequest req = new TransactionRequest();
            req.ApprovedBy = "100";
            req.BankCode = "TESTBANK";
            req.BankTranId = "133328";
            req.CustomerId = "";
            req.CustomerName = "";
            req.DigitalSignature = "";
            req.FromAccount = "";
            req.ToAccount = "";
            req.Teller = "";
            req.TranAmount = "";
            req.TranCategory = "";
            req.BranchCode = "";
            req.Narration = "";
            req.PaymentDate = "";
            req.Password = "TEST";

            Result result = client.ReverseTransaction(req);
            Assert.AreEqual(result.StatusCode, "0");
        }

        public void TestSaveBankDetails()
        {

            Bank bank = new Bank();
            bank.BankCode = "TESTBANK";
            bank.BankContactEmail = "nsubugak@yahoo.com";
            bank.BankId = "0";
            bank.BankName = "TEST NAME";
            bank.BankPassword = "TEST";

            Result result = client.SaveBankDetails(bank, "TEST", "TEST");
            Assert.AreEqual(result.StatusCode, "0");
        }

        //public void TestSaveCustomerTypeDetails()
        //{

        //    CustomerType type = new CustomerType();
        //    type.ApprovedBy = "TEST";
        //    type.CreatedBy = "TEST";
        //    type.CustType = "FARMERS";
        //    type.Description = "TEST";
        //    type.Id = "0";

        //    Result result = client.SaveCustomerTypeDetails(type, "TESTBANK", "TEST");
        //    Assert.AreEqual(result.StatusCode, "0");
        //}

        //public void TestSaveCustomerTypeDetails()
        //{

        //    CustomerType type = new CustomerType();
        //    type.ApprovedBy = "TEST";
        //    type.CreatedBy = "TEST";
        //    type.CustType = "FARMERS";
        //    type.Description = "TEST";
        //    type.Id = "0";

        //    Result result = client.SaveCustomerTypeDetails(type, "TESTBANK", "TEST");
        //    Assert.AreEqual(result.StatusCode, "0");
        //}

        public void TestExportPdf()
        {
            string[] parameters = { };
            DataSet ds = client.ExecuteDataSet("GetAllBanks", parameters);
            ExportToPdf(ds.Tables[0], "Nsubuga", "TestReport");
        }

        public string ExportToPdf(DataTable dtsent, string user, string fileName)
        {
            StringBuilder sb = new StringBuilder();
            StringReader sr = new StringReader(sb.ToString());
            Document pdfDoc = new Document(iTextSharp.text.PageSize.LETTER, 10, 10, 50, 50);
            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);

            using (MemoryStream memoryStream = new MemoryStream())
            {

                PdfWriter.GetInstance(pdfDoc, memoryStream);
                pdfDoc.Open();

                string imageFile = @"C:\Users\nkasozi\Documents\Visual Studio 2005\Projects\PegPayCoreBanking_1\application_1\apps\Images\TESTBANK\StanbicLogo.png";
                System.Drawing.Image img = FixedSize(System.Drawing.Image.FromFile(imageFile), 250,80);
                iTextSharp.text.Image jpg = iTextSharp.text.Image.GetInstance(img, BaseColor.DARK_GRAY);

                //Image alignment
                //jpg.

                jpg.Border = Rectangle.RECTANGLE;
                jpg.BorderColor = BaseColor.BLACK;
                jpg.BorderWidth = 2;
                jpg.IndentationLeft = 9f;
                jpg.Alignment = iTextSharp.text.Image.TEXTWRAP | iTextSharp.text.Image.ALIGN_LEFT;

                //Give space before image   
                jpg.SpacingBefore = 10f;
                //Give some space after the image   
                jpg.SpacingAfter = 0f;
                //jpg.Alignment = Element.HEADER;
                pdfDoc.Add(jpg);
                Font font8 = FontFactory.GetFont("ARIAL", 7);
                DataTable dt = dtsent;

                //This is used for Add A Paragraph to pdf
                string printedby = "Printed BY:" + "\t" + user;
                string printedon = "Printed ON:" + DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss");
                string title = "TRANSACTIONS THAT FAILED RECONCILIATION";
                string[] Text = { title, printedby, printedon };

                List<Chunk> chunks = new List<Chunk>();
                float widest = 0f;
                foreach(string txt in Text)
                {
                    Chunk c = new Chunk(txt);
                    float w = c.GetWidthPoint();
                    if (w > widest) { widest = w; }
                    chunks.Add(c);
                }

                float indentation = pdfDoc.PageSize.Width - widest;

                foreach (Chunk c in chunks)
                {
                    Paragraph p = new Paragraph(c);
                    p.IndentationLeft = 10;
                    p.KeepTogether = true;
                    pdfDoc.Add(p);
                }



                int cols = dt.Columns.Count;
                int rows = dt.Rows.Count;
                int pdfRowIndex = 1;

                PdfPTable table;


                //Craete instance of the pdf table and set the number of column in that table  
                //float[] columnDefinitionSize = { 1.5F, 1.5F, 1.5F, 1.5F, 1.5F,1.5F };
                List<float> columnDefinitionSize = new List<float>();
                foreach (DataColumn col in dt.Columns)
                {
                    float ft = 1.2f;
                    columnDefinitionSize.Add(ft);
                }

                table = new PdfPTable(columnDefinitionSize.ToArray());
                //table width
                table.WidthPercentage = 100;
                table.DefaultCell.Padding = 4;
                table.HorizontalAlignment = Element.ALIGN_BOTTOM;
                //table.DefaultCell.BorderWidth = 1;

                PdfPCell cell;
                cell = new PdfPCell();
                cell.BackgroundColor = new BaseColor(0xC0, 0xC0, 0xC0);

                Font font1 = FontFactory.GetFont("ARIAL", 9);
                Font font2 = FontFactory.GetFont("ARIAL", 10);

                /*You can use loop to add a column*/
                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    string columnName = dt.Columns[i].ToString();
                    //cell.BackgroundColor = new iTextSharp.text.Color(240, 240, 240);
                    table.AddCell(new Phrase(columnName, font1));
                }

                table.HeaderRows = 1;

                float[] anchosTablaTituloDescripcion = new float[dt.Columns.Count];
                for (int i = 0; i <= anchosTablaTituloDescripcion.Length - 1; i++)
                {
                    float tf = anchosTablaTituloDescripcion[i];
                    tf = 4f;
                }
                foreach (DataRow row in dt.Rows)
                {

                    for (int i = 0; i < dt.Columns.Count; i++)
                    {
                        string cellValue = row[i].ToString();
                        string data = GetFormattedLine(cellValue, 15);
                        Paragraph ph = new Paragraph(data, font2);
                        ph.KeepTogether = false;

                        table.AddCell(ph);
                        pdfRowIndex++;

                    }

                }
                table.TotalWidth = pdfDoc.PageSize.Width;
                table.KeepTogether = true;
                table.SplitRows = false;
                table.SplitLate = true;
                //table.SetWidths(anchosTablaTituloDescripcion);
                //table.WidthPercentage = 100;
                // Give some space after the text or it may overlap the table            
                table.SpacingBefore = 15f;
                // add pdf table to the document   
                pdfDoc.Add(table);
                pdfDoc.Close();
                pdfDoc.CloseDocument();



                byte[] content = memoryStream.ToArray();
                memoryStream.Close();
                string name = fileName;
                string filepath = @"C:\Users\nkasozi\Documents\Work\" + name +
                                  DateTime.Now.ToString("_ddMMyyyy_HHmmss") + ".pdf";

                // Write out PDF from memory stream.
                using (FileStream fs = File.Create(filepath))
                {
                    fs.Write(content, 0, (int)content.Length);
                }

                return filepath;
            }
        }

        static System.Drawing.Image FixedSize(System.Drawing.Image imgPhoto, int Width, int Height)
        {
            int sourceWidth = imgPhoto.Width;
            int sourceHeight = imgPhoto.Height;
            int sourceX = 0;
            int sourceY = 0;
            int destX = 0;
            int destY = 0;

            float nPercent = 0;
            float nPercentW = 0;
            float nPercentH = 0;

            nPercentW = ((float)Width / (float)sourceWidth);
            nPercentH = ((float)Height / (float)sourceHeight);
            if (nPercentH < nPercentW)
            {
                nPercent = nPercentH;
                destX = System.Convert.ToInt16((Width -
                              (sourceWidth * nPercent)) / 2);
            }
            else
            {
                nPercent = nPercentW;
                destY = System.Convert.ToInt16((Height -
                              (sourceHeight * nPercent)) / 2);
            }

            int destWidth = (int)(sourceWidth * nPercent);
            int destHeight = (int)(sourceHeight * nPercent);

            System.Drawing.Bitmap bmPhoto = new System.Drawing.Bitmap(Width, Height,
                              System.Drawing.Imaging.PixelFormat.Format24bppRgb);
            bmPhoto.SetResolution(imgPhoto.HorizontalResolution,
                             imgPhoto.VerticalResolution);

            System.Drawing.Graphics grPhoto = System.Drawing.Graphics.FromImage(bmPhoto);
            grPhoto.Clear(System.Drawing.Color.White);
            grPhoto.InterpolationMode =
                    System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;

            grPhoto.DrawImage(imgPhoto,
                new System.Drawing.Rectangle(destX, destY, destWidth, destHeight),
                new System.Drawing.Rectangle(sourceX, sourceY, sourceWidth, sourceHeight),
                System.Drawing.GraphicsUnit.Pixel);

            grPhoto.Dispose();
            return bmPhoto;
        }

        private string GetFormattedLine(string text, int lineLength)
        {
            return Regex.Replace(text, "(.{" + lineLength + "})", "$1" + Environment.NewLine);
        }






    }
}
