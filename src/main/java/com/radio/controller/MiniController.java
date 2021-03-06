package com.radio.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.radio.domain.Criteria;
import com.radio.domain.MiniVO;
import com.radio.domain.PageDTO;
import com.radio.service.MiniService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/mini/*")
@AllArgsConstructor
public class MiniController {
	
	private MiniService service;
	
	@GetMapping("/list")
	public void list (@ModelAttribute("cri") Criteria cri, Model model) {
		int total = service.getTotal(cri);
		PageDTO dto = new PageDTO(cri, total);
		
		model.addAttribute("list", service.getListWithPaging(cri));
		model.addAttribute("pageMaker", dto);
		log.info("list");
	}
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(MiniVO mini, RedirectAttributes rttr) {
		log.info(mini);
		if (mini.getContent() == null || mini.getContent()=="") {
			mini.setContent("안녕하세요!");
		}
		service.register(mini);
		log.info(mini);
		rttr.addFlashAttribute("result", mini.getWriter() + "님의 사연전송 완료!");
		return "redirect:/mini/list";
	}
	
	@PostMapping("/remove/{num}")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String remove(@PathVariable("num") Long num, RedirectAttributes rttr) {
		if (service.delete(num) == 1) {
			rttr.addFlashAttribute("delMsg", num+"번 메시지 삭제완료");
		}
		return "redirect:/mini/list";
	}
		
}
