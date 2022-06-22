package order.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import member.bean.MemberDTO;
import order.bean.OrderDTO;
import order.service.OrderService;
import product.bean.ProductDTO;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@PostMapping("/addCart")
	@ResponseBody
	public void addCart(HttpSession httpSession, String product_size_id) {
		MemberDTO memberDTO = (MemberDTO) httpSession.getAttribute("memberDTO");
		System.out.println("MemberDTO : " + memberDTO);
		System.out.println("product_size_id : " + product_size_id);
		String member_id = memberDTO.getMember_id();
		
		orderService.addCart(member_id, product_size_id);
		
	}
	
	
	
	@GetMapping("/cart")
	public String cart(Model model) {
		model.addAttribute("display", "/WEB-INF/views/order/cart.jsp");
		return "index";
	} 
	
	
	@PostMapping("/getCartList")
	@ResponseBody
	//productSizeList는 해당 사이즈만 얻게끔 설정
	public List<ProductDTO> getCartList(HttpSession httpSession) {
		MemberDTO memberDTO = (MemberDTO) httpSession.getAttribute("memberDTO");
		String member_id = memberDTO.getMember_id();
		List<ProductDTO> list = orderService.getCartList(member_id);
		return list;
	}
	
	@PostMapping("/deleteDetailProductFromCart")
	@ResponseBody
	public void deleteCart(@RequestParam int detail_product_id) {
		System.out.println("detail_product_id : " + detail_product_id);
		orderService.deleteDetailProductFromCart(detail_product_id);
	}
	
	@GetMapping("/checkout")
	public String checkout(Model model) {
		model.addAttribute("display", "/WEB-INF/views/order/checkout.jsp");
		return "index";
	}
	
	@GetMapping("/orderHistory")
	public String orderHistory(Model model) {
		model.addAttribute("display", "/WEB-INF/views/order/orderHistory.jsp");
		return "index";
	}
	
	
	@PostMapping("/getOrderHistory")
	@ResponseBody
	public List<OrderDTO> getOrderHistory(HttpSession httpSession) {
		MemberDTO memberDTO = (MemberDTO) httpSession.getAttribute("memberDTO");
		System.out.println(memberDTO);
		String member_id = memberDTO.getMember_id();
		System.out.println("member_id : " + member_id);
		List<OrderDTO> orderDTOList = orderService.getOrderHistory(member_id);
		System.out.println(orderDTOList);
		return orderDTOList;
	}
	
	@PostMapping("/registerOrderDTO")
	@ResponseBody
	public void registerOrderDTO(@ModelAttribute OrderDTO orderDTO) {
		
		System.out.println("컨트롤러 registerOrderDTO");
		orderService.registerOrderDTO(orderDTO);
		System.out.println(orderDTO);
	}
	
	@GetMapping(value="/quickOrder")
	public String moveQuickOrder(Model model) {
		model.addAttribute("display", "/WEB-INF/views/order/quickorder.jsp");
		return "index";
	}
	
	@PostMapping(value = "/getQuickorder")
	@ResponseBody
	public ProductDTO addQuickOrder(@RequestParam int product_size_id, HttpSession httpSession) {
		MemberDTO memberDTO = (MemberDTO) httpSession.getAttribute("memberDTO");
		ProductDTO productDTO = orderService.getQuickorder(product_size_id);
		return productDTO;
	}
	
}
