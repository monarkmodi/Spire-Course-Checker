require_relative 'course_checker/cart_checker'
require_relative 'course_checker/checker_manager'

checkers = CourseChecker::CheckerManager.new(10)

# For each account, put another line here
checkers << CourseChecker::CartChecker.new("username", "password")

checkers.run
