package com.example.demo;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;

public class SitemeshConfig extends ConfigurableSiteMeshFilter{

	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder)
	{
	 
        builder.addDecoratorPath("*", "/default.jsp");
		
	 	
        // 제외할 폴더와 문서
        builder.addExcludedPath("/main/slide");    
        builder.addExcludedPath("/admin/*");
        builder.addExcludedPath("/product/baesong*");
        builder.addExcludedPath("/member/baesongWrite");
	}
	

}