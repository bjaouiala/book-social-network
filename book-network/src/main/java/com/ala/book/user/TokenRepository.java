package com.ala.book.user;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;

public interface TokenRepository extends JpaRepository<Token,Integer> {

    Optional<Token> findByToken(String Token);

    @Query("""
SELECT token
FROM Token token
WHERE token.token = :code
AND token.validateAt IS NULL
""")
    Optional<Token> getToken(String code);

    void deleteAllByUserId(Integer user_id);
}
