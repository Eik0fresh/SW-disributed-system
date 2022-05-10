package swp.charite.backend.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import swp.charite.backend.dto.DoctorDto;
import swp.charite.backend.model.Doctor;
import swp.charite.backend.repository.DoctorRepository;
import swp.charite.backend.services.interfaces.IDoctorCommandService;

import java.util.Optional;

@Service
public class DoctorCommandService implements IDoctorCommandService {

    @Autowired
    DoctorRepository doctorRepository;

    @Override
    public Optional<Long> handleCreate(DoctorDto doctorDto) {
        if (doctorDto.getFirstname() == null || doctorDto.getSurname() == null) {
            return Optional.empty();
        }
        Doctor newDoctor = new Doctor(null, doctorDto.getFirstname(), doctorDto.getSurname());
        doctorRepository.save(newDoctor);
        return Optional.of(newDoctor.getD_id());
    }
}
