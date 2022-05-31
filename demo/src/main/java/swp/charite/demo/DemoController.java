package swp.charite.demo;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;

/**
 * Dummy controller to test the redirect of the gateway
 * All HTTP-requests with "/demo" are redirected to this controller
 */
@RequestMapping("/demo")
@Controller
public class DemoController {

    /**
     * Dummy method to test the redirect of the gateway.
     * @return simple response message with "Hello World"
     */
    @GetMapping("/simple")
    @ResponseStatus(HttpStatus.CREATED)
    public ResponseEntity<?> returnSimpleDemo() {
        return new ResponseEntity<>("Hello World", HttpStatus.OK);
    }
}
