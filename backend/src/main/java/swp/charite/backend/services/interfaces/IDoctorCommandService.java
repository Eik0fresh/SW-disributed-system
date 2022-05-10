package swp.charite.backend.services.interfaces;

import swp.charite.backend.dto.DiagnosisDto;
import swp.charite.backend.dto.DoctorDto;
import swp.charite.backend.dto.PatientDto;

import java.util.Optional;

public interface IDoctorCommandService {

    Optional<Long> handleCreate(DoctorDto doctorDto);
}
