package com.hejz;

import com.hejz.autoCode.AutoCode;
import com.hejz.autoCode.CreateCodeService;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * Created by Administrator on 2017/7/7 0007.
 */
@RunWith(SpringRunner.class)
@SpringBootTest
public class StartFreemarker {

	@Autowired
	private CreateCodeService c;

	@Test
	public void createCode() {
		AutoCode code = new AutoCode("person", "人员");
		c.start(code);
	}

}
