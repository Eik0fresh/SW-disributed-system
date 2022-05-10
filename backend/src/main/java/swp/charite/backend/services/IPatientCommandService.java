package swp.charite.backend.services;

import swp.charite.backend.dto.PatientDto;

import java.util.Optional;

public interface IPatientCommandService {

    Optional<Long> handleCreate(PatientDto patientDto);

}
