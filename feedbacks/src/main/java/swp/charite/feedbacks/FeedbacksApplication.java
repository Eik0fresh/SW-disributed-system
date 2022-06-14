package swp.charite.feedbacks;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;

@EnableEurekaClient
@SpringBootApplication
public class FeedbacksApplication {

    public static void main(String[] args) {
        SpringApplication.run(FeedbacksApplication.class, args);
    }

}
