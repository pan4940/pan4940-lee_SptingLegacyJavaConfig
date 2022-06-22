
package product.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import board.bean.BoardDTO;
import file.bean.FileDTO;
import product.bean.DetailProductDTO;
import product.bean.ProductCategoryDTO;
import product.bean.ProductDTO;
import product.bean.ProductSizeDTO;

@Mapper
public interface ProductMapper {


	public void createBrandCategorySelectKey(ProductCategoryDTO productCategoryDTO);

	public List<ProductCategoryDTO> getBrandsCategoryList();

	public List<ProductCategoryDTO> getProductCategoryList();

	public void productRegister(ProductDTO productDTO);

	public void productRegisterSelectKey(ProductDTO productDTO);


	public ProductDTO searchProductName(String product_name);

	public String findBrandNameByBrandCategory(int brandCategory);

	public void productRegisterCategory_link(ProductDTO productDTO);

	public List<ProductDTO> getProductByCategory(Map<String, String> map);

	public ProductDTO getProductByProductNum(String product_num);

	public void modifyProduct(ProductDTO productDTO);

	public void productDeleteCategory_link(int product_num);

	public void deleteProduct(int product_num);

	public ProductCategoryDTO getProductCategoryDTO(int product_category_num);


	public void modifyBrandCategory(ProductCategoryDTO productCategoryDTO);

	public List<ProductDTO> getProductsByBrandCategory(int brandCategory);

	public String getBrandnameByBrandcategory(int brandCategory);

	public ProductDTO getProductDTO(int product_num);

	public void registerTopProductSize(ProductSizeDTO productSizeDTO);

	public void registerBottomProductSize(ProductSizeDTO productSizeDTO);

	public void registerCapProductSize(ProductSizeDTO productSizeDTO);

	public void registerOneSizeProductSize(ProductSizeDTO productSizeDTO);

	public List<ProductSizeDTO> getProductByProductSize(int product_num);

	public ProductSizeDTO getProductSizeByProductSizeId(int product_size_id);

	public void modifyTopProductSize(ProductSizeDTO productSizeDTO);

	public void modifyBottomProductSize(ProductSizeDTO productSizeDTO);

	public void modifyCapProductSize(ProductSizeDTO productSizeDTO);

	public void modifyOneSizeProductSize(ProductSizeDTO productSizeDTO);

	public void deleteProductSize(int product_size_id);


	public List<DetailProductDTO> getDetailProductListByProductSizeId(int product_size_id);

	public void addDetailProduct(DetailProductDTO detailProductDTO);

	public void deleteDetailProductByDetailProductID(int detail_product_id);

	public DetailProductDTO getDetailProductByDetailProductId(int detail_product_id);

	public List<DetailProductDTO> getDetailProductListByProductMemberId(String member_id);

	public List<ProductCategoryDTO> recommendBrand();

	public List<ProductDTO> recommendShoesBrand();

	public List<ProductDTO> getProductsByProductName(String product_name);

	public List<ProductCategoryDTO> getNavBrandProductCategoryDTO();

	public List<ProductCategoryDTO> getNavProductCategoryList();


	public List<ProductCategoryDTO> getProductCategoryByProductCategoryREF(int product_category_num);


	public ProductCategoryDTO getOneProductCategory(int product_category_num);

	public List<ProductDTO> getProductListByProductCategory(int product_category_num);

	public int getTotalCount(int product_category_num);

	public void deleteBrandCategory(int product_category_num);


}
