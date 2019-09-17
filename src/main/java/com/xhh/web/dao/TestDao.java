package com.xhh.web.dao;

import org.apache.ibatis.annotations.Select;

public interface TestDao {
    @Select("select id, name from mytest where id=1 ")
    String find_name_age();
}
