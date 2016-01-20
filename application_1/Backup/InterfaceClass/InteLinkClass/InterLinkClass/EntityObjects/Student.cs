using System;
using System.Collections.Generic;
using System.Text;

namespace InterLinkClass.EntityObjects
{
    public class Student
    {
        public string Balance;
        public string SchoolCode;
        public string StudentName;
        public string StudentRef;
        public string StatusCode;
        public string StatusDescription;

        public void Validate() 
        {
            try
            {
                if (String.IsNullOrEmpty(StudentName))
                {
                    throw new ValidationException("Student Name Cannot Be Empty");
                }
                if (String.IsNullOrEmpty(StudentRef))
                {
                    this.StudentRef = "";
                }
                if (String.IsNullOrEmpty(SchoolCode))
                {
                    throw new ValidationException("School Code Cannot Be Empty");
                }
                if (String.IsNullOrEmpty(Balance))
                {
                    this.Balance = "0";
                }
                if (!IsNumeric(Balance))
                {
                    throw new ValidationException("Invalid Customer Balance");
                }
                this.StatusCode = "0";
                this.StatusDescription = "OK";
            }
            catch (Exception e) 
            {
                this.StatusCode = "02";
                this.StatusDescription = e.Message;
            }
        }

        private bool IsNumeric(string number)
        {
            try
            {
                int num = Convert.ToInt32(number);
                return true;

            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
