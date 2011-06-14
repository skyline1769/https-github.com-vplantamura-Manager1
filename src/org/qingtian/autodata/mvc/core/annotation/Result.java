package org.qingtian.autodata.mvc.core.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Action处理后视图定义注解
 * 
 * @author qingtian
 *
 * 2011-4-25 下午03:07:36
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@Documented
public @interface Result {
	String success() default "";
	String fail() default "";
}
