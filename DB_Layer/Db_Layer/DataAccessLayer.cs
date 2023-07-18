using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Db_Layer
{
    public class DataAccessLayer
    {

        SqlConnection connection = new SqlConnection("Data Source=shivampc;Initial Catalog=CRM;Integrated Security=True");

        public int insertData(string proc, SqlParameter[] param)
        {
            SqlCommand command = new SqlCommand(proc, connection);
            command.CommandType = CommandType.StoredProcedure;
            foreach (SqlParameter p in param)
            {
                command.Parameters.Add(p);
            }
            connection.Open();
            int res = command.ExecuteNonQuery();
            connection.Close();
            return res;
        }
        public DataTable DisplayData(string proc, SqlParameter[] param)
        {
            SqlCommand command = new SqlCommand(proc, connection);
            command.CommandType = CommandType.StoredProcedure;
            foreach (SqlParameter p in param)
            {
                if (p != null)
                {
                    command.Parameters.Add(p);
                }
            }
            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            return (dt);
        }
    }
}
