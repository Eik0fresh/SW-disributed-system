package swp.charite.backend.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

/**
 * REST-Controller for the doctor client
 */
@Controller
@RequestMapping("doctor")
public class DoctorController {

    @GetMapping(value = "getSimpleString")
    @ResponseBody
    private ResponseEntity<String> getSimpleString() {
        return new ResponseEntity<String>("This is the API of the doctor client", HttpStatus.OK);
    }
}
