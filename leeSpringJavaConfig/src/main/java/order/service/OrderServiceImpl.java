package order.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import file.bean.FileDTO;
import file.mapper.FileMapper;
import member.bean.MemberDTO;
import member.mapper.MemberMapper;
import order.bean.CartDTO;
import order.bean.DetailOrderDTO;
import order.bean.OrderDTO;
import order.mapper.OrderMapper;
import product.bean.DetailProductDTO;
import product.bean.ProductDTO;
import product.bean.ProductSizeDTO;
import product.mapper.ProductMapper;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private ProductMapper productMapper;
	
	@Autowired
	private FileMapper fileMapper;
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public List<ProductDTO> getCartList(String member_id) {
		//해당 아이디로 추가한 장바구니항목을 가져온다. Cart테이블. DETAIL_PRODUCT와 1:1관계이고, DETAIL_PRODUCT_ID를 외래키로 가짐
		List<CartDTO> cartDTOList = orderMapper.getCartList(member_id);
		List<ProductDTO> productDTOList = new ArrayList<>();
		for (CartDTO cartDTO : cartDTOList) {
			DetailProductDTO detailProductDTO = productMapper.getDetailProductByDetailProductId(cartDTO.getDetail_product_id()); 
			ProductSizeDTO productSizeDTO = productMapper.getProductSizeByProductSizeId(detailProductDTO.getProduct_size_id());
			productSizeDTO.setDetailProductDTO(detailProductDTO);
			ProductDTO productDTO = productMapper.getProductByProductNum(productSizeDTO.getProduct_num() + "");
			List<FileDTO> fileDTOList = fileMapper.findByProductNum(productDTO.getProduct_num());
			
			productDTO.setFileList(fileDTOList);
			productDTO.setProductSizeDTO(productSizeDTO);
			productDTOList.add(productDTO);
		}
		
		
		return productDTOList;
	}
	
	
	@Override
	public void addCart(String member_id, String product_size_idd) {
		
		//사이즈id로 해당되는 모든 DetailProductDTO 가져옴
		int product_size_id = Integer.parseInt(product_size_idd);
		List<DetailProductDTO> detailProductDTOs = productMapper.getDetailProductListByProductSizeId(product_size_id);
		
		//for문 통해서 DetailProductDTO의 detail_product_id로 계속 조회...없으면 등록하자
		for (int i = 0; i < detailProductDTOs.size(); i++) {
			DetailProductDTO detailProductDTO = detailProductDTOs.get(i);
			CartDTO cartDTO = orderMapper.getCartDtoByDetailProductId(detailProductDTO.getDetail_product_id());
			
			if (cartDTO == null) {
				CartDTO cartDTO2 = new CartDTO();
				cartDTO2.setDetail_product_id(detailProductDTO.getDetail_product_id());
				cartDTO2.setMember_id(member_id);
				orderMapper.addCart(cartDTO2);
				break;
			}
		}
		
	}	
	
	@Override
	public void deleteDetailProductFromCart(int detail_product_id) {
		orderMapper.deleteDetailProductFromCart(detail_product_id);
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public void registerOrderDTO(OrderDTO orderDTO) {
		//먼저 orderDTO등록. selectKey
		//이후 orderDTO.getDetailOrderDTOList()로 리스트 받아와서 DetailOrderDTO 등록 반복문 필요
		System.out.println("서비스 계층");
		
		System.out.println(orderDTO);
		
		orderMapper.registerOrderDTO(orderDTO);

		for (DetailOrderDTO detailOrderDTO : orderDTO.getDetailOrderDTOList()) {
			detailOrderDTO.setOrder_id(orderDTO.getOrder_id());
			System.out.println(detailOrderDTO);
			orderMapper.registerDetailOrderDTO(detailOrderDTO);
		}
		
		//장바구니에서 목록 삭제
		orderMapper.deleteCart(orderDTO.getMember_id());
	}
	
	@Override
	public List<OrderDTO> getOrderHistory(String member_id) {
		List<OrderDTO> orderDTOList = orderMapper.getOrderHistory(member_id);
		for (OrderDTO orderDTO : orderDTOList) {
			List<DetailOrderDTO> detailOrderDTOList = orderMapper.getDetailOrderDtoByOrderId(orderDTO.getOrder_id()); 
			orderDTO.setDetailOrderDTOList(detailOrderDTOList);
			
			MemberDTO memberDTO = memberMapper.getMemberDtoByMemberId(member_id);
			orderDTO.setMemberDTO(memberDTO);
			
			System.out.println(orderDTO);
		}
		return orderDTOList;
	}
	
	@Override
	public ProductDTO getQuickorder(int product_size_id) {
		
		ProductSizeDTO productSizeDTO = productMapper.getProductSizeByProductSizeId(product_size_id);
		List<DetailProductDTO> detailProductDTOList = productMapper.getDetailProductListByProductSizeId(product_size_id);
		productSizeDTO.setDetailProductDTOList(detailProductDTOList);
		
		
		ProductDTO productDTO = productMapper.getProductDTO(productSizeDTO.getProduct_num());
		productDTO.setProductSizeDTO(productSizeDTO);
		
		List<FileDTO> fileDTOList = fileMapper.findByProductNum(productDTO.getProduct_num());
		productDTO.setFileList(fileDTOList);
		
		System.out.println(productDTO);
		
		return productDTO;
	}
		
}
