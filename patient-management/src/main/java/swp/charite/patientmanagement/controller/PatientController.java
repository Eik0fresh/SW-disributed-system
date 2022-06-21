package swp.charite.patientmanagement.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import swp.charite.patientmanagement.dto.PatientUpdateEmailDto;
import swp.charite.patientmanagement.dto.PatientDto;
import swp.charite.patientmanagement.service.PatientService;

@RestController
@RequestMapping("/patient")
public class PatientController {

    @Autowired
    private PatientService patientService;

    @PostMapping(value = "/create")
    public ResponseEntity<String> createPatient(@RequestBody PatientDto patient) {
        Boolean status = patientService.create(patient);
        if (status) {
            return new ResponseEntity<String>("Create patient successfully!", HttpStatus.OK);
        } else {
            return new ResponseEntity<String>("Patient exists!", HttpStatus.BAD_REQUEST);
        } 
    }

    @PostMapping(value = "/update")
    public ResponseEntity<String> updateEmail(@RequestBody PatientUpdateEmailDto email) {
        Boolean status = patientService.update(email);
        if (status) {
            return new ResponseEntity<String>("Update email successfully!", HttpStatus.OK);
        } else {
            return new ResponseEntity<String>("Invalid Patient ID!", HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping(value = "/query/{id}")
    public ResponseEntity<PatientDto> queryPatient(@PathVariable("id") Long p_id) {
        PatientDto patient = patientService.query(p_id);
        if (patient != null) {
            return new ResponseEntity<PatientDto>(patient, HttpStatus.OK);
        } else {
            return new ResponseEntity<PatientDto>(patient, HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping(value = "/delete/{id}")
    public ResponseEntity<String> deletePatient(@PathVariable("id") Long id) {
        Boolean status = patientService.delete(id);
        if (status == true) {
            return new ResponseEntity<String>("Delete patient successfully!", HttpStatus.OK);
        } else {
            return new ResponseEntity<String>("Invalid patient ID", HttpStatus.BAD_REQUEST);
        }
    }
    
}
