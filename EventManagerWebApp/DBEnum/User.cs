using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventManagerWebApp.DBEnum
{
    public class User
    {
        public enum Type
        {
            Student = 3,
            Admin = 2,
            SuperAdmin = 1
        }
    }
}