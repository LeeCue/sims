--[[
 · 抢课 lua 脚本实现 参数 KEYS[1] 为 courseId，值 ARGV[1] 表示 studentId
        1. 返回 -2 代表已经该名学生选择过
        2. 返回 -1 代表该课程已经目前已满，不可选择
        3. 返回 1 代表选择成功
--]]
-- 当前选择的课程中的学生 KEY
local selectedCourseKey = 'course_selected_student_'..KEYS[1]
-- 学生已经选择的课程 KEY
local studentSelected = 'student_selected_course_'..ARGV[1]
-- 课程数量剩余 key
local courseNumKey = 'course_left_num_'..KEYS[1]
-- 判断该学生是否已经选择过
local selected = tonumber(redis.call('sismember', selectedCourseKey, ARGV[1]))
-- 如果已经选择过，直接返回 -2
if selected > 0 then
    return -2
end
local leftNum = tonumber(redis.call('get', courseNumKey))
if leftNum <= 0 then
    --说明该课程已经满员，不能再选择
    return -1
else
    leftNum = leftNum - 1;
    redis.call('sadd', selectedCourseKey, ARGV[1])
    redis.call('decrby', courseNumKey, 1)
    redis.call('rpush', studentSelected, KEYS[1])
    return 1
end