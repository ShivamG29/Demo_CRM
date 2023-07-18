using Microsoft.Ajax.Utilities;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Db_Layer;
using Demo_Crm;
using Demo_Crm.Models;
using System.Data.SqlClient;
using System.Data;

namespace Demo_Crm.Controllers
{
    public class HomeController : Controller
    {
        DataAccessLayer Dba = new DataAccessLayer();
        public ActionResult Index()
        {
            return View();
        }
       
        //[HttpPost]
        //public ActionResult Index(BtnTypeModel Bt_Type)
        //{
        //    if (Bt_Type.Check_in == "Check_in")
        //    {
        //        ViewBag.CheckIn = "yes I am Check in";
        //        SqlParameter[] param = new SqlParameter[]
        //        {
        //            new SqlParameter("@Checkin",2)//Update Check-in
        //        };
        //        DataTable Dt = Dba.DisplayData("Sp_UserLogin", param);
        //        ViewData["Dt"] = Dt;
        //        return View();

        //    }
        //    else if (Bt_Type.End_Breck == "End_Breck") { ViewBag.CheckIn = "yes I am Check in"; }
        //    else if (Bt_Type.Breck == "Breck") { ViewBag.CheckIn = "yes I am Breck"; }
        //    else if (Bt_Type.OnLeave == "OnLeave") { ViewBag.CheckIn = "yes I am OnLeave "; }
        //    else if (Bt_Type.Check_Out == "Check_Out") { ViewBag.CheckIn = "yes I am Check_Out "; }
        //return View();
        //}
        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
        public ActionResult SelectData()
        {
            SqlParameter[] param = new SqlParameter[]
            {
                    new SqlParameter("@action",1)//To select The record
            };
            DataTable dt1 = Dba.DisplayData("sp_Details", param);
            List<User_LoginModel> list = new List<User_LoginModel>();
            foreach (DataRow row in dt1.Rows)
            {
                User_LoginModel Um = new User_LoginModel();
                Um.name = row["name"].ToString();
                Um.WorkStatus = row["WorkStatus"].ToString();
                //Um.Punch_In =Convert.ToDateTime(row["Punch_In"].ToString());
                list.Add(Um);
            }
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Checkin()
        {
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@action",2), //Update Check-In
            };
            DataTable dt= Dba.DisplayData("Sp_UserLogin", parameters);
            List<User_LoginModel> list = new List<User_LoginModel>();
            foreach(DataRow row in dt.Rows)
            {
                User_LoginModel um = new User_LoginModel();
                um.msg = row["msg"].ToString();
                //um.Status = Convert.ToBoolean(row["Status"]);
                list.Add(um);
            }
                return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult CheckOut()
        {
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@action",5),//Update Check-out
            };
            DataTable dt = Dba.DisplayData("Sp_UserLogin", parameters);
            List<User_LoginModel> list = new List<User_LoginModel>();
            foreach (DataRow row in dt.Rows)
            {
                User_LoginModel um = new User_LoginModel();
                um.msg = row["msg"].ToString();
                //um.Status = Convert.ToBoolean(row["Status"]);
                list.Add(um);
            }
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult Breck()
        {
            SqlParameter[] parameters = new SqlParameter[]
            {
                 new SqlParameter("@action",3),//Start your Lunch time
            };
            DataTable dt = Dba.DisplayData("Sp_UserLogin", parameters);
            List<User_LoginModel> list = new List<User_LoginModel>();
            foreach(DataRow row in dt.Rows)
            {
                User_LoginModel um = new User_LoginModel();
                um.msg = row["msg"].ToString();
                list.Add(um);
            }
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult EndBreck()
        {
            SqlParameter[] parameters = new SqlParameter[]
{
                new SqlParameter("@action",4),//End Lunch Time
};
            DataTable dt = Dba.DisplayData("Sp_UserLogin", parameters);
            List<User_LoginModel> list = new List<User_LoginModel>();
            foreach (DataRow row in dt.Rows)
            {
                User_LoginModel um = new User_LoginModel();
                um.msg = row["msg"].ToString();
                list.Add(um);
            }
            return Json(list, JsonRequestBehavior.AllowGet);
        }
        public JsonResult OnLeave() { return Json("OnLeave", JsonRequestBehavior.AllowGet); }



    }
}