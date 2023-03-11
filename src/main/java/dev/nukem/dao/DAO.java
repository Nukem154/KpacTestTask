package dev.nukem.dao;

import java.util.List;

public interface DAO<T> {
    T save(T t);

    T findById(Long id);

    List<T> findAll();

    void delete(Long id);
}
