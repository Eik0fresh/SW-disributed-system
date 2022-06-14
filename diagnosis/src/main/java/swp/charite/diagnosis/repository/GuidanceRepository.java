package swp.charite.diagnosis.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import swp.charite.diagnosis.model.Guidance;

@Repository
public interface GuidanceRepository extends JpaRepository<Guidance, Long> {
    
    public Boolean existsByDiaId(Long dia_id);

    public Guidance findByDiaId(Long dia_id); 

    public Guidance findByGuidanceId(Long g_id);

}
