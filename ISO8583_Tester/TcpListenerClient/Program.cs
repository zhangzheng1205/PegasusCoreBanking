using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace TcpListenerClient
{
    class Program
    {
        static void Main(string[] args)
        {
            //TestTransactCoreBankingSwitch();
           // TestReversalCoreBankingSwitch();
            //TestEchoMessageCoreBankingSwitch();
            //TestAccountBalInquiryCoreBankingSwitch();
            TestGetMiniStatement();
        }

        private static void TestEchoMessageCoreBankingSwitch()
        {
            Socket clientSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            clientSocket.Connect("127.0.0.1", 4128);

            BIM_ISO8583.NET.ISO8583 Parseiso8583 = new BIM_ISO8583.NET.ISO8583();
            string HexISOMessage = GetISO8583EchoMessageToSend();

            Console.WriteLine("ISO 8583 Request:" + HexISOMessage);
            byte[] outStream = Encoding.UTF8.GetBytes(HexISOMessage);
            clientSocket.Send(outStream);
            byte[] inStream = new byte[100025];
            int result = clientSocket.Receive(inStream);

            string returndata = Encoding.UTF8.GetString(inStream, 0, result);
            Console.WriteLine("Response:" + returndata);
            string[] DE = new string[130];
            DE = Parseiso8583.Parse(returndata);
            string statusCode = DE[39];
            string StatusDesc = DE[47];
            string PegPayId = DE[48];
            Console.Read();

        }

        private static void TestAccountBalInquiryCoreBankingSwitch()
        {
            Socket clientSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            clientSocket.Connect("127.0.0.1", 4128);

            BIM_ISO8583.NET.ISO8583 Parseiso8583 = new BIM_ISO8583.NET.ISO8583();
            string HexISOMessage = GetISO8583AccountBalMessageToSend();

            Console.WriteLine("ISO 8583 Request:" + HexISOMessage);
            byte[] outStream = Encoding.UTF8.GetBytes(HexISOMessage);
            clientSocket.Send(outStream);
            byte[] inStream = new byte[100025];
            int result = clientSocket.Receive(inStream);

            string returndata = Encoding.UTF8.GetString(inStream, 0, result);
            Console.WriteLine("Response:" + returndata);
            string[] DE = new string[130];
            DE = Parseiso8583.Parse(returndata);
            string statusCode = DE[39];
            string StatusDesc = DE[47];
            string PegPayId = DE[48];
            Console.Read();

        }


        private static void TestGetMiniStatement()
        {
            Socket clientSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            clientSocket.Connect("127.0.0.1", 4128);

            BIM_ISO8583.NET.ISO8583 Parseiso8583 = new BIM_ISO8583.NET.ISO8583();
            string HexISOMessage = GetISO8583MiniStatementMessageToSend();

            Console.WriteLine("ISO 8583 Request:" + HexISOMessage);
            byte[] outStream = Encoding.UTF8.GetBytes(HexISOMessage);
            clientSocket.Send(outStream);
            byte[] inStream = new byte[100025];
            int result = clientSocket.Receive(inStream);

            string returndata = Encoding.UTF8.GetString(inStream, 0, result);
            Console.WriteLine("Response:" + returndata);
            string[] DE = new string[130];
            DE = Parseiso8583.Parse(returndata);
            string[] lines = DE[125].Split('|');
            string statusCode = DE[39];
            string StatusDesc = DE[47];
            string PegPayId = DE[48];
            Console.Read();

        }

        private static string GetISO8583MiniStatementMessageToSend()
        {
            string MTI = "0500";
            string ToAccount = "20160208170330607";//DE[103]
            string FromAccount = "";//DE[102]
            string TranAmount = "";//DE[4]
            string BankTranId = "";//DE[11]
            string PaymentDate = "";//DE[7]  (format: MMDDhhmmss)
            string Teller = "";//DE[42]
            string ApprovedBy = "";//DE[61]
            string BankCode = "12345";//DE[2]----NO
            string Narration = "";//DE[104]----ans100
            string Password = "T3rr1613";//DE[47]
            string DigitalSignature = "";//DE[46]
            string TranCategory = "";//DE[48]
            string BranchCode = "";//DE[43]
            string CurrencyCode = "";//DE[49]
            string CustomerName = "";
            string PaymentType = "";
            string ChequeNumber = "";

            //2.Create an object BIM-ISO8583.ISO8583
            BIM_ISO8583.NET.ISO8583 Buildiso8583 = new BIM_ISO8583.NET.ISO8583();

            //3. Create Arrays
            string[] DE = new string[130];

            //4. Assign corresponding data to each array
            //   Ex: ISO8583 Data Element No.2 (PAN) shall assign to newly created array, DE[2];
            DE[103] = ToAccount;
            DE[102] = FromAccount;
            DE[4] = TranAmount;
            DE[11] = BankTranId;
            DE[7] = "0429104720";
            DE[73] = PaymentDate;
            DE[42] = Teller;
            DE[62] = ApprovedBy;
            DE[2] = BankCode;
            DE[104] = Narration;
            DE[47] = Password;
            DE[46] = DigitalSignature;
            DE[48] = TranCategory;
            DE[43] = BranchCode;
            DE[49] = CurrencyCode;
            DE[41] = PaymentType;
            DE[56] = CustomerName;
            DE[61] = ChequeNumber;


            //5.Use "Build" method of object iso8583 to create a new  message.
            //60197105032103634
            string NewISOmsg = Buildiso8583.Build(DE, MTI);
            return NewISOmsg;
        }

        private static string GetISO8583AccountBalMessageToSend()
        {
            string MTI = "0100";
            string ToAccount = "20160129191147046";//DE[103]
            string FromAccount = "";//DE[102]
            string TranAmount = "";//DE[4]
            string BankTranId = "";//DE[11]
            string PaymentDate = "";//DE[7]  (format: MMDDhhmmss)
            string Teller = "";//DE[42]
            string ApprovedBy = "";//DE[61]
            string BankCode = "12345";//DE[2]----NO
            string Narration = "";//DE[104]----ans100
            string Password = "T3rr1613";//DE[47]
            string DigitalSignature = "";//DE[46]
            string TranCategory = "";//DE[48]
            string BranchCode = "";//DE[43]
            string CurrencyCode = "";//DE[49]
            string CustomerName = "";
            string PaymentType = "";
            string ChequeNumber = "";

            //2.Create an object BIM-ISO8583.ISO8583
            BIM_ISO8583.NET.ISO8583 Buildiso8583 = new BIM_ISO8583.NET.ISO8583();

            //3. Create Arrays
            string[] DE = new string[130];

            //4. Assign corresponding data to each array
            //   Ex: ISO8583 Data Element No.2 (PAN) shall assign to newly created array, DE[2];
            DE[103] = ToAccount;
            DE[102] = FromAccount;
            DE[4] = TranAmount;
            DE[11] = BankTranId;
            DE[7] = "0429104720";
            DE[73] = PaymentDate;
            DE[42] = Teller;
            DE[62] = ApprovedBy;
            DE[2] = BankCode;
            DE[104] = Narration;
            DE[47] = Password;
            DE[46] = DigitalSignature;
            DE[48] = TranCategory;
            DE[43] = BranchCode;
            DE[49] = CurrencyCode;
            DE[41] = PaymentType;
            DE[56] = CustomerName;
            DE[61] = ChequeNumber;


            //5.Use "Build" method of object iso8583 to create a new  message.
            //60197105032103634
            string NewISOmsg = Buildiso8583.Build(DE, MTI);
            return NewISOmsg;
        }

        private static string GetISO8583EchoMessageToSend()
        {
            
            BIM_ISO8583.NET.ISO8583 Parseiso8583 = new BIM_ISO8583.NET.ISO8583();
            string echoRequest = "";
            string MTI = "0800";
            string echo = "309";

            string[] DE = new string[130];
            DE[70] = echo;
            echoRequest = Parseiso8583.Build(DE, MTI);
            return echoRequest;
        }

        private static void TestReversalCoreBankingSwitch()
        {
            Socket clientSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            clientSocket.Connect("127.0.0.1", 4128);

            BIM_ISO8583.NET.ISO8583 Parseiso8583 = new BIM_ISO8583.NET.ISO8583();
            string HexISOMessage = GetISO8583ReversalMessageToSend();

            Console.WriteLine("ISO 8583 Request:" + HexISOMessage);
            byte[] outStream = Encoding.UTF8.GetBytes(HexISOMessage);
            clientSocket.Send(outStream);
            byte[] inStream = new byte[100025];
            int result = clientSocket.Receive(inStream);

            string returndata = Encoding.UTF8.GetString(inStream, 0, result);
            Console.WriteLine("Response:" + returndata);
            string[] DE = new string[130];
            DE = Parseiso8583.Parse(returndata);
            string statusCode = DE[39];
            string StatusDesc = DE[47];
            string PegPayId = DE[48];
            Console.Read();
        }

        private static void TestTransactCoreBankingSwitch()
        {
            Socket clientSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            clientSocket.Connect("127.0.0.1", 4128);

            BIM_ISO8583.NET.ISO8583 Parseiso8583 = new BIM_ISO8583.NET.ISO8583();
            string HexISOMessage = GetISO8583TransactMessageToSend();
            Console.WriteLine("ISO 8583 Request:" + HexISOMessage);
            byte[] outStream = Encoding.UTF8.GetBytes(HexISOMessage);
            clientSocket.Send(outStream);
            byte[] inStream = new byte[100025];
            int result = clientSocket.Receive(inStream);

            string returndata = Encoding.UTF8.GetString(inStream, 0, result);
            Console.WriteLine("Response:" + returndata);
            string[] DE = new string[130];
            DE = Parseiso8583.Parse(returndata);
            string statusCode = DE[39];
            string StatusDesc = DE[47];
            string PegPayId = DE[48];
            Console.Read();
        }

        public static string GetISO8583TransactMessageToSend()
        {
            string MTI = "0200";
            string ToAccount = "20160129191147046";//DE[103]
            string FromAccount = "20160129190440285";//DE[102]
            string TranAmount = "1000";//DE[4]
            string BankTranId = "9095";//DE[11]
            string PaymentDate = "14/04/04";//DE[7]  (format: MMDDhhmmss)
            string Teller = "Pegasus";//DE[42]
            string ApprovedBy = "Mr.Ronald";//DE[61]
            string BankCode = "12345";//DE[2]----NO
            string Narration = "PegasusSwitchTestTransaction";//DE[104]----ans100
            string Password = "T3rr1613";//DE[47]
            string DigitalSignature = "kjhgfdyuioplkjbvgvhok2kj3h454j32k3j45v6b543mnb4345h65434554n";//DE[46]
            string TranCategory = "DEPOSIT";//DE[48]
            string BranchCode = "PegasusBranch";//DE[43]
            string CurrencyCode = "UGS";//DE[49]
            string CustomerName = "Kiracho Islam";
            string PaymentType = "CASH";
            string ChequeNumber = "";

            //2.Create an object BIM-ISO8583.ISO8583
            BIM_ISO8583.NET.ISO8583 Buildiso8583 = new BIM_ISO8583.NET.ISO8583();

            //3. Create Arrays
            string[] DE = new string[130];

            //4. Assign corresponding data to each array
            //   Ex: ISO8583 Data Element No.2 (PAN) shall assign to newly created array, DE[2];
            DE[103] = ToAccount;
            DE[102] = FromAccount;
            DE[4] = TranAmount;
            DE[11] = BankTranId;
            DE[7] = "0429104720";
            DE[73] = PaymentDate;
            DE[42] = Teller;
            DE[62] = ApprovedBy;
            DE[2] = BankCode;
            DE[104] = Narration;
            DE[47] = Password;
            DE[46] = DigitalSignature;
            DE[48] = TranCategory;
            DE[43] = BranchCode;
            DE[49] = CurrencyCode;
            DE[41] = PaymentType;
            DE[56] = CustomerName;
            DE[61] = ChequeNumber;


            //5.Use "Build" method of object iso8583 to create a new  message.
            //60197105032103634
            string NewISOmsg = Buildiso8583.Build(DE, MTI);
            return NewISOmsg;
            

        }

        public static string GetISO8583ReversalMessageToSend()
        {
            string MTI = "0400";
            string ToAccount = "";//DE[103]
            string FromAccount = "";//DE[102]
            string TranAmount = "";//DE[4]
            string BankTranId = "9095";//DE[11]
            string PaymentDate = "";//DE[7]  (format: MMDDhhmmss)
            string Teller = "Pegasus";//DE[42]
            string ApprovedBy = "Mr.Ronald";//DE[61]
            string BankCode = "12345";//DE[2]----NO
            string Narration = "";//DE[104]----ans100
            string Password = "T3rr1613";//DE[47]
            string DigitalSignature = "kjhgfdyuioplkjbvgvhok2kj3h454j32k3j45v6b543mnb4345h65434554n";//DE[46]
            string TranCategory = "=";//DE[48]
            string BranchCode = "=";//DE[43]
            string CurrencyCode = "";//DE[49]
            string CustomerName = "";
            string PaymentType = "";
            string ChequeNumber = "";

            //2.Create an object BIM-ISO8583.ISO8583
            BIM_ISO8583.NET.ISO8583 Buildiso8583 = new BIM_ISO8583.NET.ISO8583();

            //3. Create Arrays
            string[] DE = new string[130];

            //4. Assign corresponding data to each array
            //   Ex: ISO8583 Data Element No.2 (PAN) shall assign to newly created array, DE[2];
            DE[103] = ToAccount;
            DE[102] = FromAccount;
            DE[4] = TranAmount;
            DE[11] = BankTranId;
            DE[7] = "0429104720";
            DE[73] = PaymentDate;
            DE[42] = Teller;
            DE[62] = ApprovedBy;
            DE[2] = BankCode;
            DE[104] = Narration;
            DE[47] = Password;
            DE[46] = DigitalSignature;
            DE[48] = TranCategory;
            DE[43] = BranchCode;
            DE[49] = CurrencyCode;
            DE[41] = PaymentType;
            DE[56] = CustomerName;
            DE[61] = ChequeNumber;


            //5.Use "Build" method of object iso8583 to create a new  message.
            //60197105032103634
            string NewISOmsg = Buildiso8583.Build(DE, MTI);
            return NewISOmsg;


        }
    }
}
