package dev.nukem.dao;

import dev.nukem.model.Kpac;
import dev.nukem.model.KpacSet;

import java.util.List;

public interface KpacSetDAO extends DAO<KpacSet> {
    List<Kpac> getKpacsFromSet(Long id);

    void addKpacsToSet(Long setId, List<Kpac> kpacs);
}
