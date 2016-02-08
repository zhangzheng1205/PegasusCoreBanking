using System;
using System.Collections.Generic;
using System.Text;


public class CoreBankingSocketListener
{
    public void StartListening(int Port,string IpAddress) 
    {
        AsynchronousSocketListener listener = new AsynchronousSocketListener();
        listener.StartListening(Port,IpAddress);
    }
}

