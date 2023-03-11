package dev.nukem.model;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import dev.nukem.model.serializer.LocalDateSerializer;

import java.time.LocalDate;

public class Kpac {

    private Long id;
    private String title;
    private String description;
    @JsonSerialize(using = LocalDateSerializer.class)
    private LocalDate creationDate;

    public Kpac() {
    }

    public Kpac(Long id, String title, String description, LocalDate creationDate) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.creationDate = creationDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDate getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(LocalDate creationDate) {
        this.creationDate = creationDate;
    }

}
