# Core libraries
require "securerandom"

class Chart
  include Inesita::Component

  def initialize(options)
    @width = options[:width]
    @height = options[:height]
    @options = options[:options]
    @id = ::SecureRandom.uuid
  end

  def render
    div style: "position: relative; #{@height == nil ? "" : "height:#@height"}; #{@width == nil ? "" : "width:#@width"};" do
      canvas height: @height, id: @id, hook: hook(:render_chart), unhook: unhook(:remove_chart)
    end
  end

  private

  def remove_chart
    node = `document.getElementById(#@id)`
    if `#{node} !== null` && not(router.current_url?("/"))
      parent = `#{node}.parentNode`
      `#{node}.remove()`
      `#{parent}.style = null`
    end
  end

  def render_chart
    node = `document.getElementById(#@id)`
    if `#{node} === null`
      `setTimeout(function() { #{self.render_chart} }, 1)`
    else
      @chart = `new Chart(#{node}.getContext('2d'), #{@options.to_n})`
    end
  end
end
