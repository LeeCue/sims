package com.xust.sims.web.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xust.sims.dto.RespBean;
import com.xust.sims.dto.ResponseCode;
import com.xust.sims.entity.NoticeBoard;
import com.xust.sims.service.BoardService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

/**
 * @author LeeCue
 * @date 2020-06-08
 */
@RestController
@RequestMapping("/web")
@Slf4j
public class BoardController extends BaseController {
    @Autowired
    private BoardService boardService;

    @GetMapping("/init/board")
    @Secured({"ROLE_user"})
    public PageInfo<NoticeBoard> initData(@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
                                          @RequestParam(value = "currPage") Integer currPage,
                                          @RequestParam(value = "pageSize") Integer pageSize) {
        PageHelper.startPage(currPage, pageSize);
        List<NoticeBoard> temp = boardService.findBoards(keyword);
        return new PageInfo<>(temp);
    }

    @GetMapping("/getBoard")
    @Secured({"ROLE_user"})
    public NoticeBoard getBoardById(@RequestParam("id") Integer id) {
        return boardService.findBoardById(id);
    }

    @GetMapping("/board/type")
    @Secured({"ROLE_user"})
    public PageInfo<NoticeBoard> getBoardByType(@RequestParam("typeName") String typeName,
                                                @RequestParam("currPage") Integer currPage,
                                                @RequestParam("pageSize") Integer pageSize) {
        PageHelper.startPage(currPage, pageSize);
        List<NoticeBoard> temp = boardService.findBoardsByTypeName(typeName);
        return new PageInfo<NoticeBoard>(temp);
    }

    @GetMapping("/changeBoard/published")
    @Secured({"ROLE_admin"})
    public RespBean changePublished(@RequestParam("id") Integer id,
                                    @RequestParam("published") Boolean published) {
        boardService.changeBoardPublished(id, published);
        return new RespBean(ResponseCode.SUCCESS);
    }

    @PostMapping("/add/board")
    @Secured({"ROLE_admin"})
    public RespBean addBoard(@Valid @RequestBody NoticeBoard noticeBoard, BindingResult result) {
        log.info("公告内容为：{}", noticeBoard);
        if (result.hasErrors()) {
            return new RespBean(ResponseCode.ERROR, dealErrorMessage(result));
        }
        boardService.addBoard(noticeBoard);
        return new RespBean(ResponseCode.SUCCESS);
    }

    @PostMapping("/update/board")
    @Secured({"ROLE_admin"})
    public RespBean updateBoard(@Valid @RequestBody NoticeBoard noticeBoard, BindingResult result) {
        log.info("更新后的公告信息为：{}", noticeBoard);
        if (result.hasErrors()) {
            return new RespBean(ResponseCode.ERROR, dealErrorMessage(result));
        }
        boardService.updateBoard(noticeBoard);
        return new RespBean(ResponseCode.SUCCESS);
    }

    private String dealErrorMessage(BindingResult result) {
        StringBuilder sb = new StringBuilder();
        for (ObjectError error : result.getAllErrors()) {
            sb.append(error.getDefaultMessage()).append(";");
        }
        return sb.toString();
    }
}
