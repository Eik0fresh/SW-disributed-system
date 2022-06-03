package swp.charite.patientmanagement.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import swp.charite.patientmanagement.dto.PatientDto;
import swp.charite.patientmanagement.model.Patient;
import swp.charite.patientmanagement.repository.PatientRepository;

@Service
public class PatientService {
    
    @Autowired
    private PatientRepository patientRepository;
    
    public String addPatient(PatientDto patient) {
        if (!patientRepository.existsByFirstnameAndSurname(patient.getFirstname(), patient.getSurname())) {
            Patient newPatient = new Patient(null, patient.getFirstname(), patient.getSurname(), patient.getEmail());
            patientRepository.save(newPatient);
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

    public String deletePatient(long id) {
        if (patientRepository.existsById(id)) {
            patientRepository.deleteById(id);;
            return "Delete patient successfully!";
        } else {
            return "Invalid patient ID.";
        }
    }
}
