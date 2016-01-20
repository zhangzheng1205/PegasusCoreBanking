using System;
using System.Collections.Generic;
using System.Text;

namespace InterLinkClass.EntityObjects
{
    class TransactionResend
    {
        string tranId, vendortranId, vendorcode;
        public string TranId
        {
            get {return tranId;}
            set {tranId= value;}
        }
        public string VendortranId
        {
            get { return vendortranId; }
            set { vendortranId = value; }
        }
        public string Vendorcode
        {
            get { return vendorcode; }
            set { vendorcode = value; }
        }
    }
}
