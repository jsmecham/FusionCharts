require 'rubygems'
require 'builder'
require 'logger'

#
# The FusionCharts module contains the classes used for emitting the XML to
# define graphs and charts to be generated by FusionCharts
#
module FusionCharts

  # A chart that includes a combination of Categories and DataSets
  class CombinationChart < Base
    attr_accessor :categories, :dataSets
    
    def initialize
      categories = []
      dataSets = []
    end
    
    # Emit this CombinationChart as XML.
    def to_xml
      inner = String.new
      inner_builder = Builder::XmlMarkup.new(:target => inner, :indent => 2)
  
      # create the XML for the inner "categories" element(s)
      inner_builder.tag!("categories") do
        categories.each do |category|
          inner_builder << category.to_xml
        end
      end
      
      # create the XML for the inner "dataset" element(s)
      inner_builder.tag!("dataset") do
        dataSets.each do |dataset|
          inner_builder << dataset.to_xml
        end
      end
      
      # create the XML for this chart, including attributes defined in the Base chart type
      result = super(nil, inner)
      
      result
    end    
  end
  
end
