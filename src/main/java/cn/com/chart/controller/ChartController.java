package cn.com.chart.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/chart")
public class ChartController {
	@RequestMapping(value ="",method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView addarticle(HttpServletRequest req, HttpServletResponse resp) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("chart/index");

		return mv;
	}
}
