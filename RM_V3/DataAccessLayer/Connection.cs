using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class Connection
    {
        private static string connectionString=@"Data Source=key\sqlexpress;Initial Catalog=RestaurantManagement;Integrated Security=True";
        private static SqlConnection connection=new SqlConnection(connectionString);

        public static void Open()
        {
            if(connection.State==ConnectionState.Closed||connection.State==ConnectionState.Broken)
            {
                connection.Open();
            }
        }

        public static void Close()
        {
            connection.Close();
        }
    }
}
