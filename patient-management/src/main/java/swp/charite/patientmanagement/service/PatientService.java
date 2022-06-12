package swp.charite.patientmanagement.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
    public String addPatient(PatientDto patient) {
        if (!patientRepository.existsByFirstnameAndSurname(patient.getFirstname(), patient.getSurname())) {
            Patient newPatient = new Patient(null, patient.getFirstname(), patient.getSurname(), patient.getEmail());
            patientRepository.save(newPatient);

            PatientCreateEventDto patientCreateEventDto = new PatientCreateEventDto(newPatient.getP_id(), newPatient.getFirstname(), newPatient.getSurname());
            JsonNode jsonNode = mapper.convertValue(patientCreateEventDto, JsonNode.class);
            OutboxEntity o = new OutboxEntity(UUID.randomUUID(), "patient", newPatient.getP_id().toString(), "patient_created", jsonNode.toString());
            outboxRepository.save(o);
            outboxRepository.delete(o);

            return "Create patient successfully!";
        } else {
            return "Patient exists!";
        }
    }

    public String updateEmail(PatientDto patient) {
        if (!patientRepository.existsByFirstnameAndSurname(patient.getFirstname(), patient.getSurname())) {
            return "No patient exists!";
        } else {
            Patient oldPatient = patientRepository.findByFirstnameAndSurname(patient.getFirstname(), patient.getSurname());
            oldPatient.setEmail(patient.getEmail());
            patientRepository.save(oldPatient);
            return "Update email successfully!";
        }
    }

    public Patient queryPatient(PatientDto patient) {
        if (!patientRepository.existsByFirstnameAndSurname(patient.getFirstname(), patient.getSurname())) {
            return null;
        } else {
            Patient oldPatient = patientRepository.findByFirstnameAndSurname(patient.getFirstname(), patient.getSurname());
            return oldPatient;
        }
    }

    public String deletePatient(Long id) {
        if (patientRepository.existsById(id)) {
            patientRepository.deleteById(id);;
            return "Delete patient successfully!";
        } else {
            return "Invalid patient ID.";
        }
    }
}
