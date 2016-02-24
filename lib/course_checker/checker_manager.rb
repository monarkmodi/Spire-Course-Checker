module CourseChecker
  class CheckerManager < Array

    def initialize(interval)
      @interval = interval
    end

    # Start checkers task
    def run
      @active = true
      t = Thread.new do
        while @active do
          check_all
          sleep @interval
        end
      end

      t.join
    end

    # Stop the checker
    def stop
      @active = false
    end

    def check_all
      self.each do |checker|
        checker.check
      end
    end

  end
end