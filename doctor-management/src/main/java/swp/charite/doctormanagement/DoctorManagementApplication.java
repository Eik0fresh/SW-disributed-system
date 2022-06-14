package swp.charite.doctormanagement;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@EnableEurekaClient
@SpringBootApplication
public class DoctorManagementApplication {

    public static void main(String[] args) {
        SpringApplication.run(DoctorManagementApplication.class, args);
    }

}
