package swp.charite.diagnosis.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import swp.charite.diagnosis.dto.GuidanceDto;
import swp.charite.diagnosis.model.Guidance;
import swp.charite.diagnosis.repository.GuidanceRepository;

@Service
public class GuidanceService {
    
    @Autowired
    private GuidanceRepository guidanceRepository;

    public String create(GuidanceDto guidance) {
        if (!guidanceRepository.existsByDiaId(guidance.getDia_id())){
            Date date = new Date();
            Guidance newGuidance = new Guidance(null, guidance.getDia_id(), guidance.getGuidance(),
                guidance.getPriority(), date.toString(), false);
            guidanceRepository.save(newGuidance);
            return "Create guidance successfully!";
        } else {
            return "Guidance exists!";
        }
    }

    public Guidance query(Long dia_id) {
        if (guidanceRepository.existsByDiaId(dia_id)){
            return guidanceRepository.findByDiaId(dia_id);
        } else {
            return null;
        }
    }

    public void update(Long g_id) {
        if (guidanceRepository.existsById(g_id)) {
            Date date = new Date();
            Guidance oldGuidance = guidanceRepository.findByGuidanceId(g_id);
            oldGuidance.setDate(date.toString());;
            oldGuidance.setDone(true);;
        }
    }
}
