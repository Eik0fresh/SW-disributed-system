package swp.charite.diagnosis.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import swp.charite.diagnosis.dto.GuidanceDto;
import swp.charite.diagnosis.dto.PatientDto;
import swp.charite.diagnosis.model.Diagnosis;
import swp.charite.diagnosis.model.Guidance;
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
        return guidanceService.addGuidance(guidance);
    }

    @PostMapping(value = "/guidance/query")
    public Guidance query(@RequestBody PatientDto patient) {
        Long p_id = patientService.query(patient);
        Long dia_id = diagnosisService.findDiagnosis(p_id);
        return guidanceService.queryGuidance(dia_id);
    }

    @PostMapping(value = "/diagnosis/create")
    public String createDiagnosis (@RequestBody Diagnosis diagnosis){
        return diagnosisService.addDiagnosis(diagnosis);
    }
}
