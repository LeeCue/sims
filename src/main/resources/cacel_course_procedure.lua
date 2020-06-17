--[[
 · 退选课程 lua 脚本实现 参数 KEYS[1] 为 courseId，值 ARGV[1] 表示 studentId
        1. 返回 1 代表退选成功
--]]
-- 当前要退选的课程中的学生 KEY
local selectedCourseKey = 'course_selected_student_'..KEYS[1]
-- 学生要退选的课程 KEY
local studentSelected = 'student_selected_course_'..ARGV[1]
-- 课程数量剩余 key
local courseNumKey = 'course_left_num_'..KEYS[1]
-- 剩余课程数量 + 1
redis.call('incrby', courseNumKey, 1)
-- 删除学生选择课程中，该课程 id
redis.call('lrem', studentSelected, 1, KEYS[1])
-- 删除课程选择信息中，该名学生 id
redis.call('srem', selectedCourseKey, ARGV[1])