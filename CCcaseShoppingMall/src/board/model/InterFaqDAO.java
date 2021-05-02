package board.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterFaqDAO {

	List<FaqVO> selectPagingFaq(Map<String, String> paraMap) throws SQLException; // 모든 faq select 해와서 목록에 보여주기

	int selectTotalPage(Map<String, String> paraMap) throws SQLException;// 페이징처리를 위해서 전체FAQ에 대한 총페이지 개수 알아오기(select)  

	//조회수 증가시키고 가져오기
	void updateViewCount(String faqno)throws SQLException;

	//FAQ 글쓰기 insert 해주기
	int faqInsert(FaqVO fvo) throws SQLException;

	
	//FAQ 글내용 수정을 위해 하나의 FAQ를 select해오기
	FaqVO faqEditOneView(String faqno) throws SQLException;

	//FAQ 글내용 수정하기(UPDATE)
	int faqEditUpdate(FaqVO fvo) throws SQLException;

	//FAQ 글내용 삭제하기(DELETE)
	int faqDeleteOne(FaqVO fvo) throws SQLException;


	
}
