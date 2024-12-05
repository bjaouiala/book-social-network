package com.ala.book.auth;

import com.ala.book.user.Token;
import com.ala.book.user.TokenResponse;
import com.ala.book.user.User;
import com.ala.book.user.UserRepository;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.mail.MessagingException;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.Value;
import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("auth")
@RequiredArgsConstructor
@Tag(name = "Authentication")
@Slf4j
public class AuthenticationController {
    private final AuthenticationService authenticationService;
    private final UserRepository userRepository;
    @PostMapping("/register")
    @ResponseStatus(HttpStatus.ACCEPTED)
    public ResponseEntity<?> register(
            @Valid @RequestBody RegistrationRequest request
    ) throws MessagingException {
        authenticationService.register(request);
        return ResponseEntity.ok().build();

    }
    @PostMapping("/authenticate")
    public ResponseEntity<AuthenticationResponse> authenticate(
            @RequestBody AuthenticationRequest request) throws MessagingException {
        log.info("request from controller ::"+request);
        return ResponseEntity.ok(authenticationService.authenticate(request));
    }
    @GetMapping("/activate-account")
    public void confirm(
            @RequestParam String token
    ) throws MessagingException {
        authenticationService.activateAccount(token);
    }

    @GetMapping("/activation_account-code")
    public ResponseEntity<TokenResponse> getToken(@RequestParam String code){
        System.out.println(code);
        return ResponseEntity.ok(authenticationService.getToken(code));
    }

    @PostMapping("/resent-CodeConfirmation")
    public ResponseEntity<?> resentConfirmationToken(@RequestBody String email) throws MessagingException {
        authenticationService.resentConfirmationToken(email);
        return ResponseEntity.accepted().build();
    }
}
