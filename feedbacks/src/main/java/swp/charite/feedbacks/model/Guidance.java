package swp.charite.feedbacks.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "guidance", schema = "feedback_db")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Guidance {
    @Id
    @Column(name = "g_id", nullable = false)
    private Long g_id;

    @Column(name = "guidance", nullable = false)
    private String guidance;

}
