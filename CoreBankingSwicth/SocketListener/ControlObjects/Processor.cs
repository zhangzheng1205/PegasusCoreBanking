using System;
using System.Collections.Generic;
using System.Text;
using SocketListener.CoreBankingApi;
using System.Globalization;

namespace SocketListener.ControlObjects
{
    public class Processor
    {
        Service client = new Service();
        public string ProcessRequest(string content)
        {

            string response = "";

            try
            {

                //4. <<< Use "Parse" method of object iso8583. >>>
                BIM_ISO8583.NET.ISO8583 Parseiso8583 = new BIM_ISO8583.NET.ISO8583();
                string[] DE = Parseiso8583.Parse(content);

                PrintIsoMessage(DE);

                string MTI = DE[129];

                switch (MTI)
                {
                    case "0200":
                        response = DoTransactOperation(DE);
                        break;
                    case "0400":
                        response = DoReversalOperation(DE);
                        break;
                    case "0800":
                        response = DoEchoOperation(DE);
                        break;
                    case "0100":
                        response = DoAccountInquiryOperation(DE);
                        break;
                    case "0500":
                        response = DoGetMiniStatementOperation(DE);
                        break;
                    default:
                        response = ReturnOperationNotSupportedError(DE);
                        break;
                }
            }
            catch (Exception ex)
            {
                response = InvalidISOformatErrorMessage();
            }
            return response;
        }

        private string DoAccountInquiryOperation(string[] DE)
        {
            string response = "";
            try
            {
                string AccountNumber = DE[103];
                string BankCode = GetBankCode(DE[2]);
                string Password = DE[47];

                BankAccount account = client.GetById("BANKACCOUNT", AccountNumber, BankCode, Password) as BankAccount;
                if (account.StatusCode == "0")
                {
                    response = GetAccountBalSuccessResponse(account, AccountNumber);
                }
                else
                {
                    response = GetAccountBalFailureResponse(account, AccountNumber);
                }
            }
            catch (Exception ex)
            {
                response = GetErrorResponse(DE, ex.Message);
            }
            return response;
        }

        private string DoGetMiniStatementOperation(string[] DE)
        {
            string response = "";
            try
            {
                string AccountNumber = DE[103];
                string BankCode = GetBankCode(DE[2]);
                string Password = DE[47];

                BankAccountStatement state = client.GetMiniStatement(AccountNumber, BankCode, Password);
                if (state.StatusCode == "0")
                {
                    response = ReturnMiniStatementSuccessResponse(state, AccountNumber);
                }
                else
                {
                    response = ReturnMiniStatementFailureResponse(state, AccountNumber);
                }
            }
            catch (Exception ex)
            {
                response = GetErrorResponse(DE, ex.Message);
            }
            return response;
        }

        private string ReturnMiniStatementFailureResponse(BankAccountStatement state, string AccountNumber)
        {
            string response = "";
            string MTI = "0510";

            //2.Create an object BIM-ISO8583.ISO8583
            BIM_ISO8583.NET.ISO8583 Buildiso8583 = new BIM_ISO8583.NET.ISO8583();

            //3. Create Arrays
            string[] ResponseDE = new string[130];

            //4. Assign corresponding data to each array
            //   Ex: ISO8583 Data Element No.2 (PAN) shall assign to newly created array, DE[2];
            ResponseDE[39] = GetIso8583ResponseCode(state.StatusDesc);//Error flag for ISO 8583
            ResponseDE[47] = state.StatusDesc;
            ResponseDE[48] = "";
            ResponseDE[49] = AccountNumber;


            //5.Use "Build" method of object iso8583 to create a new  message.
            response = Buildiso8583.Build(ResponseDE, MTI);
            return response;
        }

        private string ReturnMiniStatementSuccessResponse(BankAccountStatement state, string AccountNumber)
        {
            string response = "";
            string MTI = "0510";

            //2.Create an object BIM-ISO8583.ISO8583
            BIM_ISO8583.NET.ISO8583 Buildiso8583 = new BIM_ISO8583.NET.ISO8583();

            //3. Create Arrays
            string[] ResponseDE = new string[130];

            //4. Assign corresponding data to each array
            //   Ex: ISO8583 Data Element No.2 (PAN) shall assign to newly created array, DE[2];
            ResponseDE[39] = "00";//success response code
            ResponseDE[47] = state.StatusDesc;
            ResponseDE[48] = "";
            ResponseDE[125] = GetStatementString(state);


            //5.Use "Build" method of object iso8583 to create a new  message.
            response = Buildiso8583.Build(ResponseDE, MTI);
            return response;
        }

