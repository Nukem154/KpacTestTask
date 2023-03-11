package dev.nukem.dao.impl;

import dev.nukem.dao.KpacSetDAO;
import dev.nukem.mapper.KpacRowMapper;
import dev.nukem.mapper.KpacSetRowMapper;
import dev.nukem.model.Kpac;
import dev.nukem.model.KpacSet;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.util.List;

@Repository
public class KpacSetDAOImpl implements KpacSetDAO {

    private final JdbcTemplate jdbcTemplate;

    public KpacSetDAOImpl(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Override
    public KpacSet save(KpacSet kpacSet) {
        final String sql = "INSERT INTO kpac_set (title) VALUES (?)";
        final KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection
                    .prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, kpacSet.getTitle());
            return ps;
        }, keyHolder);

        return findById(keyHolder.getKey().longValue());
    }

    @Override
    public KpacSet findById(Long id) {
        return jdbcTemplate.queryForObject("SELECT * FROM kpac_set WHERE id = ?", new KpacSetRowMapper(), id);
    }

    @Override
    public List<KpacSet> findAll() {
        return jdbcTemplate.query("SELECT * FROM kpac_set", new KpacSetRowMapper());
    }

    @Override
    public void delete(Long id) {
        jdbcTemplate.update("DELETE FROM kpac_set WHERE id = ?", id);
    }

    @Override
    public List<Kpac> getKpacsFromSet(Long id) {
        final String sql = "SELECT k.* FROM kpac k INNER JOIN kpac_kpac_set ks ON k.id = ks.kpac_id WHERE ks.kpac_set_id = ?";
        return jdbcTemplate.query(sql, new KpacRowMapper(), id);
    }

    @Override
    public void addKpacsToSet(Long setId, List<Kpac> kpacs) {
        for (Kpac kpac : kpacs) {
            jdbcTemplate.update("INSERT INTO Kpac_KpacSet (kpac_id, kpacset_id) VALUES (?, ?)",
                    kpac.getId(), setId);
        }
    }
}
