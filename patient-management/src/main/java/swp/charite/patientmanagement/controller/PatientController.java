package swp.charite.patientmanagement.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import swp.charite.patientmanagement.dto.PatientDto;
import swp.charite.patientmanagement.dto._PatientDto;
import swp.charite.patientmanagement.service.DiagnosisFeignService;
import swp.charite.patientmanagement.service.PatientService;

@RestController
@RequestMapping("/patient")
public class PatientController {

    @Autowired
    private PatientService patientService;

    @Autowired
    private DiagnosisFeignService diagnosisFeignService;

    @PostMapping(value = "/create")
    public String createPatient(@RequestBody PatientDto patient) {
        Boolean status = patientService.create(patient);
        if (status) {
            //Long p_id = patientService.query(patient);
            //_PatientDto newPatient = new _PatientDto(p_id, patient.getFirstname(), patient.getSurname());
            //diagnosisFeignService.createPatient(newPatient);
            return "Create patient successfully!";
        } else {
            return "Patient exists.";
        } 
    }

    @PostMapping(value = "/update")
    public String updateEmail(@RequestBody PatientDto patient) {
        return patientService.update(patient);
    }

    @PostMapping(value = "/query")
    public Long queryPatient(@RequestBody PatientDto patient) {
        return patientService.query(patient);
    }

    @GetMapping(value = "/delete/{id}")
    public String deletePatient(@PathVariable("id") Long id) {
        Boolean status = patientService.delete(id);
        if (status == true) {
            diagnosisFeignService.deletePatient(id);
            return "Delete patient successfully!";
        } else {
            return "Invalid patient ID";
        }
    }
    
}
