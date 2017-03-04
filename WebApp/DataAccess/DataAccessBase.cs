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
            _connectionString = ConfigurationManager.ConnectionStrings["GiffDBConnectionString"].ConnectionString;
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
