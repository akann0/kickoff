require 'selenium-webdriver'

module PlayersHelper
    def get_position (url)
        p "gettin position"
        # open the website
        driver = Selenium::WebDriver.for :chrome
        driver.navigate.to url
        # find the position
        #possibly_position = driver.find_elements(:xpath, "//div[@class='hjyjyy']")
        possibly_position = driver.find_elements(:class, "hjyjyy")
        # print the size of the position array
        for position in possibly_position
            puts position.text
            choices = ["G", "M", "D", "F"]
            # IF the position is in the choices array
            if choices.include? position.text
                return position.text
            end
        end
        # close the website
        driver.quit
    end
end
