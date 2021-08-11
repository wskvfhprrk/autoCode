package com.guardlbt;

import com.guardlbt.autoCode.AutoCode;
import com.guardlbt.autoCode.CreateCodeService;

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
		AutoCode code = new AutoCode("business_district", "商圈");
		c.start(code);
	}

}
