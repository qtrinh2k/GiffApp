

namespace WebApp
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
    using System.Data;
    using System.Data.Sql;
    using System.Data.SqlClient;
    using System.Configuration;

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

        public DataTable FillDataTable(SqlCommand sqlCmd)
        {
            DataTable table = null;

            using (SqlConnection connection = GetConnection())
            {
                using (sqlCmd)
                {
                    sqlCmd.Connection = connection;
                    connection.Open();

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

        public int ExecuteNonQuery(List<SqlParameter> @params, CommandType cmdType, string cmdText)
        {
            using (SqlConnection connection = GetConnection())
            {
                using (IDbCommand sqlCmd = new SqlCommand(cmdText, connection))
                {
                    connection.Open();
                    sqlCmd.CommandType = cmdType;
                    foreach(var p in @params)
                    {
                        sqlCmd.Parameters.Add(p);
                    }
                    return sqlCmd.ExecuteNonQuery();
                }
            }
        }

        public int ExecuteNonQuery(SqlCommand sqlCmd)
        {
            using (SqlConnection connection = GetConnection())
            {
                using (sqlCmd)
                {
                    sqlCmd.Connection = connection;
                    connection.Open();
                    return sqlCmd.ExecuteNonQuery();
                }
            }
        }

        internal object ExecuteScalar(SqlCommand sqlCmd)
        {
            using (SqlConnection connection = GetConnection())
            {
                using (sqlCmd)
                {
                    sqlCmd.Connection = connection;
                    connection.Open();
                    return sqlCmd.ExecuteScalar();
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