        private string GetStatementString(BankAccountStatement state)
        {
            string line = "";
            foreach (string statement in state.statement)
            {
                line += statement.Replace(',', ' ').Replace("12:00:00 AM", string.Empty) + "|";
            }
            return line;
        }


        private string GetAccountBalFailureResponse(BankAccount account, string AccountNumber)
        {
            string response = "";
            string MTI = "0110";

            //2.Create an object BIM-ISO8583.ISO8583
            BIM_ISO8583.NET.ISO8583 Buildiso8583 = new BIM_ISO8583.NET.ISO8583();

            //3. Create Arrays
            string[] ResponseDE = new string[130];

            //4. Assign corresponding data to each array
            //   Ex: ISO8583 Data Element No.2 (PAN) shall assign to newly created array, DE[2];
            ResponseDE[39] = GetIso8583ResponseCode(account.StatusDesc);//Error flag for ISO 8583
            ResponseDE[47] = account.StatusDesc;
            ResponseDE[48] = "";
            ResponseDE[49] = AccountNumber;


            //5.Use "Build" method of object iso8583 to create a new  message.
            response = Buildiso8583.Build(ResponseDE, MTI);
            return response;
        }

        private string GetAccountBalSuccessResponse(BankAccount account, string AccountNumber)
        {
            string response = "";
            string MTI = "0110";

            //2.Create an object BIM-ISO8583.ISO8583
            BIM_ISO8583.NET.ISO8583 Buildiso8583 = new BIM_ISO8583.NET.ISO8583();

            //3. Create Arrays
            string[] ResponseDE = new string[130];

            //4. Assign corresponding data to each array
            //   Ex: ISO8583 Data Element No.2 (PAN) shall assign to newly created array, DE[2];
            ResponseDE[39] = "00";
            ResponseDE[47] = account.StatusDesc;
            ResponseDE[48] = account.AccountBalance;
            ResponseDE[49] = AccountNumber;


            //5.Use "Build" method of object iso8583 to create a new  message.
            response = Buildiso8583.Build(ResponseDE, MTI);
            return response;
        }

        private string ReturnOperationNotSupportedError(string[] DE)
        {
            //whatever ISO Operation passed, We change the 3rd character in MTI
            //to 1 to indicate response
            string MTI = DE[129];
            char[] array = MTI.ToCharArray();
            array[2] = '1';
            MTI = array.ToString();

            string response = "";

            //2.Create an object BIM-ISO8583.ISO8583
            BIM_ISO8583.NET.ISO8583 Buildiso8583 = new BIM_ISO8583.NET.ISO8583();

            //3. Create Arrays
            string[] ResponseDE = new string[130];

            //4. Assign corresponding data to each array
            //   Ex: ISO8583 Data Element No.2 (PAN) shall assign to newly created array, DE[2];
            ResponseDE[39] = "06";//Error flag for ISO 8583
            ResponseDE[47] = "THIS_ISO_OPERATION_IS_NOT_YET_SUPPORTED_AT_PEGPAY";//Error msg
            ResponseDE[48] = "";
            ResponseDE[49] = DE[11];//Request Id


            //5.Use "Build" method of object iso8583 to create a new  message.
            response = Buildiso8583.Build(ResponseDE, MTI);
            return response;
        }

        private string DoReversalOperation(string[] DE)
        {
            string response = "";
            try
            {
                TransactionRequest tran = GetTransactionRequest(DE);
                Result result = client.ReverseTransaction(tran);
                if (result.StatusCode == "0")
                {
                    response = GetFinicialOpSuccessResponse(tran, result);
                }
                else
                {
                    response = GetFinicialOpFailureResponse(tran, result);
                }
            }
            catch (Exception ex)
            {
                response = GetErrorResponse(DE, ex.Message);
            }
            return response;
        }

