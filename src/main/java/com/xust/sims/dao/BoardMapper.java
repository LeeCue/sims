package com.xust.sims.dao;

import com.xust.sims.entity.NoticeBoard;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author LeeCue
 * @date 2020-06-08
 */
@Repository
public interface BoardMapper {
    /**
     * 根据关键字进行模糊查询公告
     * @param keyword
     * @return
     */
    List<NoticeBoard> getBoards(String keyword);

    /**
     * 根据公告类型进行查询
     * @param typeName
     * @return
     */
    List<NoticeBoard> getBoardsByTypeName(String typeName);

    /**
     * 根据id来查找公告id
     * @param id
     * @return
     */
    NoticeBoard getBoardById(Integer id);

    /**
     * 增加公告内容
     * @param board
     * @return
     */
    int addBoard(NoticeBoard board);

    /**
     * 更新公告
     * @param board
     * @return
     */
    int updateBoard(NoticeBoard board);

    /**
     * 根据id修改公告状态
     * @param id
     * @param published
     */
    int updateBoardPublished(@Param("id") Integer id,
                              @Param("published") Boolean published);
}
