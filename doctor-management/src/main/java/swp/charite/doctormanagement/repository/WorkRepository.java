package swp.charite.doctormanagement.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import swp.charite.doctormanagement.model.Work;

@Repository
public interface WorkRepository extends JpaRepository<Work, Long>{
    public boolean existsByD_idAndC_id(Long d_id, Long c_id);
    public Work findByD_idAndC_id(Long d_id, Long c_id);
}
