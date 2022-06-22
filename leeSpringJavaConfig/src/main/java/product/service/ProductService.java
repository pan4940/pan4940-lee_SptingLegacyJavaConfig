package product.service;

import java.util.List;
import java.util.Map;

import board.bean.BoardDTO;
import file.bean.FileDTO;
import product.bean.DetailProductDTO;
import product.bean.ProductCategoryDTO;
import product.bean.ProductDTO;
import product.bean.ProductSizeDTO;

public interface ProductService {

	public List<ProductCategoryDTO> getProductCategoryList();

	public List<ProductCategoryDTO> getBrandsCategoryList();

	public void createBrandCategorySelectKey(ProductCategoryDTO productCategoryDTO);

	public void productRegister(ProductDTO productDTO);

	public ProductDTO getProductDTO(int product_num);

	public ProductDTO searchProductName(String product_name);

	public List<ProductDTO> getProductByCategory(Map<String, String> map);

	public ProductDTO getProductByProductNum(String product_num);

	public List<FileDTO> getProductFileList(int product_num);

	public void modify(ProductDTO productDTO);

	public void delete(int parseInt);

	public ProductCategoryDTO getProductCategoryDTO(int product_category_num);

	public List<FileDTO> getBrandFileList(int brand_num);

	public void modifyBrandCategory(ProductCategoryDTO productCategoryDTO);

	public List<ProductDTO> getProductsByBrandCategory(int brandCategory);

	public String getBrandnameByBrandcategory(int brandCategory);

	public void registerProductSize(ProductSizeDTO productSizeDTO);

	public List<ProductSizeDTO> getProductByProductSize(int product_num);

	public ProductSizeDTO getProductSizeByProductSizeId(int product_size_id);

	public void modifyProductSize(ProductSizeDTO productSizeDTO);

	public void deleteProductSize(int product_size_id);

	public List<DetailProductDTO> getDetailProductListByProductSizeId(int product_size_id);

	public void addDetailProduct(DetailProductDTO detailProductDTO);

	public void deleteDetailProductByDetailProductID(int detail_product_id);

	public List<ProductCategoryDTO> recommendBrand();

	public List<ProductDTO> recommendShoesBrand();

	public List<ProductDTO> getProductsByProductName(String product_name);

	public List<ProductCategoryDTO> getNavMenProductCategoryDTO();

	public List<ProductCategoryDTO> getNavWomenProductCategoryDTO();

	public Map<String, Object> getNavBrandProductCategoryDTO();

	public ProductCategoryDTO getProductCategoryByProductCategoryREF(int product_category_num);

	public List<ProductDTO> getProductListByProductCategory(int product_category_num);

	public int getTotalCount(int product_category_num);

	public void deleteBrandCategory(int product_category_num);

	
}
