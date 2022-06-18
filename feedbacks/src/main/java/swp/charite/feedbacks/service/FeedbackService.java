package swp.charite.feedbacks.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import swp.charite.feedbacks.dto.FeedbackDto;
import swp.charite.feedbacks.model.Feedback;
import swp.charite.feedbacks.model.Guidance;
import swp.charite.feedbacks.repository.FeedbackRepository;
import swp.charite.feedbacks.repository.GuidanceRepository;

@Service
public class FeedbackService {
    
    @Autowired
    private FeedbackRepository feedbackRepository;

    @Autowired
    private GuidanceRepository guidanceRepository;

    public String addFeedback(FeedbackDto feedback) {
        Date date = new Date();
        Feedback newFeedback = new Feedback(null, feedback.getG_id(), feedback.getFeedback(), date.toString());
        feedbackRepository.save(newFeedback);
        return "Submit feedback successfully!";
    }

    public List<Feedback> queryFeedback(Long g_id) {

        List<Feedback> feedbacks = feedbackRepository.findByG_id(g_id);

        return feedbacks;
    }

    public String addGuidance(Guidance guidance) {
        /*if (!guidanceRepository.existsById(guidance.getG_id())){
            Guidance newGuidance = new Guidance(guidance.getG_id(), guidance.getGuidance());
            guidanceRepository.save(newGuidance);
            return "Create guidance successfully!";
        } else {
            return "Guidance exists!";
        }*/
        return "Hi";
    }
}
