package dev.nukem.dao.impl;

import dev.nukem.dao.KpacDAO;
import dev.nukem.mapper.KpacRowMapper;
import dev.nukem.model.Kpac;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.List;

@Repository
public class KpacDAOImpl implements KpacDAO {

    private final JdbcTemplate jdbcTemplate;

    public KpacDAOImpl(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Override
    public Kpac save(Kpac kpac) {
        final String sql = "INSERT INTO kpac (title, description, creation_date) VALUES (?, ?, ?)";
        final KeyHolder keyHolder = new GeneratedKeyHolder();

        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection
                    .prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, kpac.getTitle());
            ps.setString(2, kpac.getDescription());
            ps.setDate(3, Date.valueOf(LocalDate.now()));
            return ps;
        }, keyHolder);

        return findById(keyHolder.getKey().longValue());
    }

    @Override
    public Kpac findById(Long id) {
        final String sql = "SELECT * FROM kpac WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, new KpacRowMapper(), id);
    }

    @Override
    public List<Kpac> findAll() {
        String sql = "SELECT * FROM kpac";
        return jdbcTemplate.query(sql, new KpacRowMapper());
    }

    @Override
    public void delete(Long id) {
        String sql = "DELETE FROM kpac WHERE id = ?";
        jdbcTemplate.update(sql, id);
    }
}
