require 'mechanize'
require 'time'
require_relative 'course'

module CourseChecker

  # Checks courses in a list
  class Checker

    def initialize(user, pass)
      @browser = Mechanize.new
      @user    = user
      @pass    = pass
    end

    # Checks the status of courses
    def check
      refresh
      authenticate
      get_courses
      
      @courses.each do |course|
        puts "[#{@user}] " + course.name + " is " + course.status.to_s.upcase
        if(course.status == :open)
          # Do something here if the course is open
        end
      end
    end

    # Log into spire if not already
    def authenticate
      if(not authenticated?)

        # Add empty device features cookie, which is necessary to get past  page
        @browser.cookie_jar << Mechanize::Cookie.new(domain: '.spire.umass.edu', name: 'PS_DEVICEFEATURES', value: '', path: '/', expires: (Time.now + 7*86400))

        # Fill out form and submit
        login = @page.form_with({name: 'login'})
        login.userid = @user
        login.pwd    = @pass
        login.submit

        # Finalize by refreshing
        refresh
      end
    end

    # Refresh the shopping cart page
    def refresh
      @page = spire_request
    end

    # Whether or not spire is currently logged in
    def authenticated?
      # If not icsid exists, not authenticated
      icsid
    end

    # A session identifier necessary for authentication
    def icsid
      if(@page)
        elem = @page.search('//*[@id="ICSID"]')[0]
        if(elem)
          return elem['value']
        end
      end

      nil
    end

  end
end