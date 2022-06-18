package swp.charite.diagnosis.model;

import javax.persistence.*;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "guidance", schema = "diagnosis_db")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Guidance {
    @Id
    @Column(name = "g_id", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long guidanceId;

    @Column(name = "dia_id", nullable = false)
    private Long diaId;

    @Column(name = "guidance", nullable = false)
    private String guidance;

    @Column(name = "priority", nullable = false)
    @Enumerated(EnumType.STRING)
    private Priority priority;

    @Column(name = "date", nullable = false)
    private String date;

    @Column(name = "done", nullable = false)
    private Boolean done;

}
