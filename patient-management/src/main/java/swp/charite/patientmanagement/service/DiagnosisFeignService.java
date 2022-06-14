package swp.charite.patientmanagement.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import swp.charite.patientmanagement.dto._PatientDto;

@Component
@FeignClient(value = "DIAGNOSIS")
public interface DiagnosisFeignService {
    
    @PostMapping(value = "/patient/create")
    public void createPatient(@RequestBody _PatientDto patient);

    @GetMapping(value = "/patient/delete/{id}")
    public void deletePatient(@PathVariable("id") Long id);
}
