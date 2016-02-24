require 'mechanize'
require_relative 'course'
require_relative 'checker'

module CourseChecker
  
  # Checks courses in a cart
  class CartChecker < CourseChecker::Checker

    def get_courses
      @courses = []
      i = 1
      while not((cur_course = @page.search("//*[@id=\"trSSR_REGFORM_VW$0_row#{i}\"]")).empty?) do
        if(cur_course.at("//*[@id=\"P_SELECT$#{i-1}\"]"))
          @courses << Course.new(
            cur_course.at("//*[@id=\"P_CLASS_NAME$#{i-1}\"]/text()[2]").to_s,
            cur_course.at("//*[@id=\"P_CLASS_NAME$#{i-1}\"]/text()[1]").to_s,
            cur_course.at("//*[@id=\"DERIVED_REGFRM1_SSR_INSTR_LONG$#{i-1}\"]/text()").to_s,
            cur_course.at("//*[@id=\"win0divDERIVED_REGFRM1_SSR_STATUS_LONG$#{i-1}\"]/div/img")['alt'].downcase.to_sym)
        end
        i += 1
      end
    end

    def spire_request
      @browser.get('https://spire.umass.edu/psc/heproda/EMPLOYEE/HRMS/c/SA_LEARNER_SERVICES_2.SSR_SSENRL_CART.GBL?Page=SSR_SSENRL_CART&Action=A&ExactKeys=Y&TargetFrameName=None')
    end

  end
end