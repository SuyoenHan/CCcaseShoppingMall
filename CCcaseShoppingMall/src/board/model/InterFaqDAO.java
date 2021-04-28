package board.model;

import java.sql.SQLException;
import java.util.List;

public interface InterFaqDAO {

	List<FaqVO> faqAllView() throws SQLException; // 모든 faq select 해와서 목록에 보여주기

	//int faqUpdate() throws SQLException; // 글쓰기 update

}
