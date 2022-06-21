package swp.charite.diagnosis.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import swp.charite.diagnosis.dto.GuidanceFromDoctor;
import swp.charite.diagnosis.dto.GuidanceToPatient;
import swp.charite.diagnosis.model.Diagnosis;
import swp.charite.diagnosis.model.Doctor;
import swp.charite.diagnosis.model.Patient;
import swp.charite.diagnosis.service.DiagnosisService;
import swp.charite.diagnosis.service.DoctorService;
import swp.charite.diagnosis.service.GuidanceService;
import swp.charite.diagnosis.service.PatientService;

@RestController
@RequestMapping("/diagnosis")
public class DiagnosisController {

    @Autowired 
    private DiagnosisService diagnosisService;

    @Autowired
    private PatientService patientService;

    @Autowired
    private DoctorService doctorService;

    @PostMapping(value = "/diagnosis/create")
    public ResponseEntity<String> createDiagnosis (@RequestBody Diagnosis diagnosis){
        Boolean status = diagnosisService.create(diagnosis);
        if (status) {
            return new ResponseEntity<String>("Create diagnosis successfully!", HttpStatus.OK);
        } else {
            return new ResponseEntity<String>("Diagnosis exists!", HttpStatus.BAD_REQUEST);
        }
    }

    // sync patient and doctor data

    @PostMapping(value = "/patient/create")
    public void createPatient(@RequestBody Patient patient) {
        patientService.create(patient);
    }

    @GetMapping(value = "/patient/delete/{id}")
    public void deletePatient(@PathVariable("id") Long id) {
        patientService.delete(id);
    }

    @PostMapping(value = "/doctor/create")
    public void createDoctor(@RequestBody Doctor doctor) {
        doctorService.create(doctor);
    }

    @GetMapping(value = "/doctor/delete/{id}")
    public void deleteDoctor(@PathVariable("id") Long id) {
        doctorService.delete(id);
    }
}
