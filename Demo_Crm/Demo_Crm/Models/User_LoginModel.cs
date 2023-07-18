using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Demo_Crm.Models
{
    public class User_LoginModel
    {
        public int Fk_Userid { get; set; }
        public DateTime Punch_In { get; set; }
        public DateTime Punch_Out { get; set; }
        public DateTime End_Break { get; set; }
        public DateTime Lunch_Break { get; set; }
        public DateTime Get_Current_Date { get; set; }
        public string Remark { get; set; }
        public string WorkStatus { get; set; }
        public string msg { get; set; }
        public string name { get; set; }
        public bool Leave { get; set; }
        public bool Status { get; set; }
    }
}