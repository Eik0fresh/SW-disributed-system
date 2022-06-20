package swp.charite.diagnosis.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import swp.charite.diagnosis.dto.MarkGuidanceDto;
import swp.charite.diagnosis.model.Guidance;
import swp.charite.diagnosis.repository.GuidanceRepository;

import javax.transaction.Transactional;

@Service
public class GuidanceCommandService {

    @Autowired
    private ObjectMapper mapper;

    @Autowired
    private GuidanceRepository guidanceRepository;

    @Transactional
    public void handleGuidanceDone(JsonNode guidanceData) throws JsonProcessingException {
        MarkGuidanceDto markGuidanceDto = mapper.treeToValue(guidanceData, MarkGuidanceDto.class);
        if (!guidanceRepository.existsById(markGuidanceDto.getId())) {
            Guidance guidance = guidanceRepository.getReferenceById(markGuidanceDto.getId());
            guidance.setDone(markGuidanceDto.isDone());
        }
    }

}
