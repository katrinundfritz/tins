module Tins
  module TimeDummy
    def self.included(modul)
      class << modul
        alias really_new new

        remove_method :now rescue nil
        remove_method :new rescue nil

        attr_writer :dummy

        def dummy(value = nil)
          if value.nil?
            @dummy
          else
            begin
              old_dummy = @dummy
              @dummy = value
              yield
            ensure
              @dummy = old_dummy
            end
          end
        end

        def new
          if dummy
            dummy.dup
          else
            really_new
          end
        end

        alias now new
      end
      super
    end
  end
end

require 'tins/alias'
