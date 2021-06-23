require "employee"
require "byebug"

class Startup

    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries  #title => salary
        @employees = [] #arr of employee instances
    end

    def valid_title?(title)
        return true if @salaries.keys.include?(title)
        false
    end

    def >(comp)
        self.funding > comp.funding
    end

    def hire(name, title)
        if !valid_title?(title)
            raise "title is invalid"
        else
            @employees << Employee.new(name, title) 
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        if @funding > @salaries[employee.title]
            employee.pay(@salaries[employee.title])
            @funding -= @salaries[employee.title]
        else
            raise "not enough funding"
        end
    end

    def payday
        @employees.each do |employee|
            pay_employee(employee)
        end
    end

    def average_salary
        current_salaries = []
        @employees.each do |employee|
            current_salaries << @salaries[employee.title]
        end
        current_salaries.sum / current_salaries.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(target)
        @funding += target.funding
        target.salaries.each do |title, salary|
            @salaries[title] = salary if !@salaries.keys.include?(title)
        end
        target.employees.each do |employee|
            @employees << employee
        end
        target.close
    end

end
