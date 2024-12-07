        <%@ page import="com.example.cafe.dto.OrdersTO" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    List<OrdersTO> orders = (List<OrdersTO>) request.getAttribute("orders");
    String email = (String) request.getAttribute("email");

    StringBuilder sbHtml = new StringBuilder();
    int orderId=0;
    for (OrdersTO ordersTO : orders) {
        boolean isDisabled = ordersTO.getOrderStatus().equals("afterDelivery");
        orderId = ordersTO.getOrder_id();
        String address = ordersTO.getAddress();
        String orderDate = ordersTO.getOrder_date();
        String orderStatus = ordersTO.getOrderStatus();
        String zip_code = ordersTO.getZip_code();

        sbHtml.append("<label><input type='radio' name='selectedOrder' value='" + orderId + "'" + (isDisabled ? " disabled" : "") + "></label>");
        sbHtml.append("<table>");
        sbHtml.append("<thead>");
        sbHtml.append("<tr>");
        sbHtml.append("<th></th>");
        sbHtml.append("<th>주문 번호</th>");
        sbHtml.append("<th>상품 이름</th>");
        sbHtml.append("<th>주문 수량</th>");
        sbHtml.append("<th>상품 가격</th>");
        sbHtml.append("<th>주소</th>");
        sbHtml.append("<th>주문 일자</th>");
        sbHtml.append("<th>배송 상태</th>");

        for (int i = 0; i < ordersTO.getItems().size(); i++) {
            sbHtml.append("</tr> ");
            sbHtml.append("</thead> ");
            sbHtml.append("<tbody> ");
            sbHtml.append("<tr> ");
            sbHtml.append("<td></td>");
            sbHtml.append("<td>" + orderId + "</td>");

            String itemName = ordersTO.getItems().get(i).getName();
            sbHtml.append("<td>" + itemName + "</td>");
            String orderCount = ordersTO.getOrderItems().get(i).getOrderCount();
            sbHtml.append("<td>" + orderCount + "</td>");
            String orderPrice = ordersTO.getOrderItems().get(i).getOrderPrice();
            sbHtml.append("<td>&#x20a9;" + orderPrice + "</td>");
            sbHtml.append("<td>" + "[" + zip_code + "] " + address + "</td>");
            sbHtml.append("<td>" + orderDate + "</td>");
            sbHtml.append("<td>" + orderStatus + "</td>");
            sbHtml.append("</tr>");
        }
        sbHtml.append("</tbody>");
        sbHtml.append("</table>");
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>주문목록 조회</title>
  <script type="text/javascript">
    window.onload = function () {
      document.getElementById( 'btn_select' ).onclick = function () {
        // 모든 라디오 버튼 가져오기
        const radioButtons = document.querySelectorAll("input[name='selectedOrder']");
        // 라디오 버튼이 모두 disabled 인지 확인
        const allDisabled = Array.from(radioButtons).every(radio => radio.disabled);
        if (allDisabled) {
          alert("주문을 선택할 수 없는 상태입니다.");
          return false;
        }
        // 선택된 라디오 버튼 확인
        const selected = Array.from(radioButtons).some(radio => radio.checked);
        if (!selected) {
          alert("옵션을 선택해주세요.");
          return false;
        }
        document.orderForm.submit();
      };
    };
  </script>
  <style>
    body {
      padding:1.5em;
      background: #f5f5f5
    }

    table {
      border: 1px #a39485 solid;
      font-size: .9em;
      box-shadow: 0 2px 5px rgba(0,0,0,.25);
      width: 100%;
      margin-bottom: 20px;
      border-collapse: collapse;
      border-radius: 5px;
      overflow: hidden;
    }

    th {
      text-align: left;
    }

    thead {
      font-weight: bold;
      color: #dddddd;
      background: #202428;
    }

    td, th {
      padding: 1em .5em;
      vertical-align: middle;
    }

    td {
      border-bottom: 1px solid rgba(0,0,0,.1);
      background: #fff;
    }

    a {
      color: #73685d;
    }

    @media all and (max-width: 768px) {

      table, thead, tbody, th, td, tr {
        display: block;
      }

      th {
        text-align: center;
      }

      table {
        position: relative;
        padding-bottom: 0;
        border: none;
        box-shadow: 0 0 10px rgba(0,0,0,.2);
      }

      thead {
        float: left;
        white-space: nowrap;
      }

      tbody {
        overflow-x: auto;
        overflow-y: hidden;
        position: relative;
        white-space: nowrap;
      }

      tr {
        display: inline-block;
        vertical-align: top;
      }

      th {
        border-bottom: 1px solid #a39485;
      }

      td {
        border-bottom: 1px solid #e5e5e5;
      }
    }

    input[type='radio'] {
      -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    width: 18px;
      height: 18px;
      border: 2px solid #ccc;
    border-radius: 50%;
      outline: none;
    cursor: pointer;
    }

    input[type='radio']:checked {
         background-color: #73685d;
       border: 3px solid white;
       box-shadow: 0 0 0 1.6px #202428;}

    /* 버튼 */
    input.btn-normal {
      background: #73685d;
      color: white;
      border: none;
      padding: 5px 20px;
      height: 50px;
      width: 120px;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
    }

    input.btn-back {
      background: #202428;
      color: white;
      border: none;
      padding: 5px 20px;
      height: 50px;
      width: 120px;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
    }

    input.btn-normal.large {
      font-size: 18px;
      padding: 15px 30px;
    }

    .right-align {
      display: flex;
      justify-content: flex-end;
      gap: 20px;
    }
  </style>

  <body>
<div>
  <h1 class="text-center mb-4" style="color: #202428;">주문목록 조회</h1>
  <p class="text-center mb-4" style="color: #202428;">주문 목록 선택 후 선택 버튼을 누르시면 주문 수정 또는 취소를 할 수 있습니다.</p>
</div>
  <form name="orderForm" method="post" action="orderlist_modifyanddelete.do?orderId=<%=orderId%>">
      <input type="hidden" name="email" value="<%=email%>" />
    <div class="tbl_head02 tbl_wrap">
        <%=sbHtml.toString()%>
    </div>
    <div class="btn_area">
      <div class="right-align" style="margin-top: 20px">
        <input type="button" class="btn-back large" value="뒤로가기" onclick="location.href='main.do'"/>
        <input type="button" class="btn-normal large" id="btn_select" value="선택"/>
      </div>
    </div>
  </form>
</body>
</html>
