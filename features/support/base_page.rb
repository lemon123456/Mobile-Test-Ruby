module LocatorModule

  def findByName(name)
    find_element(:name, "#{name}")
  end

  def findById(id)
    find_element(:id, "#{id}")
  end

  def findByXpath(xpath)
    find_element(:xpath, "#{xpath}")
  end

  def clickByName(name)
    findByName(name).click
  end

  def clickById(id)
    findById(id).click
  end

  def clickByXpath(xpath)
    findByXpath(xpath).click
  end

  def verifyTextNotExist(text)
    raise("Should not find text: #{text}") unless texts(text).empty?
  end

  def verifyTextExist(text)
    raise("Not find text: #{text}") if texts(text).empty?
  end

  def ifTextExist(text)
    if texts(text).empty?
      return false
    else
      return true
    end
  end

  def verifyPromptNotExist(message)
    raise("Should not find text: #{message}") unless waitElement { texts(message).empty? }
  end

  def verifyPromptExist(message)
    raise("Not find text: #{message}") if waitElement { texts(message).empty? }
  end

  def verifyButtonNotExist(button_name)
    raise("Should not find button: #{button_name}") if exists { button(button_name) }
  end

  def verifyButtonExist(button_name)
    raise("Not find button: #{button_name}") unless exists { button(button_name) }
  end

  def waitElement
    timeout = 30
    polling_interval = 0.2
    time_limit = Time.now + timeout
    loop do
      begin
        yield
      rescue Exception => error
      end
      return if error.nil?
      raise error if Time.now >= time_limit
      sleep polling_interval
    end
  end
end

module GestureModule

  def scrollFullScreen(direction)
    screen_width = self.tag("android.widget.LinearLayout").size.width      #1080
    screen_height = self.tag("android.widget.LinearLayout").size.height     #1920
    case direction.downcase
      when "right"
        self.swipe(:start_x => 1, :start_y => 1000, :delta_x => 1000, :delta_y => 1000, :duration => 2000)
      when "left"
        self.swipe(:start_x => 1000, :start_y => 1000, :delta_x => 50, :delta_y => 1000, :duration => 2000)
      when "up"
        self.swipe(:start_x => 0.5*screen_width, :start_y => 0.9*screen_height, :delta_x => 0.5*screen_width, :delta_y => 0.1*screen_height, :duration => 3000)
      when "down"
        self.swipe(:start_x => 0.5*screen_width, :start_y => 0.4*screen_height, :delta_x => 0.5*screen_width, :delta_y => 0.9*screen_height, :duration => 3000)
      else
        puts "Unknown scroll direction."
    end
  end

  def scrollPartScreen(direction)
    screen_width = self.tag("android.widget.LinearLayout").size.width      #768
    screen_height = self.tag("android.widget.LinearLayout").size.height     #1164
    case direction.downcase
      when "right"
        self.swipe(:start_x => 0.1*screen_width, :start_y => 0.5*screen_height, :delta_x => 0.9*screen_width, :delta_y => 0.5*screen_height, :duration => 2000)
      when "left"
        self.swipe(:start_x => 0.9*screen_width, :start_y => 0.5*screen_height, :delta_x => 0.1*screen_width, :delta_y => 0.5*screen_height, :duration => 2000)
      when "up"
        self.swipe(:start_x => 0.5*screen_width, :start_y => 0.7*screen_height, :delta_x => 0.5*screen_width, :delta_y => 0.2*screen_height, :duration => 2000)
      when "down"
        self.swipe(:start_x => 0.5*screen_width, :start_y => 0.4*screen_height, :delta_x => 0.5*screen_width, :delta_y => 0.9*screen_height, :duration => 2000)
      when "little_up"
        self.swipe(:start_x => 0.5*screen_width, :start_y => 0.6*screen_height, :delta_x => 0.5*screen_width, :delta_y => 0.55*screen_height, :duration => 2000)
      else
        puts "Unknown scroll direction."
    end
  end

end

class MyPACDAppPage
  include LocatorModule
  include GestureModule
end


=begin
 Top-left is (0,0)
=end