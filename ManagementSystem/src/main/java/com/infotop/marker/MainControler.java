package com.infotop.marker;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.infotop.common.BasicController;

@Controller
@RequestMapping(value = "/marker")
public class MainControler extends BasicController {

	
	
	/**
	 * 首页系统选择页面
	 * @return
	 */
	@RequestMapping(value = "")
	public String mainframe(Model model) {
		/*List<Device> devices=deviceService.getAllDevices();
		System.out.println("Devices list are:"+devices);
		model.addAttribute("devices", devices);*/
		return "3DMarker";
	}

}
