using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;

namespace Tester
{
    class Program
    {
        static void Main(string[] args)
        {
            int Port = int.Parse(ConfigurationManager.AppSettings["Port"]);
            string IpAddress = ConfigurationManager.AppSettings["IpAddress"];
            CoreBankingSocketListener socket = new CoreBankingSocketListener();
            socket.StartListening(Port, IpAddress);
        }
    }
}
