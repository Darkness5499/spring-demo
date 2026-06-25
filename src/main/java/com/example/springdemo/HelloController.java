package com.example.springdemo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author diepvu5499
 */
@RestController
public class HelloController {
    @GetMapping("hello")
    public String hello(){
        return "Hello World";
    }@GetMapping("hello1")
    public String hello1(){
        return "Chào mừng bạn đến với K8s service đầu tiên";
    }

}
