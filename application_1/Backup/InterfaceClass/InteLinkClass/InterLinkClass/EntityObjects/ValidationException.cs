using System;
using System.Collections.Generic;
using System.Text;

namespace InterLinkClass.EntityObjects
{
    public class ValidationException : Exception
    {
        public ValidationException(string Message)
            : base(Message)
        {

        }
    }
}
