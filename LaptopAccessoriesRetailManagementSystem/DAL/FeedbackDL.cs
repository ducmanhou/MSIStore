    using DTO;
    using System;
    using System.Collections.Generic;
    using System.Data.SqlClient;
    using System.Data;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;

    namespace DAL
    {
        public class FeedbackDL:DataAccess
        {
            public int Add(Feedback feedback)
            {
                string sql = "INSERT INTO msistoredb.[feedback] (user_id, order_id, comment, createdAt) " +
                             "VALUES (@UserId, @OrderId, @Comment, @CreatedAt)";
                List<SqlParameter> parameters = new List<SqlParameter>()
        {
            new SqlParameter("@UserId", feedback.UserId),
            new SqlParameter("@OrderId", feedback.OrderId),
            new SqlParameter("@Comment", feedback.Comment),
            new SqlParameter("@CreatedAt", feedback.CreatedAt)
        };
                return MyExcuteNonQuery(sql, CommandType.Text, parameters);
            }
        public List<Feedback> GetAllFeedbacks()
        {
            List<Feedback> feedbacks = new List<Feedback>();
            string sql = "SELECT * FROM msistoredb.[feedback]";

            try
            {
                Connect();
                SqlDataReader reader = MyExecuteReader(sql, CommandType.Text);
                while (reader.Read())
                {
                    int id = Convert.ToInt32(reader["id"]);
                    int userId = Convert.ToInt32(reader["user_id"]);
                    int orderId = Convert.ToInt32(reader["order_id"]);
                    string comment = reader["comment"].ToString();
                    DateTime createdAt = Convert.ToDateTime(reader["createdAt"]);

                    Feedback fb = new Feedback(id, userId, orderId, comment, createdAt);
                   

                    feedbacks.Add(fb);
                }
                reader.Close();
                return feedbacks;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            finally
            {
                DisConnect();
            }
        }

    }
    }
