package swp.charite.doctormanagement.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class WorkDto {

    private Long work_ID;
    private Long center_ID;
    private Long doctor_ID;
    
}