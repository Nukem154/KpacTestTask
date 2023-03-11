package dev.nukem.mapper;

import dev.nukem.model.Kpac;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

public class KpacRowMapper implements RowMapper<Kpac> {

    @Override
    public Kpac mapRow(ResultSet rs, int rowNum) throws SQLException {
        final Kpac kpac = new Kpac();
        kpac.setId(rs.getLong("id"));
        kpac.setTitle(rs.getString("title"));
        kpac.setDescription(rs.getString("description"));
        kpac.setCreationDate(LocalDate.parse(rs.getString("creation_date")));
        return kpac;
    }
}

