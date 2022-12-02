<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../_header.jsp"/>
<jsp:include page="./_${group}.jsp"/>

        <main id="board" class="modify">
            
            <form action="/Farmstory2/board/modify.do" method="post">
                <table border="0">
                <input type="hidden" name="pg" value="${pg }">
                <input type="hidden" name="no" value="${no }">
                <input type="hidden" name="cate" value="${cate }">
                <input type="hidden" name="group" value="${group }">
                    <tr>
                        <th>제목</th>
                        <td><input type="text" name="title" placeholder="제목을 입력하세요." value ="${article.title }"/></td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td><textarea name="content">${article.content }</textarea></td>
                    </tr>
                    <tr>
                        <th>파일</th>
                        <td><input type="file" name="file"/></td>
                    </tr>
                </table>

                <div>
                    <a href="./view.do?group=${group }&cate=${cate}&no=${no}&pg=${pg}" class="btn btnCancel">취소</a>
                    <input type="submit" value="수정완료" class="btn btnComplete"/>
                </div>
            </form>
        </main>
        </div>

<jsp:include page="../_footer.jsp"/>