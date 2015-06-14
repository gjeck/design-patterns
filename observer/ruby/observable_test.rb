require 'test/unit'
require_relative 'observable'

class ObservableTest < Test::Unit::TestCase

    def setup
        @gob = Employee.new('Gob', 'Magician', 1000)
        @bary = Employee.new('Barry', 'Lawyer', 3500)
        @homer = Employee.new('Homer', 'Nuclear Technician', 3000)

        @employee_salary_store = {
            @gob.id => @gob.salary,
            @bary.id => @bary.salary,
            @homer.id => @homer.salary,
        }

        @payroll = Payroll.new(
            @employee_salary_store.values.inject(:+),
            @employee_salary_store
        )

        @employee_email_store = {
            @gob.id => "#{@gob.name.downcase}@vandelay.com",
            @bary.id => "#{@bary.name.downcase}@vandelay.com",
            @homer.id => "#{@homer.name.downcase}@vandelay.com",
        }

        @emailer = Emailer.new([], @employee_email_store)
    end

    def test_payroll_update
        @gob.add_observer(@payroll)
        @bary.add_observer(@payroll)
        @homer.add_observer(@payroll)

        @bary.salary=1200
        @homer.salary=2100
        @gob.salary=0

        assert_equal(3300, @payroll.total_expenses)
        assert_equal(1100, @payroll.avg_salary)
    end

    def test_payroll_remove
        @gob.add_observer(@payroll)
        @bary.add_observer(@payroll)
        @homer.add_observer(@payroll)

        @bary.salary=1200
        @homer.salary=2100
        @gob.salary=0

        @gob.remove_observer(@payroll)
        @gob.salary=800

        assert_equal(3300, @payroll.total_expenses)
        assert_equal(1100, @payroll.avg_salary)
    end

    def test_payroll_email_update
        @gob.add_observer(@payroll, @emailer)
        @bary.add_observer(@payroll, @emailer)
        @homer.add_observer(@payroll, @emailer)

        @bary.salary=1500
        @homer.salary=2000
        @gob.salary=0

        message_queue = [
            'barry@vandelay.com',
            'homer@vandelay.com',
            'gob@vandelay.com',
        ]

        assert_equal(3500, @payroll.total_expenses)
        assert_equal(message_queue, @emailer.message_queue)
    end

end

