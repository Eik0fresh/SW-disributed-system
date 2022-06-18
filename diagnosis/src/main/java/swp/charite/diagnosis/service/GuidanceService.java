package swp.charite.diagnosis.service;

import java.util.Date;
import java.util.UUID;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import swp.charite.diagnosis.dto.GuidanceCreateEventDto;
import swp.charite.diagnosis.dto.GuidanceDto;
import swp.charite.diagnosis.model.Guidance;
import swp.charite.diagnosis.model.OutboxEntity;
import swp.charite.diagnosis.model.Priority;
import swp.charite.diagnosis.repository.GuidanceRepository;
import swp.charite.diagnosis.repository.OutboxRepository;

@Service
public class GuidanceService {

    @Autowired
    private ObjectMapper mapper;

    @Autowired
    private GuidanceRepository guidanceRepository;

    @Autowired
    private OutboxRepository outboxRepository;

    public String create(GuidanceDto guidance) {
        if (!guidanceRepository.existsByDiaId(guidance.getDia_id())){
            Date date = new Date();
            Guidance newGuidance = new Guidance(null, guidance.getDia_id(), guidance.getGuidance(),
                Priority.valueOf(guidance.getPriority()), date.toString(), false);
            guidanceRepository.save(newGuidance);

            GuidanceCreateEventDto guidanceCreateEventDto = new GuidanceCreateEventDto(newGuidance.getGuidanceId(),
                    newGuidance.getGuidance(), newGuidance.getPriority(), newGuidance.getDate(), newGuidance.getDone());
            JsonNode jsonNode = mapper.convertValue(guidanceCreateEventDto, JsonNode.class);
            OutboxEntity o = new OutboxEntity(UUID.randomUUID(), "guidance", newGuidance.getGuidanceId().toString(), "guidance_added", jsonNode.toString());
            outboxRepository.save(o);
            outboxRepository.delete(o);

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
            oldGuidance.setDate(date.toString());
            oldGuidance.setDone(true);
        }
    }
}
