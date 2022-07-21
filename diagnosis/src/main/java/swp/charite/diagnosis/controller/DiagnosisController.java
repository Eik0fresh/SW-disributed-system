package swp.charite.diagnosis.controller;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.parser.IParser;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import ca.uhn.fhir.util.BundleUtil;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.Bundle;
import org.hl7.fhir.r4.model.Condition;
import org.hl7.fhir.r4.model.Encounter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import swp.charite.diagnosis.model.Diagnosis;
import swp.charite.diagnosis.service.DiagnosisService;

import java.util.List;

@RestController
@RequestMapping("/diagnosis")
public class DiagnosisController {

    @Autowired 
    private DiagnosisService diagnosisService;

    @Autowired
    private FhirContext fhirContext;

    @Autowired
    private IParser parser;

    @Autowired
    private IGenericClient client;

    @PostMapping(value = "/create")
    public ResponseEntity<String> createDiagnosis(@RequestBody Diagnosis diagnosis){
        Boolean status = diagnosisService.create(diagnosis);
        if (status) {
            return new ResponseEntity<String>("Create diagnosis successfully!", HttpStatus.OK);
        } else {
            return new ResponseEntity<String>("Diagnosis exists!", HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping(value = "/get/from/kis/{patient_id}")
    public ResponseEntity<?> getDiagnosisFromKIS(@PathVariable String patient_id) {
        Bundle bundle = client
                .search()
                .forResource(Encounter.class)
                .where(Encounter.PATIENT.hasId(patient_id))
                .returnBundle(Bundle.class)
                .execute();

        List<IBaseResource> fhirEncounter = BundleUtil.toListOfResources(fhirContext, bundle);

        return new ResponseEntity<>(fhirEncounter.size(), HttpStatus.OK);
    }
}
