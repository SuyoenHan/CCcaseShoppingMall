package board.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterFaqDAO {

	List<FaqVO> selectPagingFaq(Map<String, String> paraMap) throws SQLException; // 모든 faq select 해와서 목록에 보여주기

	int selectTotalPage(Map<String, String> paraMap) throws SQLException;// 페이징처리를 위해서 전체FAQ에 대한 총페이지 개수 알아오기(select)  

	FaqVO updateViewCount(String faqno)throws SQLException; //조회수 증가시키기

	
}
