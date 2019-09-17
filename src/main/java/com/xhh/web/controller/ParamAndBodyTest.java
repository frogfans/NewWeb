package com.xhh.web.controller;

import com.xhh.web.entity.Student;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@RestController
public class ParamAndBodyTest {
    @RequestMapping("/aaa.do")
    public Student test1(@RequestBody Student student , HttpServletRequest request){
        student.setName(request.getParameter("name"));
        return student;
//        return new Student("zhangsan","001",12);
    }
}
