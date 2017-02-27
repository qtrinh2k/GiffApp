using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApp
{
    public class DataAccessBase : IDisposable
    {
        public DataAccessBase()
        {
            var configConn = ConfigurationManager.ConnectionStrings.CurrentConfiguration;
            _connectionString = @"Data Source=(localdb)\ProjectsV13;Initial Catalog=Giffi;Integrated Security=True;Connect Timeout=60;Encrypt=False;TrustServerCertificate=True;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
            //_connectionString = @"Data Source=(localdb)\ProjectsV13;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Connect Timeout=60;Encrypt=False;TrustServerCertificate=True";//ConfigurationManager.AppSettings.Get("ConnectionString");
        }

        string _connectionString;
        public string ConnectionString
        {            
            get
            {
                return _connectionString;
            }
            set
            {
                _connectionString = value;
            }
        }

        public DataTable FillDataTable(string sqlQuery)
        {
            DataTable table = null;

            using (SqlConnection connection = GetConnection())
            {                
                using (IDbCommand sqlCmd = new SqlCommand(sqlQuery, connection))
                {
                    connection.Open();
                    sqlCmd.CommandType = CommandType.StoredProcedure;

                    var reader = sqlCmd.ExecuteReader(CommandBehavior.CloseConnection);

                    table = new DataTable();
                    table.Load(reader);
                }                
            }

            return table;
        }

        public int ExecuteNonQuery(string sqlQuery)
        {
            using (SqlConnection connection = GetConnection())
            {
                using (IDbCommand sqlCmd = new SqlCommand(sqlQuery, connection))
                {
                    connection.Open();
                    sqlCmd.CommandType = CommandType.StoredProcedure;

                    return sqlCmd.ExecuteNonQuery();
                }
            }
        }

        public SqlConnection GetConnection()
        {
            return new SqlConnection(ConnectionString);
        }

        public void Dispose()
        {
        }
    }
}
