package swp.charite.feedbacks.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import swp.charite.feedbacks.model.Guidance;
import swp.charite.feedbacks.repository.GuidanceRepository;

@Service
public class GuidanceService {
    
    @Autowired
    private GuidanceRepository guidanceRepository;

    public void create(Guidance guidance) {
        if (!guidanceRepository.existsById(guidance.getG_id())){
            Guidance newGuidance = new Guidance(guidance.getG_id(), guidance.getGuidance());
            guidanceRepository.save(newGuidance);
        } 
    }

}
