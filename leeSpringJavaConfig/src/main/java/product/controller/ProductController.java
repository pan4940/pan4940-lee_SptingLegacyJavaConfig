package product.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import board.bean.BoardCriteria;
import board.bean.BoardPageDTO;
import file.bean.FileDTO;
import lombok.extern.log4j.Log4j2;
import product.bean.DetailProductDTO;
import product.bean.ProductCategoryDTO;
import product.bean.ProductDTO;
import product.bean.ProductSizeDTO;
import product.service.ProductService;

@Controller
@RequestMapping(value = "/product", method = {RequestMethod.GET, RequestMethod.POST})
@Log4j2
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	/* 상품의 카테고리 */
	//카테고리 관리 페이지 이동
	@GetMapping("/categoryForm")
	public String productCategory() {
		return "/product/category";
	}
	
	//카테고리 목록 반환
	@PostMapping("/getProductCategoryList")
	@ResponseBody
	public List<ProductCategoryDTO> getProductCategoryList() {
		List<ProductCategoryDTO> list = productService.getProductCategoryList();
		return list;
	}
	
	
	//하나의 ProductCategoryDTO 반환
	@PostMapping("/getProductCategoryDTO")
	@ResponseBody
	public ProductCategoryDTO  getProductCategoryDTO(@RequestParam int product_category_num) {
		ProductCategoryDTO productCategoryDTO = productService.getProductCategoryDTO(product_category_num);
		return productCategoryDTO;
	}
	
	//카테고리 목록 반환
	@PostMapping("/getBrandsCategoryList")
	@ResponseBody
	public List<ProductCategoryDTO> getBrandsCategoryList() {
		List<ProductCategoryDTO> list = productService.getBrandsCategoryList();
		return list;
	}
	
	//브랜드 카테고리 생성
	@PostMapping("/createBrandCategory")
	public String createbrandCategory(@ModelAttribute ProductCategoryDTO productCategoryDTO) {
		productCategoryDTO.setProduct_category_num_ref(10000);
		
		productService.createBrandCategorySelectKey(productCategoryDTO);
		return "/product/category";
	}
	
	
	//브랜드 카테고리 제거
	@PostMapping("/deleteBrandCategory")
	public String deleteBrandCategory(@ModelAttribute ProductCategoryDTO productCategoryDTO) {
		productCategoryDTO.setProduct_category_num_ref(10000);
		System.out.println(productCategoryDTO);
		productService.deleteBrandCategory(productCategoryDTO.getProduct_category_num());
		return "/product/category";
	}
	
	
	//브랜드 카테고리 수정
	@PostMapping("/modifyBrandCategory")
	public String modifyBrandCategory(@ModelAttribute ProductCategoryDTO productCategoryDTO) {
		productCategoryDTO.setProduct_category_num_ref(10000);
		
		productService.modifyBrandCategory(productCategoryDTO);
		return "/product/category";
	}
	
	
	
	
	
	/* 상품관련항목 */
	// 상품 등록 페이지 이동
	@GetMapping("/registerForm")
	public String productRegisterForm() {
		return "/product/register";
	}
	
	
	// 상품 등록
	//상품 관련 테이블 및 구조가 있어야 할 것
	@PostMapping("/register")
	public String productRegister(@ModelAttribute ProductDTO productDTO) {
		
		String brandname = productService.getBrandnameByBrandcategory(productDTO.getBrandCategory());
		productDTO.setBrand_name(brandname);
		productService.productRegister(productDTO);
		
		return "/product/register";
	}
	
	// 브랜드명으로 상품목록 페이지 이동
	@GetMapping("/list-brand")
	public String moveListBrand(@RequestParam Map<String, String> map, Model model) {
		
		System.out.println("/list-brand : " + map);
		
		
		String pageNum = map.get("pageNum");
		String amount = map.get("amount");
		BoardCriteria criteria;
		if (pageNum == null && amount == null) {
			criteria = new BoardCriteria(1, 24);
		} else {
			criteria = new BoardCriteria(Integer.parseInt(pageNum), Integer.parseInt(amount));
		}
		
				
		model.addAttribute("display", "/WEB-INF/views/product/list-brand.jsp");
		int product_category_num = Integer.parseInt(map.get("product_category_num")); 
		model.addAttribute("product_category_num", product_category_num);
		
		int total = productService.getTotalCount(product_category_num);
		model.addAttribute("pageDTO", new BoardPageDTO(criteria, total));
		return "index";
		
		//return "/product/list-brand";
	}
	
	// 상품 분류로 상품목록 페이지 이동
	@GetMapping("/list")
	//public String moveList(@RequestParam int product_category_num, Model model) {
	public String moveList(@RequestParam Map<String, String> map, Model model) {	
		System.out.println("/list : " + map);
		
		
		String pageNum = map.get("pageNum");
		String amount = map.get("amount");
		BoardCriteria criteria;
		if (pageNum == null && amount == null) {
			criteria = new BoardCriteria(1, 24);
		} else {
			criteria = new BoardCriteria(Integer.parseInt(pageNum), Integer.parseInt(amount));
		}
		
				
		model.addAttribute("display", "/WEB-INF/views/product/list.jsp");
		int product_category_num = Integer.parseInt(map.get("product_category_num")); 
		model.addAttribute("product_category_num", product_category_num);
		
		int total = productService.getTotalCount(product_category_num);
		model.addAttribute("pageDTO", new BoardPageDTO(criteria, total));
		return "index";
		
		//return "/product/list-brand";
	}
	
	
	@PostMapping("/getProductsByBrandCategory")
	@ResponseBody
	public List<ProductDTO> getProductsByBrandCategory(@RequestParam int product_category_num, Model model) {
		return productService.getProductsByBrandCategory(product_category_num);
	}
	
	
	// 상품 수정 페이지 이동
	@PostMapping("/modifyForm")
	public String modifyForm() {
		return "/product/modify";
	}
	
	//상품명으로 상품 검색
	@PostMapping("/search")
	@ResponseBody
	public ProductDTO searchProductName(String product_name) {
		return productService.searchProductName(product_name);
	}
	
	
	//카테고리 코드로 상품검색
	@PostMapping("/getProductByCategory")
	@ResponseBody
	public List<ProductDTO> getProductByCategory(@RequestParam Map<String, String> map) {
		
		if (map.get("cateCode1").equals(map.get("cateCode2"))) {
			map.replace("cateCode2", map.get("cateCode2"), "");
		} else if (map.get("cateCode2").equals(map.get("cateCode3"))) {
			map.replace("cateCode3", map.get("cateCode3"), "");
		}
		List<ProductDTO> list;
		
		list = productService.getProductByCategory(map);
		for (ProductDTO productDTO : list) {
			List<FileDTO> productFileList = productService.getProductFileList(productDTO.getProduct_num());
			productDTO.setFileList(productFileList);
		}
		
		return list;
	}
	
	
	@PostMapping("/getProductByProductNum")
	@ResponseBody
	public ProductDTO getProductByProductNum(String product_num) {
		ProductDTO productDTO = productService.getProductByProductNum(product_num);
		List<FileDTO> list = productService.getProductFileList(productDTO.getProduct_num());
		productDTO.setFileList(list);
		List<ProductSizeDTO> productSizeDTOList = productService.getProductByProductSize(productDTO.getProduct_num());
		for (ProductSizeDTO productSizeDTO : productSizeDTOList) {
			productSizeDTO.setDetailProductDTOList(
					productService.getDetailProductListByProductSizeId(productSizeDTO.getProduct_size_id()));
		}
		
		productDTO.setProductSizeList(productSizeDTOList);
		return productDTO;
	}
	
	//개별 상품 패이지 조회
	//category_num, product_num, pageNum, amount넘겨받음. 
	@GetMapping("/detail")
	public String get(@RequestParam Map<String, String> map, Model model) {
		
		System.out.println(map);
		int product_num = Integer.parseInt(map.get("product_num")) ;
		
		model.addAttribute("map", map);
		model.addAttribute("display", "/WEB-INF/views/product/detail.jsp");
		return "index";
	}
	
	@PostMapping("/getProductDTO")
	@ResponseBody
	public ProductDTO getProductDTO(@RequestParam int product_num) {
		ProductDTO productDTO = productService.getProductDTO(product_num);
		productDTO.setProductSizeList(productService.getProductByProductSize(product_num));
		return productDTO;
	}
	
	//상품의 첨부파일 불러옴
	@PostMapping("/getFileList")
	@ResponseBody
	public List<FileDTO> getFileList(int product_num) {
		return productService.getProductFileList(product_num);
	}
	
	
	
	@PostMapping("/modify")
	public void modify(@ModelAttribute ProductDTO productDTO) {
		productService.modify(productDTO);
	}
	
	
	@Transactional(rollbackFor = Exception.class)
	@PostMapping("/delete")
	@ResponseBody
	public void delete(@RequestParam String[] checkProduct_num) {
		for (int i = 0; i < checkProduct_num.length; i++) {
			productService.delete(Integer.parseInt(checkProduct_num[i]));
		}
	}
	
	
	@GetMapping("/brands")
	public String brands(Model model) {
		model.addAttribute("display", "/WEB-INF/views/product/brands.jsp");
		return "index";
	}
	
	@GetMapping("/productSizeForm")
	public String productSizeForm() {
		return "/product/productSize";
	}
	
	@PostMapping("/registerProductSize")
	@ResponseBody
	public void registerProductSize(@ModelAttribute ProductSizeDTO productSizeDTO) {
		System.out.println(productSizeDTO);
		productService.registerProductSize(productSizeDTO);
	}
	
	@PostMapping("/getProductSizeByProductSizeId")
	@ResponseBody
	public ProductSizeDTO getProductSizeByProductSizeId(@RequestParam int product_size_id) {
		return productService.getProductSizeByProductSizeId(product_size_id);
	}
	
	@PostMapping("/modifyProductSize")
	@ResponseBody
	public void modifyProductSize(@ModelAttribute ProductSizeDTO productSizeDTO) {
		productService.modifyProductSize(productSizeDTO);
	}
	
	@PostMapping("/deleteProductSize")
	@ResponseBody
	public void deleteProductSize(@RequestParam int product_size_id) {
		productService.deleteProductSize(product_size_id);
	}
	
	
	
	//수량 관련
	//수량 관리 페이지 이동
	@GetMapping("/amountForm")
	public String amountForm() {
		return "/product/amount";
	}
	
	
	//productSizeID로 DetailProductList 가져옴
	
	@PostMapping("/getDetailProductListByProductSizeId")
	@ResponseBody
	public List<DetailProductDTO> getDetailProductListByProductSizeId(@RequestParam int product_size_id) {
		return productService.getDetailProductListByProductSizeId(product_size_id);
	}
	
	@PostMapping("/addDetailProduct")
	@ResponseBody
	public void addDetailProduct(
			@RequestParam String product_num, 
			@RequestParam String product_size_id,
			@RequestParam String addProductsAmount
			) {
		System.out.println(product_num);
		System.out.println(product_size_id);
		System.out.println(addProductsAmount);
		DetailProductDTO detailProductDTO = new DetailProductDTO();
		detailProductDTO.setProduct_num(Integer.parseInt(product_num));
		detailProductDTO.setProduct_size_id(Integer.parseInt(product_size_id));
		detailProductDTO.setAddProductsAmount(Integer.parseInt(addProductsAmount));
		detailProductDTO.setStatus(1);
		
		productService.addDetailProduct(detailProductDTO);
	}
	
	@PostMapping("/deleteDetailProductByDetailProductID")
	@ResponseBody
	public void deleteDetailProductByDetailProductID(@RequestParam int detail_product_id) {
		productService.deleteDetailProductByDetailProductID(detail_product_id);
		
	}
	
	
	//메인페이지 추천 브랜드 관련 메소드. 추후 관리자 페이지에서 선택하여 가능하게끔..현재는 최신 3개 브랜드 자동 노출
	@PostMapping("/recommendBrand")
	@ResponseBody
	public List<ProductCategoryDTO> recommendBrand() {
		return productService.recommendBrand();
	}
	
	//메인페이지 신발 추천 브랜드 관련 메소드. 추후 관리자 페이지에서 선택하여 가능하게끔..현재는 최신 3개 브랜드 자동 노출
	@PostMapping("/getRecommendShoesBrand")
	@ResponseBody
	public List<ProductDTO> recommendShoesBrand() {
		return productService.recommendShoesBrand();
	}
	
	//nav의 검색시 결과반환 메서드. product_name을 기준으로 검색한다. 
	
	@PostMapping("/searchList")
	public String searchList(@RequestParam String product_name, Model model) {
		model.addAttribute("product_name", product_name);
		model.addAttribute("display", "/WEB-INF/views/product/searchList.jsp");
		return "index";
	}
	
	@PostMapping("/getProductsByProductName")
	@ResponseBody
	public List<ProductDTO> getSearchList(@RequestParam String product_name) {
		return productService.getProductsByProductName(product_name);
	}
	
	@PostMapping("/getNavMenProductCategoryDTO")
	@ResponseBody
	public List<ProductCategoryDTO> getNavMenProductCategoryDTO() {
		return productService.getNavMenProductCategoryDTO();
	}
	
	@PostMapping("/getNavWomenProductCategoryDTO")
	@ResponseBody
	public List<ProductCategoryDTO> getNavWomenProductCategoryDTO() {
		return productService.getNavWomenProductCategoryDTO();
	}
	
	@PostMapping("/getNavBrandProductCategoryDTO")
	@ResponseBody
	public Map<String, Object> getNavBrandProductCategoryDTO() {
		return productService.getNavBrandProductCategoryDTO();
	}
	
	
	
	@PostMapping("/getProductCategoryByProductCategoryREF")
	@ResponseBody
	public ProductCategoryDTO getProductCategoryByProductCategoryREF(@RequestParam int product_category_num) {
		System.out.println("getProductCategoryByProductCategoryREF : " + product_category_num);
		return productService.getProductCategoryByProductCategoryREF(product_category_num);
	}
	
	
	
	@PostMapping("/getProductListByProductCategory")
	@ResponseBody
	public List<ProductDTO> getProductListByProductCategory(@RequestParam int product_category_num) {
		System.out.println("getProductListByProductCategory : " + product_category_num);
		List<ProductDTO> list = productService.getProductListByProductCategory(product_category_num);
		System.out.println(list);
		return list;
	}
}
