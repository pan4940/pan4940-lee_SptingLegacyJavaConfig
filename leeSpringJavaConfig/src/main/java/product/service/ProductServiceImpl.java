package product.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import file.bean.FileDTO;
import file.mapper.FileMapper;
import product.bean.DetailProductDTO;
import product.bean.ProductCategoryDTO;
import product.bean.ProductDTO;
import product.bean.ProductSizeDTO;
import product.mapper.ProductMapper;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductMapper productMapper;
	
	@Autowired
	private FileMapper fileMapper;
	
	@Override
	public void createBrandCategorySelectKey(ProductCategoryDTO productCategoryDTO) {
		
		productMapper.createBrandCategorySelectKey(productCategoryDTO);
		
		productCategoryDTO.getFileList().forEach(t -> {
			t.setLinked_num(productCategoryDTO.getProduct_category_num());
			fileMapper.brandFileInsert(t);
		});
		
	}
	
	@Override
	public List<ProductCategoryDTO> getBrandsCategoryList() {
		List<ProductCategoryDTO> list = productMapper.getBrandsCategoryList();
		for (ProductCategoryDTO productCategoryDTO : list) {
			productCategoryDTO.setFileList(fileMapper.findByBrandNum(productCategoryDTO.getProduct_category_num()));
		}
		return list; 
	}
	
	@Override
	public List<ProductCategoryDTO> getProductCategoryList() {
		return productMapper.getProductCategoryList();
	}
	
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public void productRegister(ProductDTO productDTO) {
		if (productDTO.getFileList() == null || productDTO.getFileList().size() <= 0) {
			return;
		}
		int brandCategory = productDTO.getBrandCategory();
		String brand_name = productMapper.findBrandNameByBrandCategory(brandCategory);
		productDTO.setBrand_name(brand_name);
		if (productDTO.getCateCode2() == productDTO.getCateCode3()) {
			System.out.println("3번 카테고리 없음");
			productDTO.setCateCode3(0);
		}
		System.out.println("before productDTO : " + productDTO);
		productMapper.productRegisterSelectKey(productDTO);
		productMapper.productRegisterCategory_link(productDTO);
		
		
		productDTO.getFileList().forEach(t -> {
			t.setLinked_num(productDTO.getProduct_num());
			System.out.println("productDTO : " + t);
			fileMapper.productFileInsert(t);
		});
		
		System.out.println("after productDTO : " + productDTO);
		
	}
	
	@Override
	public ProductDTO getProductDTO(int product_num) {
		ProductDTO productDTO = productMapper.getProductDTO(product_num);
		productDTO.setFileList(fileMapper.findByProductNum(product_num));
		return productDTO;
	}
	
	
	@Override
	public ProductDTO searchProductName(String product_name) {
		return productMapper.searchProductName(product_name);
	}
	
	@Override
	public List<ProductDTO> getProductByCategory(Map<String, String> map) {
		
		List<ProductDTO> list = productMapper.getProductByCategory(map);
		
		return list;
	}
	
	@Override
	public ProductDTO getProductByProductNum(String product_num) {
		return productMapper.getProductByProductNum(product_num);
	}
	
	@Override
	public List<FileDTO> getProductFileList(int product_num) {
		return fileMapper.findByProductNum(product_num);
	}
	
	
	@Override
	@Transactional(rollbackFor = Exception.class)
	public void modify(ProductDTO productDTO) {
		
		
		if (productDTO.getFileList() == null || productDTO.getFileList().size() <= 0) {
			return;
		}
		
		String brand_name = productMapper.findBrandNameByBrandCategory(productDTO.getBrandCategory());
		productDTO.setBrand_name(brand_name);
		
		if (productDTO.getCateCode2() == productDTO.getCateCode3()) {
			System.out.println("3번 카테고리 없음");
			productDTO.setCateCode3(0);
		}

		fileMapper.productFileDeleteAll(productDTO.getProduct_num());
		
		productDTO.getFileList().forEach(t -> {
			t.setLinked_num(productDTO.getProduct_num());
			System.out.println("productDTO : " + t);
			fileMapper.productFileInsert(t);
		});
		
		System.out.println(productDTO);
		productMapper.modifyProduct(productDTO);
	}
	
	
	@Override
	public void delete(int product_num) {
		fileMapper.productFileDeleteAll(product_num);
		productMapper.productDeleteCategory_link(product_num);
		productMapper.deleteProduct(product_num);
	}
	
	@Override
	public ProductCategoryDTO getProductCategoryDTO(int product_category_num) {
		
		ProductCategoryDTO productCategoryDTO = productMapper.getProductCategoryDTO(product_category_num);
		
		List<FileDTO> brandFileDTOList = getBrandFileList(product_category_num);
		System.out.println("brandFileDTOList : " + brandFileDTOList);
		productCategoryDTO.setFileList(brandFileDTOList);
		
		return productCategoryDTO;
	}
	
	@Override
	public List<FileDTO> getBrandFileList(int product_category_num) {
		List<FileDTO> list = fileMapper.findByBrandNum(product_category_num);
		System.out.println("list : " + fileMapper.findByBrandNum(product_category_num));
		return list;
	}
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public void modifyBrandCategory(ProductCategoryDTO productCategoryDTO) {
		if (productCategoryDTO.getFileList() == null || productCategoryDTO.getFileList().size() <= 0) {
			return;
		}
		
		System.out.println("modify productCategoryDTO : " + productCategoryDTO);
		fileMapper.brandFileDeleteAll(productCategoryDTO.getProduct_category_num());
		
		productCategoryDTO.getFileList().forEach(t -> {
			t.setLinked_num(productCategoryDTO.getProduct_category_num());
			System.out.println("BrandFileDTO : " + t);
			fileMapper.brandFileInsert(t);
		});
		
		System.out.println(productCategoryDTO);
		productMapper.modifyBrandCategory(productCategoryDTO);
	}
	
	@Override
	public List<ProductDTO> getProductsByBrandCategory(int brandCategory) {
		List<ProductDTO> list = productMapper.getProductsByBrandCategory(brandCategory);
		for (ProductDTO productDTO : list) {
			productDTO.setFileList(fileMapper.findByProductNum(productDTO.getProduct_num()));
		}
		return list;
	}
	
	
	@Override
	public String getBrandnameByBrandcategory(int brandCategory) {
		return productMapper.getBrandnameByBrandcategory(brandCategory);
	}
	
	@Override
	public void registerProductSize(ProductSizeDTO productSizeDTO) {
		ProductDTO productDTO = productMapper.getProductByProductNum(productSizeDTO.getProduct_num() + "");
		System.out.println("registerProductSize productDTO: " + productDTO);
		
		if (productDTO.getCateCode2() == 1100 || productDTO.getCateCode2() == 2100) {
			System.out.println("상의 상품");
			productMapper.registerTopProductSize(productSizeDTO);
		} else if (productDTO.getCateCode2() == 1200 || productDTO.getCateCode2() == 2100) {
			System.out.println("하의 상품");
			productMapper.registerBottomProductSize(productSizeDTO);
		} else if (productDTO.getCateCode2() == 1400 || productDTO.getCateCode2() == 2400) {
			System.out.println("모자 상품");
			productMapper.registerCapProductSize(productSizeDTO);
		} else {
			System.out.println("원사이즈 상품");
			productMapper.registerOneSizeProductSize(productSizeDTO);
		}
	}
	
	
	@Override
	public void modifyProductSize(ProductSizeDTO productSizeDTO) {
		ProductDTO productDTO = productMapper.getProductByProductNum(productSizeDTO.getProduct_num() + "");
		System.out.println("Modify ProductSize productDTO: " + productDTO);
		
		if (productDTO.getCateCode2() == 1100 || productDTO.getCateCode2() == 2100) {
			System.out.println("상의 상품");
			productMapper.modifyTopProductSize(productSizeDTO);
		} else if (productDTO.getCateCode2() == 1200 || productDTO.getCateCode2() == 2100) {
			System.out.println("하의 상품");
			productMapper.modifyBottomProductSize(productSizeDTO);
		} else if (productDTO.getCateCode2() == 1400 || productDTO.getCateCode2() == 2400) {
			System.out.println("모자 상품");
			productMapper.modifyCapProductSize(productSizeDTO);
		} else {
			System.out.println("원사이즈 상품");
			productMapper.modifyOneSizeProductSize(productSizeDTO);
		}
	}
	
	
	@Override
	public List<ProductSizeDTO> getProductByProductSize(int product_num) {
		return productMapper.getProductByProductSize(product_num);
	}
	
	@Override
	public ProductSizeDTO getProductSizeByProductSizeId(int product_size_id) {
		ProductSizeDTO productSizeDTO = productMapper.getProductSizeByProductSizeId(product_size_id);
		System.out.println("product_size_id : " + product_size_id);
		
		return productSizeDTO;
	}
	
	@Override
	public void deleteProductSize(int product_size_id) {
		productMapper.deleteProductSize(product_size_id);
	}
	
	@Override
	public List<DetailProductDTO> getDetailProductListByProductSizeId(int product_size_id) {
		return productMapper.getDetailProductListByProductSizeId(product_size_id);
	}
	
	
	@Override
	public void addDetailProduct(DetailProductDTO detailProductDTO) {
		for (int i = 0; i < detailProductDTO.getAddProductsAmount(); i++) {
			productMapper.addDetailProduct(detailProductDTO);
		}
	}
	
	@Override
	public void deleteDetailProductByDetailProductID(int detail_product_id) {
		productMapper.deleteDetailProductByDetailProductID(detail_product_id);
	}
	
	@Override
	public List<ProductCategoryDTO> recommendBrand() {
		List<ProductCategoryDTO> list = productMapper.recommendBrand();
		
		for (ProductCategoryDTO productCategoryDTO : list) {
			productCategoryDTO.setFileList(fileMapper.findByBrandNum(productCategoryDTO.getProduct_category_num()));
		}
		return list;
	}
	
	
	@Override
	public List<ProductDTO> recommendShoesBrand() {
		List<ProductDTO> list = productMapper.recommendShoesBrand();
		for (ProductDTO productDTO : list) {
			productDTO.setFileList(fileMapper.findByProductNum(productDTO.getProduct_num()));
		}
		return list;
	}
	
	
	@Override
	public List<ProductDTO> getProductsByProductName(String product_name) {
		List<ProductDTO> list = productMapper.getProductsByProductName(product_name);
		for (ProductDTO productDTO : list) {
			productDTO.setFileList(fileMapper.findByProductNum(productDTO.getProduct_num()));
		}
		return list;
	}
	
	@Override
	public List<ProductCategoryDTO> getNavMenProductCategoryDTO() {
		List<ProductCategoryDTO> list = new ArrayList<>();
		int[] arr = {10158, 10160};
		
		for (int product_category_num : arr) {
			ProductCategoryDTO productCategoryDTO = productMapper.getProductCategoryDTO(product_category_num);
			list.add(productCategoryDTO);
			productCategoryDTO.setFileList(fileMapper.findByBrandNum(product_category_num));
		}
		
		return list;
	}
	
	
	@Override
	public List<ProductCategoryDTO> getNavWomenProductCategoryDTO() {
		List<ProductCategoryDTO> list = new ArrayList<>();
		int[] arr = {10162, 10164};
		
		for (int product_category_num : arr) {
			ProductCategoryDTO productCategoryDTO = productMapper.getProductCategoryDTO(product_category_num);
			list.add(productCategoryDTO);
			productCategoryDTO.setFileList(fileMapper.findByBrandNum(product_category_num));
		}
		
		return list;
	}
	
	@Override
	public Map<String, Object> getNavBrandProductCategoryDTO() {
		List<ProductCategoryDTO> threeProductCategoryDTO = new ArrayList<>();
		int[] arr = {10158, 10163, 10164};
		
		for (int product_category_num : arr) {
			ProductCategoryDTO productCategoryDTO = productMapper.getProductCategoryDTO(product_category_num);
			threeProductCategoryDTO.add(productCategoryDTO);
			productCategoryDTO.setFileList(fileMapper.findByBrandNum(product_category_num));
		}
		Map<String, Object> map = new HashMap<>();
		map.put("threeProductCategoryDTO", threeProductCategoryDTO);
		
		List<ProductCategoryDTO> brandCategory = productMapper.getNavBrandProductCategoryDTO();
		
		map.put("brandCategory", brandCategory);
		
		return map;
	}
	
	
	@Override
	public ProductCategoryDTO getProductCategoryByProductCategoryREF(int product_category_num) {
		
		if (1000 <= product_category_num && product_category_num < 2000) {
			System.out.println("남성품목");
			ProductCategoryDTO firstCategory = productMapper.getProductCategoryDTO(1000);
			firstCategory.setProductCategoryList(productMapper.getProductCategoryByProductCategoryREF(firstCategory.getProduct_category_num()));
			
			for (ProductCategoryDTO productCategoryDTO : firstCategory.getProductCategoryList()) {
				productCategoryDTO.setProductCategoryList(productMapper.getProductCategoryByProductCategoryREF(productCategoryDTO.getProduct_category_num()));
			}
			
			return firstCategory;
		} else {
			System.out.println("여성품목");
			ProductCategoryDTO firstCategory = productMapper.getProductCategoryDTO(2000);
			firstCategory.setProductCategoryList(productMapper.getProductCategoryByProductCategoryREF(firstCategory.getProduct_category_num()));
			
			for (ProductCategoryDTO productCategoryDTO : firstCategory.getProductCategoryList()) {
				productCategoryDTO.setProductCategoryList(productMapper.getProductCategoryByProductCategoryREF(productCategoryDTO.getProduct_category_num()));
			}
			return firstCategory;
		}
	}
	
	
	@Override
	public List<ProductDTO> getProductListByProductCategory(int product_category_num) {
		List<ProductDTO> list = productMapper.getProductListByProductCategory(product_category_num);
		for (ProductDTO productDTO : list) {
			productDTO.setFileList(fileMapper.findByProductNum(productDTO.getProduct_num()));
		}
		
		return list;
	}
	
	@Override
	public int getTotalCount(int product_category_num) {
		return productMapper.getTotalCount(product_category_num);
	}
	
	
	@Override
	public void deleteBrandCategory(int product_category_num) {
		fileMapper.brandFileDeleteAll(product_category_num);
		productMapper.deleteBrandCategory(product_category_num);
	}
	
}
