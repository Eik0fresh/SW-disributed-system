package swp.charite.feedbacks.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import swp.charite.feedbacks.dto.FeedbackDto;
import swp.charite.feedbacks.dto._Feedback;
import swp.charite.feedbacks.model.Feedback;
import swp.charite.feedbacks.repository.FeedbackRepository;


@Service
public class FeedbackService {
    
    @Autowired
    private FeedbackRepository feedbackRepository;

    public void create(FeedbackDto feedback) {
        Date date = new Date();
        Feedback newFeedback = new Feedback(null, feedback.getG_id(), feedback.getFeedback(), date.toString());
        feedbackRepository.save(newFeedback);
    }

    public List<_Feedback> query(Long g_id) {

        List<Feedback> tmp = feedbackRepository.findByG_id(g_id);
        List<_Feedback> feedbacks = new ArrayList<_Feedback>();

        for (Feedback feedback : tmp) {
            feedbacks.add(new _Feedback(feedback.getFeedback(), feedback.getDate()));
        }

        return feedbacks;
    }

}
