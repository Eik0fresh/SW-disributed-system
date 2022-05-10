package swp.charite.backend.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import swp.charite.backend.dto.PatientDto;
import swp.charite.backend.model.Patient;
import swp.charite.backend.repository.PatientRepository;
import swp.charite.backend.services.interfaces.IPatientCommandService;

import java.util.Optional;

@Service
public class PatientCommandService implements IPatientCommandService {

    @Autowired
    PatientRepository patientRepository;

    @Override
    public Optional<Long> handleCreate(PatientDto patientDto) {
        if (patientDto.getFirstname() == null || patientDto.getSurname() == null) {
            return Optional.empty();
        }
        Patient newPatient = new Patient(null, patientDto.getFirstname(), patientDto.getSurname());
        patientRepository.save(newPatient);
        return Optional.of(newPatient.getP_id());
    }
}
