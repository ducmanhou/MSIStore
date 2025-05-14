using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DAL;
using DTO;
namespace BLL
{
    public class FeedbackBL
    {
        private FeedbackDL feedbackDL;

        public FeedbackBL()
        {
            feedbackDL = new FeedbackDL();
        }

        public int Add(Feedback feedback)
        {
            return feedbackDL.Add(feedback);
        }
        public List<Feedback> GetAllFeedbacks()
        {
            return feedbackDL.GetAllFeedbacks();
        }


    }
}
