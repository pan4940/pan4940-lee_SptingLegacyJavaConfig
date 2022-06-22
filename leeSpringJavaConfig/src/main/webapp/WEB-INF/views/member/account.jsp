<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    

    <div id="accountDiv">
    <div id="head" class="col-12 col-lg-8">
    <h3><center>ACCOUNT DETAIL</center></h3>
  </div>
      <div id="center" >
        <div id="left" class="col-6 col-lg-4">
          <h4>account</h4>
          <p>${principal.memberDTO.member_name}</p>
          <input type="button" id="EditBtn" value="회원정보수정"
        		  onclick="location.href='/member/modifyForm'"/>
          <input type="button" class="logoutBtn" value="Logout" />
        </div>

        <div id="right" class="col-6 col-lg-4">
          <h4>summary</h4>
          <ul>
            
            <li>
              <label>point</label><br />
              <span>${principal.memberDTO.mileage}원</span><br />
            </li>

            <li>
              <label>coupon</label><br />
              <span>0</span>/
              <a id="iden" href="#">조회</a>
            </li>
          </ul>
        </div>
      </div>
    </div>
    

 
