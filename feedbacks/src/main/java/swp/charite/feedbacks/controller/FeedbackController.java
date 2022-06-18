package swp.charite.feedbacks.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import swp.charite.feedbacks.dto.FeedbackDto;
import swp.charite.feedbacks.dto._Feedback;
import swp.charite.feedbacks.model.Guidance;
import swp.charite.feedbacks.service.FeedbackService;
import swp.charite.feedbacks.service.GuidanceService;

@RestController
public class FeedbackController {
    
    @Autowired
    private FeedbackService feedbackService;

    @Autowired
    private GuidanceService guidanceService;

    @PostMapping(value = "/feedback/create")
    public void createFeedback(@RequestBody FeedbackDto feedback) {
        feedbackService.create(feedback);
    }

    @GetMapping(value = "/feedback/query/{g_id}")
    public List<_Feedback> query(@PathVariable("g_id") Long g_id){
        return feedbackService.query(g_id);
    }

    @PostMapping(value = "/guidance/create") 
    public void createGuidance(@RequestBody Guidance guidance) {
        guidanceService.create(guidance);
    }
}
