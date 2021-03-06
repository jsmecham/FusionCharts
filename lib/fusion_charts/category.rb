require 'rubygems'
require 'builder'
require 'logger'

#
# The FusionCharts module contains the classes used for emitting the XML to
# define graphs and charts to be generated by FusionCharts
#
module FusionCharts

  class Category
    attr_accessor :name, :hoverText, :showName

    # Emit this Category as XML.
    def to_xml     
      result = String.new
      builder = Builder::XmlMarkup.new(:target => result, :indent => 2)
  
      attributes = {}
      instance_variables.each do |iv|
        attributes[iv.split("@")[1]] = normalize instance_variable_get(iv)
      end
      
      builder.tag!("category", attributes)
      
      result
    end
  
    # If value is boolean, return "1" (true) or "0" (false). If value is not boolean, return value unchanged.
    def normalize(value)
      return "1" if value.class == TrueClass
      return "0" if value.class == FalseClass
      return value
    end
  end

end
