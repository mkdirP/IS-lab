package com.example.web;

import java.time.LocalDateTime;

public class PendingAdminRequest {
    private Long id;
    private String username;
    private String password;
    private String email;
    private String phonenumber;
    private Integer roletype;
    private LocalDateTime createdat;

    public Integer getRoletype() {
        return roletype;
    }

    public LocalDateTime getCreated_at() {
        return createdat;
    }

    public Long getId() {
        return id;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getPhonenumber() {
        return phonenumber;
    }

    public String getUsername() {
        return username;
    }

    public void setCreatedat(LocalDateTime createdat) {
        this.createdat = createdat;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    public void setRoletype(Integer roletype) {
        this.roletype = roletype;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public String toString() {
        return "PendingAdminRequest{id=" + id + ", username='" + username + "', email='" + email;}
    }

