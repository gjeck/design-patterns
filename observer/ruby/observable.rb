# Observable module to be used as a mixin. The ruby stlib 
# has all this functionality in 'observer' but we are doing
# this here for practice

module ObservableSubject

    def initialize
        @observers = []
    end

    def add_observer(*observer)
        observer.each {|o| @observers << o}
    end

    def remove_observer(*observer)
        observer.each {|o| @observers.delete(o)}
    end

    def notify_observers
        @observers.each do |observer|
            observer.update(self)
        end
    end

end

class Employee

    include ObservableSubject

    attr_reader :name, :title, :id
    attr_reader :salary

    def initialize(name, title, salary)
        super()
        @name = name
        @title = title
        @salary = salary
        @id = "#{name}:#{title}:#{salary}".to_sym
    end

    def salary=(new_salary)
        @salary = new_salary
        notify_observers()
    end

end

class Payroll

    attr_reader :expenses

    def initialize(expenses, employee_salary_store)
        @expenses = expenses
        @employee_store = employee_salary_store
    end

    def update(changed_employee)
        @employee_store[changed_employee.id] = changed_employee.salary
    end

    def total_expenses
        return @employee_store.values.inject(:+)
    end

    def avg_salary
        return -1 if @employee_store.length == 0
        return total_expenses / @employee_store.length
    end

end

class Emailer

    attr_reader :message_queue

    def initialize(message_queue, employee_email_store)
        @message_queue = message_queue
        @employee_store = employee_email_store
    end

    def update(changed_employee)
        email_address = @employee_store[changed_employee.id]
        @message_queue << email_address
    end

end


