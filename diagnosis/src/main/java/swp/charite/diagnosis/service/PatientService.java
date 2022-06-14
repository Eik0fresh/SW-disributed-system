package swp.charite.diagnosis.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import swp.charite.diagnosis.dto.PatientDto;
import swp.charite.diagnosis.model.Patient;
import swp.charite.diagnosis.repository.PatientRepository;

@Service
public class PatientService {
    
    @Autowired
    private PatientRepository patientRepository;

    public void create(Patient patient) {
        if (!patientRepository.existsById(patient.getP_id())) {
            Patient newPatient = new Patient(patient.getP_id(), patient.getFirstname(), patient.getSurname());
            patientRepository.save(newPatient);
        } 
    }

    public Long query(PatientDto patient) {
        if (!patientRepository.existsByFirstnameAndSurname(patient.getFirstname(), patient.getSurname())) {
            return null;
        } else {
            Patient oldPatient = patientRepository.findByFirstnameAndSurname(patient.getFirstname(), patient.getSurname());
            return oldPatient.getP_id();
        }
    }

    public void delete(Long id) {
        if (patientRepository.existsById(id)) {
            patientRepository.deleteById(id);
        }
    }
}
