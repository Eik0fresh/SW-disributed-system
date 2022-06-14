package swp.charite.diagnosis.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import swp.charite.diagnosis.model.Diagnosis;
import swp.charite.diagnosis.repository.DiagnosisRepository;

@Service
public class DiagnosisService {
    
    @Autowired
    private DiagnosisRepository diagnosisRepository;

    public String addDiagnosis(Diagnosis diagnosis) {
        if (!diagnosisRepository.existsById(diagnosis.getDia_id())){
            diagnosisRepository.save(diagnosis);
            return "Create diagnosis successfully!";
        } else {
            return "Diagnosis exists!";
        }
    }

    public Long findDiagnosis(Long p_id) {
        if (diagnosisRepository.existsByPatientId(p_id)) {
            Diagnosis diagnosis = diagnosisRepository.findByPatientId(p_id);
            return diagnosis.getDia_id();
        } else {
            return null;
        }
    }
}
