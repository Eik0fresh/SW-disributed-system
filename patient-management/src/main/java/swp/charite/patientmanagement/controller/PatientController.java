package swp.charite.patientmanagement.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import swp.charite.patientmanagement.dto.PatientDto;
import swp.charite.patientmanagement.service.PatientService;

@RestController
@RequestMapping("/patient")
public class PatientController {

    @Autowired
    private PatientService patientService;

    @PostMapping(value = "/create")
    public String create(@RequestBody PatientDto patient) {
        return patientService.addPatient(patient);
    }

    @PostMapping(value = "/update")
    public String update(@RequestBody PatientDto patient) {
        return patientService.updateEmail(patient);
    }

    @PostMapping(value = "/query")
    public Long query(@RequestBody PatientDto patient) {
        return patientService.queryPatient(patient);
    }

    @GetMapping(value = "/delete/{id}")
    public String delete(@PathVariable("id") Long id) {
        return patientService.deletePatient(id);
    }
    
}
