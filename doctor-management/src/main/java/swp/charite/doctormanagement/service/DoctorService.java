package swp.charite.doctormanagement.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import swp.charite.doctormanagement.dto.DoctorDto;
import swp.charite.doctormanagement.model.Doctor;
import swp.charite.doctormanagement.repository.DoctorRepository;

@Service
public class DoctorService {
    
    @Autowired
    private DoctorRepository doctorRepository;
    
    public String addDoctor(DoctorDto doctor) {
        if (!doctorRepository.existsByFirstnameAndSurname(doctor.getFirstname(), doctor.getSurname())) {
            Doctor newDoctor = new Doctor(null, doctor.getFirstname(), doctor.getSurname(), doctor.getEmail());
            doctorRepository.save(newDoctor);
            return "Create Doctor successfully!";
        } else {
            return "Doctor exists!";
        }
    }

    public String updateEmail(DoctorDto doctor) {
        if (!doctorRepository.existsByFirstnameAndSurname(doctor.getFirstname(), doctor.getSurname())) {
            return "No doctor exists!";
        } else {
            Doctor oldDoctor = doctorRepository.findByFirstnameAndSurname(doctor.getFirstname(), doctor.getSurname());
            oldDoctor.setEmail(doctor.getEmail());
            doctorRepository.save(oldDoctor);
            return "Update email successfully!";
        }
    }


    public Doctor queryDoctor(DoctorDto doctor) {
        if (!doctorRepository.existsByFirstnameAndSurname(doctor.getFirstname(), doctor.getSurname())) {
            return null;
        } else {
            Doctor oldDoctor = doctorRepository.findByFirstnameAndSurname(doctor.getFirstname(), doctor.getSurname());
            return oldDoctor;
        }
    }

    public String deleteDoctor(Long id) {
        if (doctorRepository.existsById(id)) {
            doctorRepository.deleteById(id);;
            return "Delete doctor successfully!";
        } else {
            return "Invalid doctor ID.";
        }
    }
}