        private string DoEchoOperation(string[] DE)
        {
            string response = "";
            string MTI = "0810";
            try
            {
                string echo = DE[70];
                if (!string.IsNullOrEmpty(echo))
                {
                    BIM_ISO8583.NET.ISO8583 echoResponse = new BIM_ISO8583.NET.ISO8583();
                    response = echoResponse.Build(DE, MTI);
                }
                else
                {
                    response = ReturnOperationNotSupportedError(DE);
                }
            }
            catch (Exception ex)
            {
                response = GetErrorResponse(DE, ex.Message);
            }
            return response;
        }

        private string DoTransactOperation(string[] DE)
        {
            string response = "";
            try
            {
                TransactionRequest tran = GetTransactionRequest(DE);
                Result result = client.Transact(tran);
                if (result.StatusCode == "0")
                {
                    response = GetFinicialOpSuccessResponse(tran, result);
                }
                else
                {
                    response = GetFinicialOpFailureResponse(tran, result);
                }
            }
            catch (Exception ex)
            {
                response = GetErrorResponse(DE, ex.Message);
            }
            return response;
        }

        private string GetFinicialOpSuccessResponse(TransactionRequest tran, Result result)
        {
            string response = "";
            string MTI = "0210";

            //2.Create an object BIM-ISO8583.ISO8583
            BIM_ISO8583.NET.ISO8583 Buildiso8583 = new BIM_ISO8583.NET.ISO8583();

            //3. Create Arrays
            string[] ResponseDE = new string[130];

            //4. Assign corresponding data to each array
            //   Ex: ISO8583 Data Element No.2 (PAN) shall assign to newly created array, DE[2];
            ResponseDE[39] = "00";
            ResponseDE[47] = result.StatusDesc;
            ResponseDE[48] = result.PegPayId;
            ResponseDE[49] = result.RequestId;


            //5.Use "Build" method of object iso8583 to create a new  message.
            response = Buildiso8583.Build(ResponseDE, MTI);
            return response;
        }

        private void PrintIsoMessage(string[] DE)
        {

            Console.WriteLine(" Message Type Indicator: = {0}", DE[129]);
            Console.WriteLine(" PrimaryBitMap: = {0}", DE[0]);
            Console.WriteLine(" SecondaryBitMap:{0}", DE[1]);
            Console.WriteLine(" Bank code:{0}", DE[2]);
            Console.WriteLine(" TranAmount:{0}", DE[4]);
            Console.WriteLine(" ToAccount:{0}", DE[103]);
            Console.WriteLine(" FromAccount:{0}", DE[102]);
            Console.WriteLine(" TransmissionTime:{0}", DE[7]);
            Console.WriteLine(" BankTranId:{0}", DE[11]);
            Console.WriteLine("Approved by :{0}", DE[61]);
            Console.WriteLine(" Teller:{0}", DE[42]);
            Console.WriteLine(" Narration:{0}", DE[104]);
            Console.WriteLine(" Password:{0}", DE[47]);
            Console.WriteLine(" TransactionCategory:{0}", DE[48]);
            Console.WriteLine(" DigitalSignature:{0}", DE[46]);
            Console.WriteLine(" BranchCode:{0}", DE[43]);
            Console.WriteLine(" CurrencyCode{0}", DE[49]);
        }

        private string GetFinicialOpFailureResponse(TransactionRequest tran, Result result)
        {
            string response = "";
            string MTI = "0210";

            //2.Create an object BIM-ISO8583.ISO8583
            BIM_ISO8583.NET.ISO8583 Buildiso8583 = new BIM_ISO8583.NET.ISO8583();

            //3. Create Arrays
            string[] ResponseDE = new string[130];

            //4. Assign corresponding data to each array
            //   Ex: ISO8583 Data Element No.2 (PAN) shall assign to newly created array, DE[2];
            ResponseDE[39] = GetIso8583ResponseCode(tran.StatusDesc);//Error flag for ISO 8583
            ResponseDE[47] = result.StatusDesc;
            ResponseDE[48] = result.PegPayId;
            ResponseDE[49] = result.RequestId;


            //5.Use "Build" method of object iso8583 to create a new  message.
            response = Buildiso8583.Build(ResponseDE, MTI);
            return response;
        }

        private string GetIso8583ResponseCode(string statusDesc)
        {
            return "06";
        }


