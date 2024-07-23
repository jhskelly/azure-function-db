package com.developingjudoka.azurefunctiondb.service;

import org.springframework.stereotype.Component;

import java.util.List;


@Component
public class TvShowService {

    public List<String> episodes(){
        return List.of("Star Wars");
    }
}
