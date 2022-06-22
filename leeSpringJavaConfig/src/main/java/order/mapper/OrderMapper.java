package order.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import order.bean.CartDTO;
import order.bean.DetailOrderDTO;
import order.bean.OrderDTO;
import product.bean.ProductDTO;

@Mapper
public interface OrderMapper {

	public List<CartDTO> getCartList(String member_id);

	public void addCart(CartDTO cartDTO);

	public CartDTO getCartDtoByDetailProductId(int detail_product_id);

	public void deleteDetailProductFromCart(int detail_product_id);

	public void registerOrderDTO(OrderDTO orderDTO);

	public void registerDetailOrderDTO(DetailOrderDTO detailOrderDTO);

	public void deleteCart(String member_id);

	public List<OrderDTO> getOrderHistory(String member_id);

	public List<DetailOrderDTO> getDetailOrderDtoByOrderId(String order_id);

	
}
