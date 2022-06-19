package swp.charite.diagnosis.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import swp.charite.diagnosis.dto.DoctorDto;
import swp.charite.diagnosis.model.Doctor;
import swp.charite.diagnosis.repository.DoctorRepository;

@Service
public class DoctorService {
    
    @Autowired
    private DoctorRepository doctorRepository;

    public void create(Doctor doctor) {
        if (!doctorRepository.existsById(doctor.getD_id())) {
            Doctor newDoctor = new Doctor(doctor.getD_id(), doctor.getFirstname(), doctor.getSurname());
            doctorRepository.save(newDoctor);
        } 
    }

    public Long query(DoctorDto doctor) {
        if (!doctorRepository.existsByFirstnameAndSurname(doctor.getFirstname(), doctor.getSurname())) {
            return null;
        } else {
            Doctor oldDoctor = doctorRepository.findByFirstnameAndSurname(doctor.getFirstname(), doctor.getSurname());
            return oldDoctor.getD_id();
        }
    }

    public void delete(Long id) {
        if (doctorRepository.existsById(id)) {
            doctorRepository.deleteById(id);
        }
    }
}
