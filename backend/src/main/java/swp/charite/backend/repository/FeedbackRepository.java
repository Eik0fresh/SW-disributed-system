package swp.charite.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import swp.charite.backend.model.Feedback;
import swp.charite.backend.model.Patient;

import java.util.Optional;

public interface FeedbackRepository extends JpaRepository<Feedback, Long> {

    @Query(value = "SELECT * FROM prototyp_db.feedback f WHERE f.p_id = ?1 and dia_id = ?2", nativeQuery = true)
    Optional<Feedback> getFeedbackByPatientIdAndDiagnosisId(Long patient_id, Long diagnosis_id);

}
