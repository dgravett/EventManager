using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EventManagerWebApp.DBEnum
{
    public class Event
    {
        public enum Type
        {
            Private = 1,
            Public = 2,
            RSO = 3
        }
    }
}