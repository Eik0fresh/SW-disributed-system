package swp.charite.doctormanagement.service;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.parser.IParser;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import ca.uhn.fhir.util.BundleUtil;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.Bundle;
import org.hl7.fhir.r4.model.Practitioner;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DoctorQueryService {

    @Autowired
    private FhirContext fhirContext;

    @Autowired
    IParser parser;

    @Autowired
    private IGenericClient client;

    public int queryAllDoctor() {
        Bundle bundle = client
                .search()
                .forResource(Practitioner.class)
                .where(Practitioner.ACTIVE.exactly().code("active"))
                .returnBundle(Bundle.class)
                .execute();
        List<IBaseResource> iBr = BundleUtil.toListOfResources(fhirContext, bundle);
        return iBr.size();
    }

}
