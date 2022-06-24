package swp.charite.diagnosis.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import swp.charite.diagnosis.dto.PatientCreateEventDto;
import swp.charite.diagnosis.model.Patient;
import swp.charite.diagnosis.repository.PatientRepository;

import javax.transaction.Transactional;

@Service
public class PatientCommandService {

    @Autowired
    PatientRepository patientRepository;

    @Autowired
    ObjectMapper mapper;

    @Transactional
    public void handlePatientCreated(JsonNode patientData) throws JsonProcessingException {
        PatientCreateEventDto patientCreateEventDto = mapper.treeToValue(mapper.readTree(patientData.asText()), PatientCreateEventDto.class);
        if (!patientRepository.existsById(patientCreateEventDto.getId())) {
            Patient patient = new Patient(patientCreateEventDto.getId(), patientCreateEventDto.getFirstname(), patientCreateEventDto.getSurname());
            patientRepository.save(patient);
        }
    }

    // TO-DO
    public void delete(Long id) {
        if (patientRepository.existsById(id)) {
            patientRepository.deleteById(id);
        }
    }
}
