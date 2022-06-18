package swp.charite.diagnosis.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import swp.charite.diagnosis.model.Doctor;

@Repository
public interface DoctorRepository extends JpaRepository<Doctor, Long>{
    
}
