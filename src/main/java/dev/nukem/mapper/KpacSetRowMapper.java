package dev.nukem.mapper;

import dev.nukem.model.KpacSet;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class KpacSetRowMapper implements RowMapper<KpacSet> {
    @Override
    public KpacSet mapRow(ResultSet rs, int rowNum) throws SQLException {
        final KpacSet kpacSet = new KpacSet();
        kpacSet.setId(rs.getLong("id"));
        kpacSet.setTitle(rs.getString("title"));
        return kpacSet;
    }
}
