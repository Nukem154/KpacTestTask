package dev.nukem.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import dev.nukem.dao.KpacDAO;
import dev.nukem.dao.KpacSetDAO;
import dev.nukem.model.Kpac;
import dev.nukem.model.KpacSet;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class MainController {

    private final KpacDAO kpacDAO;
    private final KpacSetDAO kpacSetDAO;

    public MainController(KpacDAO kpacDAO, KpacSetDAO kpacSetDAO) {
        this.kpacDAO = kpacDAO;
        this.kpacSetDAO = kpacSetDAO;
    }

    @GetMapping("/kpac")
    public String getKpacs(Model model) throws JsonProcessingException {
        model.addAttribute("kpacs", new ObjectMapper().writeValueAsString(kpacDAO.findAll()));
        return "kpac";
    }

    @PostMapping(value = "/kpac", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<Kpac> saveKpac(@RequestBody Kpac kpac) {
        return ResponseEntity.status(200).body(kpacDAO.save(kpac));
    }

    @DeleteMapping("/kpac/{id}")
    public ResponseEntity<HttpStatus> deleteKpac(@PathVariable Long id) {
        kpacDAO.delete(id);
        return ResponseEntity.status(200).build();
    }

    @GetMapping("/sets")
    public String getSets(Model model) throws JsonProcessingException {
        model.addAttribute("sets", new ObjectMapper().writeValueAsString(kpacSetDAO.findAll()));
        return "sets";
    }

    @PostMapping(value = "/sets", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<KpacSet> saveKpac(@RequestBody KpacSet set) {
        return ResponseEntity.status(200).body(kpacSetDAO.save(set));
    }

    @DeleteMapping("/sets/{id}")
    public ResponseEntity<HttpStatus> deleteSet(@PathVariable Long id) {
        kpacSetDAO.delete(id);
        return ResponseEntity.status(200).build();
    }

    @GetMapping("/set/{id}")
    public String getSetKpacs(@PathVariable Long id, Model model) throws JsonProcessingException {
        model.addAttribute("kpacs", new ObjectMapper().writeValueAsString(kpacSetDAO.getKpacsFromSet(id)));
        return "kpacSet";
    }
}
