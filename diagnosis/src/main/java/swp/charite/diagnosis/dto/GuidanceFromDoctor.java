package swp.charite.diagnosis.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class GuidanceFromDoctor {

    private Long dia_id;
    private String guidance;
    private String priority;

}
