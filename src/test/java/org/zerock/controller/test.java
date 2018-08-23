package org.zerock.controller;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;

import org.junit.Test;


public class test {
	
	
	@Test
	public void ex() {
		String full_path = calcPath("/AA/BB/CC");
		System.out.println(full_path);
		System.out.println(filepath("/AA/BB/CC",full_path));
		
	}
	
	public String filepath(String origin_path,String... paths) {
		String mix_path = origin_path + paths[0];
		
		return mix_path.substring(origin_path.length()).replace(File.separatorChar, '/');
	}
	
	private static String calcPath(String uploadPath) {
		Calendar cal = Calendar.getInstance();
		String yearPath = File.separator+cal.get(Calendar.YEAR);
		String monthPath = yearPath+
						   File.separator+
						   new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		String datePath = monthPath +
						  File.separator+
						  new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
		
		return datePath;
	}
}
