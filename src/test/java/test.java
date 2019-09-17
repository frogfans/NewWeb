import com.xhh.web.dao.TestDao;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

public class test {
    @Autowired
    TestDao testDao;
    @Test
    public void aa(){
        String name_age = testDao.find_name_age();
        System.out.println(name_age);
    }
}