        private string GetErrorResponse(string[] DE, string msg)
        {
            //whatever Iso Operation passed, We change the 3 char in MTI
            //to 1 to indicate response
            string MTI = DE[129];
            char[] array = MTI.ToCharArray();
            array[2] = '1';
            MTI = new string(array);

            string response = "";

            //2.Create an object BIM-ISO8583.ISO8583
            BIM_ISO8583.NET.ISO8583 Buildiso8583 = new BIM_ISO8583.NET.ISO8583();

            //3. Create Arrays
            string[] ResponseDE = new string[130];

            //4. Assign corresponding data to each array
            //   Ex: ISO8583 Data Element No.2 (PAN) shall assign to newly created array, DE[2];
            ResponseDE[39] = "06";//Error flag for ISO 8583
            ResponseDE[47] = msg;//Error msg
            ResponseDE[48] = "";
            ResponseDE[49] = DE[11];//Request Id


            //5.Use "Build" method of object iso8583 to create a new  message.
            response = Buildiso8583.Build(ResponseDE, MTI);
            return response;
        }

        private TransactionRequest GetTransactionRequest(string[] DE)
        {
            //That was it!!!
            //If there is no error occurred then you have successfully parsed a valid ISO8583 message
            string CustomerName = DE[56];
            string ToAccount = DE[103];
            string FromAccount = DE[102];
            string TranAmount = GetTransactionAmount(DE[4]);
            string BankTranId = GetBankTranId(DE[11]);
            string PaymentDate = GetPaymentDate(DE[7]);
            string Teller = DE[42];
            string ApprovedBy = DE[62];
            string BankCode = GetBankCode(DE[2]);//----NO
            string Narration = DE[104];//----ans100
            string Password = DE[47];
            string DigitalSignature = DE[46];
            string TranCategory = DE[48];
            string BranchCode = DE[43];
            string CurrencyCode = DE[49];
            string PaymentType = DE[41];
            string ChequeNumber = DE[61];


            TransactionRequest tran = new TransactionRequest();
            tran.ApprovedBy = ApprovedBy;
            tran.BankCode = BankCode;
            tran.BankTranId = BankTranId;
            tran.BranchCode = BranchCode;
            tran.ChequeNumber = ChequeNumber;
            tran.CurrencyCode = CurrencyCode;
            tran.CustomerName = CustomerName;
            tran.DigitalSignature = DigitalSignature;
            tran.FromAccount = FromAccount;
            tran.Narration = Narration;
            tran.Password = Password;
            tran.PaymentDate = PaymentDate;
            tran.PaymentType = PaymentType;
            tran.StatusCode = "0";
            tran.StatusDesc = "SUCCESS";
            tran.Teller = Teller;
            tran.ToAccount = ToAccount;
            tran.TranAmount = TranAmount;
            tran.TranCategory = TranCategory;
            return tran;

        }

        private string GetBankTranId(string id)
        {
            try
            {
                int number = int.Parse(id);
                return "" + number;
            }
            catch (Exception)
            {
                throw;
            }
        }

        private string GetTransactionAmount(string aString)
        {
            try
            {
                int number = int.Parse(aString);
                return "" + number;
            }
            catch (Exception)
            {
                throw;
            }
        }

        private string GetBankCode(string bankId)
        {
            return "STANBIC";
        }

        private string GetPaymentDate(string date)
        {
            DateTime dt = DateTime.Now;
            return dt.ToString("dd/MM/yyyy");
        }

        private string InvalidISOformatErrorMessage()
        {
            string MTI = "0610";
            string response = "";

            //2.Create an object BIM-ISO8583.ISO8583
            BIM_ISO8583.NET.ISO8583 Buildiso8583 = new BIM_ISO8583.NET.ISO8583();

            //3. Create Arrays
            string[] ResponseDE = new string[130];

            //4. Assign corresponding data to each array
            //   Ex: ISO8583 Data Element No.2 (PAN) shall assign to newly created array, DE[2];
            ResponseDE[39] = "96";//Error flag for ISO 8583
            ResponseDE[47] = "INVALID ISO MESSAGE FORMAT";//Error msg
            ResponseDE[48] = "";
            ResponseDE[49] = "";//Request Id


            //5.Use "Build" method of object iso8583 to create a new  message.
            response = Buildiso8583.Build(ResponseDE, MTI);
            return response;
        }

    }
}
