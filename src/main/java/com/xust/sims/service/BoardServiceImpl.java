package com.xust.sims.service;

import com.xust.sims.dao.BoardMapper;
import com.xust.sims.entity.NoticeBoard;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * @author LeeCue
 * @date 2020-06-08
 */
@Service
public class BoardServiceImpl implements BoardService {
    @Autowired
    private BoardMapper boardMapper;

    @Override
    public List<NoticeBoard> findBoards(String keyword) {
        return boardMapper.getBoards(keyword);
    }

    @Override
    public List<NoticeBoard> findBoardsByTypeName(String typeName) {
        return boardMapper.getBoardsByTypeName(typeName);
    }

    @Override
    public NoticeBoard findBoardById(Integer id) {
        return boardMapper.getBoardById(id);
    }

    @Override
    public void addBoard(NoticeBoard board) {
        board.setCreateTime(new Date(System.currentTimeMillis()));
        board.setUpdateTime(new Date(System.currentTimeMillis()));
        boardMapper.addBoard(board);
    }

    @Override
    public void updateBoard(NoticeBoard board) {
        board.setUpdateTime(new Date(System.currentTimeMillis()));
        boardMapper.updateBoard(board);
    }

    @Override
    public void changeBoardPublished(Integer id, Boolean published) {
        boardMapper.updateBoardPublished(id, published);
    }

    @Override
    public void deleteBoardById(Integer id) {
        boardMapper.deleteBoardById(id);
    }
}
