package swp.charite.feedbacks.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import swp.charite.feedbacks.dto.FeedbackDto;
import swp.charite.feedbacks.model.Feedback;
import swp.charite.feedbacks.model.Guidance;
import swp.charite.feedbacks.service.FeedbackService;

@RestController
@RequestMapping("/feedback")
public class FeedbackController {
    
    @Autowired
    private FeedbackService feedbackService;

    @PostMapping(value = "/create")
    public String create(@RequestBody FeedbackDto feedback) {
        return feedbackService.addFeedback(feedback);
    }

    @GetMapping(value = "/query/{g_id}")
    public List<Feedback> query(@PathVariable("g_id") Long g_id){
        return feedbackService.queryFeedback(g_id);
    }

    @PostMapping(value = "/guidance") 
    public String createGuidance(@RequestBody Guidance guidance) {
        return feedbackService.addGuidance(guidance);
    }
}
