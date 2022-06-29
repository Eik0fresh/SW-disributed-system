package swp.charite.demo.controller;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.parser.IParser;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import ca.uhn.fhir.util.BundleUtil;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpHeaders;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.Bundle;
import org.hl7.fhir.r4.model.Patient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Dummy controller to test the redirect of the gateway
 * All HTTP-requests with "/demo" are redirected to this controller
 */
@RequestMapping("/demo")
@Controller
public class DemoController {

    @Autowired
    private FhirContext fhirContext;

    /**
     * Dummy method to test the redirect of the gateway.
     * @return simple response message with "Hello World"
     */
    @GetMapping("/simple")
    @ResponseStatus(HttpStatus.CREATED)
    public ResponseEntity<?> returnSimpleDemo() {
        return new ResponseEntity<>("Hello World", HttpStatus.OK);
    }

    @GetMapping("/fhir/{surname}")
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity<?> handleFHIR(@PathVariable String surname) throws IOException {
        // Create a client (only needed once)
        /*String url = "http://hapi.fhir.org/baseR4/Patient/"+id.toString()+"?_format=json&_pretty=true";
        HttpGet request = new HttpGet(url);

        String result = "";
        try (CloseableHttpResponse response = httpClient.execute(request)) {

            // Get HttpResponse Status
            System.out.println(response.getStatusLine().toString());

            HttpEntity entity = response.getEntity();
            Header headers = entity.getContentType();
            System.out.println(headers);

            if (entity != null) {
                // return it as a String
                result = EntityUtils.toString(entity);
            }
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        }

        return new ResponseEntity<>(result, HttpStatus.OK);*/

        IParser parser = fhirContext.newJsonParser();
        IGenericClient client = fhirContext.newRestfulGenericClient("http://hapi.fhir.org/baseR4/");

        // Invoke the client
        Bundle bundle = client
                .search()
                .forResource(Patient.class)
                .where(Patient.FAMILY.matches().value(surname))
                .returnBundle(Bundle.class)
                .execute();
        String serialized = parser.encodeResourceToString(bundle);
        List<IBaseResource> patients = new ArrayList<>(BundleUtil.toListOfResources(fhirContext, bundle));
        String ser = parser.encodeResourceToString(patients.get(0));
        Patient patient = parser.parseResource(Patient.class, ser);
        return new ResponseEntity<>("Patient name: " + patient.getName().get(0).getFamily(), HttpStatus.OK);
        /*Patient patient = new Patient();
        patient.setId("http://hapi.fhir.org/baseR4/Patient/"+id.toString());
        return new ResponseEntity<>(parser.encodeResourceToString(patient), HttpStatus.OK);*/
    }
}
