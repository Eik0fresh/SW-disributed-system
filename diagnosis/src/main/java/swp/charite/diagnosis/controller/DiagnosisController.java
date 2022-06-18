package swp.charite.diagnosis.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import swp.charite.diagnosis.dto.GuidanceDto;
import swp.charite.diagnosis.dto.PatientDto;
import swp.charite.diagnosis.model.Diagnosis;
import swp.charite.diagnosis.model.Guidance;
import swp.charite.diagnosis.model.Patient;
import swp.charite.diagnosis.service.DiagnosisService;
import swp.charite.diagnosis.service.GuidanceService;
import swp.charite.diagnosis.service.PatientService;

@RestController
public class DiagnosisController {

    @Autowired
    private GuidanceService guidanceService;

    @Autowired 
    private DiagnosisService diagnosisService;

    @Autowired
    private PatientService patientService;

    @PostMapping(value = "/guidance/create")
    public String createGuidance(@RequestBody GuidanceDto guidance) {
        return guidanceService.create(guidance);
    }

    @PostMapping(value = "/guidance/query")
    public Guidance queryGuidance(@RequestBody PatientDto patient) {
        Long p_id = patientService.query(patient);
        Long dia_id = diagnosisService.findDiagnosis(p_id);
        return guidanceService.query(dia_id);
    }

    @GetMapping(value = "guidance/update/{g_id}")
    public String doneGuidance(@PathVariable("g_id") Long g_id) {
        guidanceService.update(g_id);
        return "Guidance done!";
    }

    @PostMapping(value = "/diagnosis/create")
    public String createDiagnosis (@RequestBody Diagnosis diagnosis){
        return diagnosisService.addDiagnosis(diagnosis);
    }

    @PostMapping(value = "/patient/create")
    public void createPatient(@RequestBody Patient patient) {
        patientService.create(patient);
    }

    @GetMapping(value = "/patient/delete/{id}")
    public void deletePatient(@PathVariable("id") Long id) {
        patientService.delete(id);
    }
}
