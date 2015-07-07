module GuiRuby
    class Button
        attr_accessor :command

        def initialize(&block)
            @command = block
        end

        def pressed
            @command.call if @command
        end
    end

    class Checkbox
        attr_accessor :command
        attr_reader :checked

        def initialize(checked=false, &block)
            @checked = checked
            @command = block
        end

        def pressed
            @checked = !@checked
            @command.call if @command
        end
    end

    class Slider
        attr_accessor :command
        attr_reader :value

        def initialize(value=0, &block)
            @value = value
            @command = block
        end

        def set_value(val)
            @value = val
            changed
        end

        def changed
            @command.call if @command
        end
    end
end
