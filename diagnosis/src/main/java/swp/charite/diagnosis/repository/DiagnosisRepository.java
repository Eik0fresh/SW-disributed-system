package swp.charite.diagnosis.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import swp.charite.diagnosis.model.Diagnosis;

@Repository
public interface DiagnosisRepository extends JpaRepository<Diagnosis, Long>{
    
    public Diagnosis findByPatientId(Long p_id);

    public Boolean existsByPatientId(Long p_id);
}
