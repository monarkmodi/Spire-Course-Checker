module CourseChecker
  class Course

    attr_accessor :id, :name, :instructor, :status

    def initialize(id, name, instructor, status)
      @id = id
      @name = name
      @instructor = instructor
      @status = status
    end

  end
end