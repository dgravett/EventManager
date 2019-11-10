using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventManagerWebApp
{
    public class GlobalUserPassport
    {
        public static UserPassport globalUserPassport { get; set; }
    }

    public class UserPassport
    {
        public int userId { get; set; }

        public string userName { get; set; }

        public int userType { get; set; }

        public int universityId { get; set; }

        public UserPassport(int UserId, string UserName, int UserType, int UniversityId)
        {
            userId = UserId;
            userName = UserName;
            userType = UserType;
            universityId = UniversityId;
        }
    }
}