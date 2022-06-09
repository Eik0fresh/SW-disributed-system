package swp.charite.diagnosis.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import swp.charite.diagnosis.dto.PatientDto;

@Component
@FeignClient(value = "PATIENT-MANAGEMENT")
public interface PatientService {
    
    @PostMapping(value = "/patient/query")
    public Long query(@RequestBody PatientDto patient);
}
