require 'test/unit'
require 'fusion_charts'

class TestFusionCharts < Test::Unit::TestCase
  @@COLORS = %w{ red orange yellow green blue indigo violet }

  def setup
    @@CATEGORY_NUMBER = 1
    @@DATAPOINT_NUMBER = 1
    @@TRENDLINE_NUMBER = 1
  end

  def test_attribute_aliases
    puts
    puts "----------------"
    puts "test_attribute_aliases"
    puts "----------------"
    chart = FusionCharts::Base.new
  end
  
  def test_category
    puts
    puts "----------------"
    puts "category output"
    puts "----------------"
    puts category.to_xml
  end
  
  def test_categories
    puts
    puts "----------------"
    puts "categories output"
    puts "----------------"
    categories(3).each do |cat| puts cat.to_xml end
  end
  
  def test_combination_chart
    cc = FusionCharts::CombinationChart.new
    cc.animated = true
    cc.categories = categories(3)
    cc.dataSets = datasets(3)
    puts
    puts "----------------"
    puts "combination_chart output"
    puts "----------------"
    puts cc.to_xml
  end
  
  def test_datapoint
    puts
    puts "----------------"
    puts "datapoint output"
    puts "----------------"
    puts datapoint.to_xml
  end
  
  def test_datapoints
    puts
    puts "----------------"
    puts "datapoints output"
    puts "----------------"
    datapoints(3).each do |dp| puts dp.to_xml end
  end

  def test_multi_series_chart
    msc = FusionCharts::MultiSeriesChart.new
    msc.animated = true
    msc.categories = categories(3)
    msc.dataSets = datasets(3)
    msc.trendLines = trendlines(3)
    puts
    puts "----------------"
    puts "multi_series_chart output"
    puts "----------------"
    puts msc.to_xml
  end
  
  def test_dataset
    puts
    puts "----------------"
    puts "dataset output"
    puts "----------------"
    puts dataset.to_xml
  end
  
  def test_simple
    chart = FusionCharts::Base.new
    chart.animated = true
    assert_equal("<graph animation=\"1\">\n</graph>\n", chart.to_xml)
  end
  
  def test_single_series_chart
    ssc = FusionCharts::SingleSeriesChart.new
    ssc.dataPoints = []
    ssc.trendLines = []
    ssc.xAxisName = "Product Class"
    ssc.yAxisName = "Downloads"
    ssc.decimalPrecision = 0
    ssc.formatNumber = true
    ssc.showNames = false
    ssc.showValues = false
    ssc.showHoverCaption = true
    
    dp1 = FusionCharts::DataPoint.new
    dp1.name = "Foo"
    dp1.value = 10
    dp1.color = "E86C00"
    ssc.dataPoints << dp1
    
    puts
    puts "----------------"
    puts "single_series_live output"
    puts "----------------"
    puts ssc.to_xml
  end
  
  def test_single_series_live
    ssc = FusionCharts::SingleSeriesChart.new
    ssc.animated = true
    ssc.dataPoints = datapoints(3)
    ssc.trendLines = trendlines(3)
    puts
    puts "----------------"
    puts "single_series_chart output"
    puts "----------------"
    puts ssc.to_xml
  end
  
  def test_trendline
    puts
    puts "----------------"
    puts "trendline output"
    puts "----------------"
    puts trendline.to_xml
  end
  
  def test_trendlines
    puts
    puts "----------------"
    puts "trendlines output"
    puts "----------------"
    trendlines(3).each do |tl| puts tl.to_xml end
  end
  
  private
  
  def category
    cat = FusionCharts::Category.new
    cat.name = "Category #{@@CATEGORY_NUMBER}"
    cat.hoverText = "hovering #{@@CATEGORY_NUMBER}"
    cat.showName = even? @@CATEGORY_NUMBER
    @@CATEGORY_NUMBER += 1
    
    cat
  end
  
  def categories(number)
    result = []
    number.times do
      result << category
    end
    result
  end
    
  def datapoint
    dp = FusionCharts::DataPoint.new
    dp.name = "Point #{@@DATAPOINT_NUMBER}"
    dp.value = @@DATAPOINT_NUMBER * 10
    dp.color = @@COLORS[@@DATAPOINT_NUMBER-1 % @@COLORS.size]
    dp.hoverText = "hovering #{@@DATAPOINT_NUMBER}..."
    dp.showName = even? @@DATAPOINT_NUMBER
    @@DATAPOINT_NUMBER += 1
    
    dp 
  end
  
  def datapoints(number)
    result = []
    number.times do
      result << datapoint
    end
    result
  end
  
  def dataset
    dp1 = datapoint
    dp2 = datapoint
    
    ds = FusionCharts::DataSet.new
    ds.alpha = 1
    ds.anchorAlpha = 2
    ds.dataPoints = [dp1, dp2]
    
    ds
  end
  
  def datasets(number)
    result = []
    number.times do
      result << dataset
    end
    result
  end
  
  def trendline
    trendline = FusionCharts::TrendLine.new
    trendline.startValue = 2.0 * @@TRENDLINE_NUMBER
    trendline.endValue = 3.0 * @@TRENDLINE_NUMBER
    trendline.color = @@COLORS[@@TRENDLINE_NUMBER-1 % @@COLORS.size]
    trendline.displayValue = "Display value #{@@TRENDLINE_NUMBER}"
    trendline.thickness = 1
    trendline.trendZone = even? @@TRENDLINE_NUMBER
    trendline.showOnTop = !(even? @@TRENDLINE_NUMBER)
    trendline.alpha = 25
    @@TRENDLINE_NUMBER += 1
    
    trendline
  end
  
  def trendlines(number)
    result = []
    number.times do
      result << trendline
    end
    result
  end
  
  def even?(number)
    number % 2 == 0 ? true : false
  end
end