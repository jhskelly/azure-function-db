package com.developingjudoka.azurefunctiondb.handlers;

import com.developingjudoka.azurefunctiondb.service.TvShowService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;
import java.util.function.Supplier;

@Configuration
public class HelloWorld {

    private TvShowService tvShowService;

    public HelloWorld(TvShowService tvShowService) {
        this.tvShowService = tvShowService;
    }

    @Bean
    public Supplier<List<String>> getAll() {
        return () -> tvShowService.episodes();
    }

}
