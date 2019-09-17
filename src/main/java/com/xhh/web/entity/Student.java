package com.xhh.web.entity;

import lombok.Data;

@Data
public class Student {
    private String name;
    private String no;
    private int age;
    public Student(){}

    public Student(String name, String no, int age) {
        this.name = name;
        this.no = no;
        this.age = age;
    }
}
