package swp.charite.diagnosis.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import swp.charite.diagnosis.dto.DoctorCreateEventDto;
import swp.charite.diagnosis.model.Doctor;
import swp.charite.diagnosis.repository.DoctorRepository;

import javax.transaction.Transactional;

@Service
public class DoctorCommandService {

    @Autowired
    DoctorRepository doctorRepository;

    @Autowired
    ObjectMapper mapper;

    @Transactional
    public void handleDoctorCreated(JsonNode doctorData) throws JsonProcessingException {
        DoctorCreateEventDto doctorCreateEventDto = mapper.treeToValue(mapper.readTree(doctorData.asText()), DoctorCreateEventDto.class);
        if (!doctorRepository.existsById(doctorCreateEventDto.getId())) {
            Doctor doctor = new Doctor(doctorCreateEventDto.getId(), doctorCreateEventDto.getFirstname(), doctorCreateEventDto.getSurname());
            doctorRepository.save(doctor);
        }
    }

    // TO-DO
    public void delete(Long id) {
        if (doctorRepository.existsById(id)) {
            doctorRepository.deleteById(id);
        }
    }

}