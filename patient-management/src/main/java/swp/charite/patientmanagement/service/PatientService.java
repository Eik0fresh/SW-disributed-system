package swp.charite.patientmanagement.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import swp.charite.patientmanagement.dto.EmailDto;
import swp.charite.patientmanagement.dto.PatientCreateEventDto;
import swp.charite.patientmanagement.dto.PatientDto;
import swp.charite.patientmanagement.model.OutboxEntity;
import swp.charite.patientmanagement.model.Patient;
import swp.charite.patientmanagement.repository.OutboxRepository;
import swp.charite.patientmanagement.repository.PatientRepository;

import javax.transaction.Transactional;

import java.util.UUID;

@Service
public class PatientService {

    @Autowired
    private ObjectMapper mapper;

    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private OutboxRepository outboxRepository;

    @Transactional
    public Boolean create(PatientDto patient) {
        if (!patientRepository.existsByFirstnameAndSurname(patient.getFirstname(), patient.getSurname())) {
            Patient newPatient = new Patient(null, patient.getFirstname(), patient.getSurname(), patient.getEmail());
            patientRepository.save(newPatient);

            PatientCreateEventDto patientCreateEventDto = new PatientCreateEventDto(newPatient.getPatientId(), newPatient.getFirstname(), newPatient.getSurname());
            JsonNode jsonNode = mapper.convertValue(patientCreateEventDto, JsonNode.class);
            OutboxEntity o = new OutboxEntity(UUID.randomUUID(), "patient", newPatient.getPatientId().toString(), "patient_created", jsonNode.toString());
            outboxRepository.save(o);
            outboxRepository.delete(o);

            return true;
        } else {
            return false;
        }
    }

    public Boolean update(EmailDto patient) {
        if (!patientRepository.existsById(patient.getP_id())) {
            return false;
        } else {
            Patient oldPatient = patientRepository.findByPatientId(patient.getP_id());
            oldPatient.setEmail(patient.getEmail());
            patientRepository.save(oldPatient);
            return true;
        }
    }

    public PatientDto query(Long p_id) {
        if (!patientRepository.existsById(p_id)) {
            return null;
        } else {
            Patient oldPatient = patientRepository.findByPatientId(p_id);
            return new PatientDto(oldPatient.getFirstname(), oldPatient.getSurname(), oldPatient.getEmail());
        }
    }

    public Boolean delete(Long id) {
        if (patientRepository.existsById(id)) {
            patientRepository.deleteById(id);;
            return true;
        } else {
            return false;
        }
    }
}
