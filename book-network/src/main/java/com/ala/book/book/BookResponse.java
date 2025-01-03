package com.ala.book.book;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
public class BookResponse {
    private Integer id;

    private String title;

    private String authorName;

    private String isbn;

    private String synopsis;

    private String owner;

    private byte[] cover;

    private double rate;

    private boolean archived;

    private boolean shareable;
}
