package io.codesquad.group3.signupserver;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends CrudRepository<User, Long> {
    @Query("SELECT COUNT(1) FROM USER WHERE user_id = :userId")
    boolean existsByUserId(@Param("userId") String userId);

    @Query("SELECT COUNT(1) FROM USER WHERE email = :email")
    boolean existsByEmail(@Param("email") String email);

    @Query("SELECT COUNT(1) FROM USER WHERE phone = :phone")
    boolean existsByPhone(@Param("phone") String phone);
}
