package swp.charite.backend.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import swp.charite.backend.dto.PatientDto;

/**
 * REST-Controller for the patient client
 */
@Controller
@RequestMapping("patient")
public class PatientController {

    @GetMapping(value = "getSimpleString")
    @ResponseBody
    private ResponseEntity<String> getSimpleString() {
        return new ResponseEntity<>("This is the API of the patient client", HttpStatus.OK);
    }

    @PostMapping(value = "createPatient")
    @ResponseBody
    private ResponseEntity<Long> createPerson(@RequestBody PatientDto patientDto) {
        return new ResponseEntity<>(HttpStatus.CREATED);
    }
}
