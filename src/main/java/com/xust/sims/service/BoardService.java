package com.xust.sims.service;

import com.xust.sims.entity.NoticeBoard;

import java.util.List;

/**
 * @author LeeCue
 * @date 2020-06-08
 */
public interface BoardService {
    /**
     * 根据关键字来查询公告内容
     * @param keyword
     * @return
     */
    List<NoticeBoard> findBoards(String keyword);

    /**
     * 根据关键字来查询公告内容
     * @param typeName
     * @return
     */
    List<NoticeBoard> findBoardsByTypeName(String typeName);

    /**
     * 根据id来查找公告
     * @param id
     * @return
     */
    NoticeBoard findBoardById(Integer id);

    /**
     * 增加公告
     * @param board
     */
    void addBoard(NoticeBoard board);

    /**
     * 修改公告内容
     * @param board
     */
    void updateBoard(NoticeBoard board);

    /**
     * 根据id修改公告状态
     * @param id
     * @param published
     */
    void changeBoardPublished(Integer id, Boolean published);
}
