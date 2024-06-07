package com.nexfit.util;

public class NumberToWords {
	 private static final String[] units = { "Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine" };
	    
	    public static String convert(int number) {
	        if (number >= 0 && number < units.length) {
	            return units[number];
	        }
	        return String.valueOf(number); // 기본적으로 숫자를 문자열로 반환
	    }
}
