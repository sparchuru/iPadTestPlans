require File.expand_path(File.dirname(__FILE__) + '/UtilsAll.rb')
class MobileUtility
#=========================================================================================#
#                                                                                         #     
#    FUNCTION: GetElementByStrategy                                                       # 
#                                                                                         #
#    NOTES: This funtion is used to get the element with the given startegy value         #
#           First two parameters are mandatory with parameter 1st being the driver object #
#           and the 2nd being the strategy value to the element                           #
#           wait_time: wait time                              							  #
#           flag_error: flag error                              						  #
#     		display_name: Name of the element                         					  #
#     		is_visible: checks if the element is visible on the screen, when set to true  #
#                               						  else false                	  #
#                                                                                         # 
#    RETURN: return the element with the given startegy value else false                  #
#=========================================================================================#
    ["Xpath","Id","Name"].each do |strategy|
        strat_sym = strategy.downcase.to_sym
        #Find the dynamically created method name below
        define_method("GetElementWith#{strategy}") do |driver_ele=nil, strat_val=nil, wait_time=20, flag_error=true, display_name=nil, is_visible=true|                 
        begin
            Log.Utility("UtilsCommon::GetElementByStrategy -> #{strategy}")
            #return if driver and xpath parameters are not passed
            if driver_ele.nil? or strat_val.nil? then
                Log.Warning "pass in valid arguments"
                return			
            end
        
            #display_name will be used while logging error
            display_name = "Element with #{strategy.to_s} : #{strat_val}" if display_name.nil?
        
            #creating a selenium wait object with the given wait_time 
            wait = Selenium::WebDriver::Wait.new(:timeout => wait_time)
            begin
          	    return_data = wait.until {				
                	driver.find_element(strat_sym, strat_val)
          	    }     
            rescue Exception => e
                if flag_error				
              	    Log.Error("#{display_name} is not found after waiting for #{wait_time} seconds")
            	    Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
          	    end
          	    return false
            end
        
        	#checking the elements visibilty on the screen
        	if is_visible and !return_data.displayed? then
            	if flag_error
            		Log.Error("#{display_name} is not seen on the screen after waiting for #{wait_time} seconds")
            		Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
            		return false
            	end
            	return false
        	end
        	return return_data
        rescue Exception => e
        	Log.Error e
        	return false
     	ensure
        	Log.CloseUtility
     	end
     end
 end
  
#=========================================================================================#
#                                                                                         #     
#    FUNCTION: GetElementsByStrategy                                                      # 
#                                                                                         #
#    NOTES: This funtion is used to get all the elements with the given startegy value    #
#           First two parameters are mandatory with parameter 1st being the driver object #
#           and the 2nd being the strategy value to the element               			  #
#           wait_time: wait time                              							  #
#           flag_error: flag error                              						  #
#     is_visible: checks if the element is visible on the screen, when set to true  	  #
#                               else false                								  #
#     display_name: Name of the element                                                   #
#                                                                                         # 
#    RETURN: return the elements with the given startegy value else false                 #
#=========================================================================================#
  ["Xpath","Id","Name"].each do |strategy|
    strat_sym = strategy.downcase.to_sym
    define_method("GetElementsWith#{strategy}") do |driver_ele=nil, strat_val=nil, wait_time=20, flag_error=true, is_visible=false, display_name=nil|
      begin
        Log.Utility("UtilsCommon::GetElementsByStrategy -> #{strategy}")
        #return if driver and xpath parameters are not passed
        if driver_ele.nil? or strat_val.nil? then
          Log.Warning "pass in valid arguments"
          return      
        end
        
        #display_name will be used while logging error
        display_name = "Elements with #{strategy.to_s} : #{strat_val}" if display_name.nil?
        wait = Selenium::WebDriver::Wait.new(:timeout => wait_time)
        begin       
          return_data = wait.until {
            driver.find_elements(strat_sym, strat_val)
          } 
        rescue Exception => e
          if flag_error
            Log.Error("#{display_name} is not found after waiting for #{wait_time} seconds") 
            Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
          end
          return false
        end
        
        #removing all the elements which are not visible on the screen 
        if is_visible then
          return_data.keep_if{ |ele| ele.displayed? }
          if return_data.empty?
            if flag_error
              Log.Error("#{display_name} is not seen on the screen after waiting for #{wait_time} seconds") 
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")            
            end
            return false
          end
        end
        return return_data
      rescue Exception => e
        Log.Error e
        return false
      ensure
        Log.CloseUtility
      end
    end
  end

#=========================================================================================#
#                                                                                         #     
#    FUNCTION: TapElementByStrategy                                                     # 
#                                                                                         #
#    NOTES: This funtion is used to tap on an element with the given startegy value       #
#           First two parameters are mandatory with parameter 1st being the driver object #
#           and the 2nd being the strategy value to the element               #
#           wait_time: wait time                              #
#           flag_error: flag error                              #
#     scroll_to:  scroll to the element before tapping it                       #
#     display_name: Name of the element                       #
#                                                                                         # 
#    RETURN: return the elements with the given startegy value else false                 #                           #
#=========================================================================================# 
  ["Xpath","Id","Name"].each do |strategy|
    strat_sym = strategy.downcase.to_sym
    define_method("TapElementWith#{strategy}") do |driver_ele=nil, strat_val=nil, wait_time=40, flag_error=true, scroll_to=true, display_name=nil|
      begin
        Log.Utility("UtilsCommon::TapElementByStrategy -> #{strategy}")
        #return if driver and xpath parameters are not passed
        if driver_ele.nil? or strat_val.nil? then
          Log.Warning "pass in valid arguments"
          return      
        end
        
        #display_name will be used while logging error
        display_name = "Element with #{strategy.to_s} : #{strat_val}" if display_name.nil?    
        wait = Selenium::WebDriver::Wait.new(:timeout => wait_time)
        begin
          element_to_tap = wait.until {       
            driver.find_element(strat_sym, strat_val)
          }
          if scroll_to == false
            driver.execute_script "mobile: scrollTo", :element => element_to_tap.ref          
          end
          element_to_tap.click
          return true
        rescue Exception => e
          if flag_error then
            Log.Error "Unable to tap #{display_name}"
            Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
          end
          return false
        end
      rescue Exception => e
        Log.Error e
        return false
      ensure
        Log.CloseUtility
      end
    end   
  end

#=========================================================================================#
#                                                                                         #     
#    FUNCTION: GetValueFromElements                                                     # 
#                                                                                         #
#    NOTES: Use this function to get the value of Watir or selenium object.         #
#                                                     #
#           an element or an array of elements can be passed as parameter         #
#                                               #
#                                                                                         # 
#    RETURN: false if some exception is raised                              #
#        array of values if the parameter is an array                         #
#        value if the parameter is an element                             #
#=========================================================================================# 
  
  def GetValueFromElements(ele = nil)
    begin
      Log.Utility("UtilsMobile::GetValueFromElements")
      if ele == nil
        Log.Error "pass in valid arguments"
        return false
      end
      if ele == false
        Log.Error "false is passed -> Watir element or an elements array is expected"
        return false
      end
      valuesArr = Array.new
      if ele.kind_of?(Array) == true
        elementsArr = ele
        elementsArr.each{ |element|
          valuesArr.push(element.value) 
        }
        return valuesArr
      else
        elementValue = ele.value
        return elementValue
      end
    rescue Exception => e
      Log.Error e
      return false
    ensure
      Log.CloseUtility
    end
  end
#=========================================================================================#
#                                                                                         #     
#    FUNCTION: GetTextFromElements                                                      # 
#                                                                                         #
#    NOTES: Use this function to get the text in Watir or selenium object.                #
#                                                   #
#           an element or an array of elements can be passed as parameter         #
#                                               #
#                                                                                         # 
#    RETURN: false if some exception is raised                              #
#        text array if the parameter is an array                            #
#        text in the element if the parameter is an element                     #
#=========================================================================================#   
  def GetTextFromElements(ele = nil)
    begin
      Log.Utility("UtilsMobile::GetTextFromElements")
      if ele == nil
        Log.Error "pass in valid arguments"
        return false
      end
      if ele == false
        Log.Error "false is passed -> Watir element or an elements array is expected"
        return false
      end
      textArr = Array.new
      if ele.kind_of?(Array) == true
        elementsArr = ele
        elementsArr.each{ |element|
          textArr.push(element.text) 
        }
        return textArr
      else
        elementText = ele.text
        return elementText
      end
    rescue Exception => e
      Log.Error e
      return false
    ensure      
      Log.CloseUtility
    end
  end
#=========================================================================================#
#                                                                                         #     
#    FUNCTION: VerifyGeneralPage                                                          # 
#                                                                                         #
#    NOTES: Use this function to verify the options in Settings page                      #                      
#                                and GENERAL page elements in Settings                    #
#    First parameter is mandatory it is driver object                                     #
#    RETURN: false if an expected element is not present or if some exception is raised   #
#        true if the page has all the expected elements                                   #
#=========================================================================================#
  def VerifyGeneralPage(driverEle = nil)
    begin
        Log.Utility("UtilsMobile::VerifyGeneralPage")
        if driverEle.nil?
            Log.Warning "pass in valid arguments"
            return false
        end 
        # Tapping on Hamburgor    
        if UtilsMobile.TapElementWithXpath(driverEle, HomePagePO::HamBurger_xpath) == false
            Log.Error("Hamburger is not tapped")  
            Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
            return false
         end 
         
        # Tapping on Settings button                        HamburgerMenuBtns_xpath
        
        settingsXpath= HomePagePO.ReplaceString(HomePagePO::HamburgerMenuBtns_xpath, "SETTINGS")  
        if UtilsMobile.TapElementWithXpath(driverEle, settingsXpath) == false
            Log.Error("Settings button not tapped in the home page.")
            Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
            return false
        end
        
        settingsArrExp = ["GENERAL","PORTFOLIOS & WATCH LISTS","MARKETS","NEWS ALERTS","QUOTE ALERTS","NEWS","IN-HOUSE"]
        for btn in settingsArrExp
            btnXpath =  SettingsPagePO.ReplaceString(SettingsPagePO::GeneralXpath, btn)     
            if UtilsMobile.GetElementWithXpath(driverEle, btnXpath) == false
                Log.Error(" #{btn} not found after click operation on setting button under hamburger.")
                Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                return false
            end  
        end   
         
        gnrlXpath= SettingsPagePO.ReplaceString(SettingsPagePO::GeneralXpath, "GENERAL")  
        if UtilsMobile.TapElementWithXpath(driverEle, gnrlXpath) == false
            Log.Error("GENERAL in the settings page is not tapped")
            Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
            return false
        end  
           
        logOutBtn = SettingsPagePO.ReplaceString(SettingsPagePO::ButtontypeXpath, "Logout")   
        if UtilsMobile.GetElementWithXpath(driverEle, logOutBtn) == false
            Log.Error("Logout button not found in general page")
            Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
            return false
        end
        generalPageLabels = ["USERNAME","SERIAL NUMBER","VERSION","Dynamic Decimals","Auto Download Drive Content on Cellular","APPLICATION THEME","UP / DOWN COLORS","NEED HELP?","Contact FactSet Support","What's New Tutorial","Legal Info","Launch Home Page Wizard"]
        for txt in generalPageLabels
            gnrlXpath= SettingsPagePO.ReplaceString(SettingsPagePO::CommonXpath, txt)  
            if UtilsMobile.GetElementWithXpath(driverEle, gnrlXpath,20,false) == false
                
                #oPage.execute_script 'mobile: scroll', direction: 'left'
                driverEle.execute_script 'mobile: scroll', direction: 'down'
                gnrlXpath= SettingsPagePO.ReplaceString(SettingsPagePO::CommonXpath, txt)  
                if UtilsMobile.GetElementWithXpath(driverEle, gnrlXpath) == false   
                    Log.Error("#{txt} not found in the general page");
                    Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                    return false
                end
          end  
        end      
        return true
    rescue Exception => e
        Log.Error e  
        return false
    ensure
        Log.CloseUtility
    end
  end
  
#===========================================================================================#
#                                                                                           #     
#    FUNCTION: SetText                                                                      #  
#                                                                                           #
#    NOTES: Use this function to set text to a text field object.                           #
#                                                                                           #
#First two parameters are mandatory with                                                    #
#1st being the Xpath to the element                                                         #
#2nd is the text which we want to set to the text field                                     #
#3rd parameter wait time                                                                    #  
#4th parameter is boolean when set true sends the keys rather than setting the text directly#                             
#    RETURN: false if some exception is raised                                              #
#        array of values if the parameter is an array                                       # 
#        value if the parameter is an element                                               #
#===========================================================================================# 
  def SetText(xpath = nil, textToBeSent = nil, wait_time = 20, sendKeys = false)
    begin
      Log.Utility("UtilsMobile::SetText")
      if xpath.nil? || textToBeSent.nil?
        Log.Warning "pass in valid arguments"
        return false
      end
      
      textField = UtilsMobile.GetElementWithXpath(driver, xpath, wait_time)
      if textField == false
        return false
      end
      
      if sendKeys == true
        textField.click
        textField.clear
        Log.Message("enter text")
        textField.send_keys textToBeSent
        Log.Message("entered")
      else
        driver.execute_script("au.getElement('#{textField.ref}').setValue('#{textToBeSent}');")
      end 
      return true
    rescue Exception => e
      Log.Error e
      return false
    ensure
      Log.CloseUtility      
    end
  end

#=========================================================================================#     
#    FUNCTION: SetStage                                                                 # 
#                                                                                         #
#    NOTES: Use this function to set Stage to lima override field.                  #
#                                                       #
# First two parameters are mandatory with parameter 1st being the driver object,          #
# 2nd being the stage which we want to set to the lima override field                     #               
#    RETURN: false if some exception is raised                              #
#        true if lima override is set and Staging is toggled                          #
#=========================================================================================#
  def SetStage(driverEle = nil, stage = Configuration.stage, deviceName=Configuration.deviceName)
    begin
          Log.Utility("UtilsMobile::SetStage")
          if driverEle.nil?
            Log.Warning "pass in valid arguments"
            return false
          end 
          
          # Tapping on Hamburgor   
           
          if UtilsMobile.TapElementWithXpath(driverEle, HomePagePO::HamBurger_xpath) == false
              Log.Error("Hamburger is not tapped")  
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
              return false
           end 
           
          # Tapping on Settings button
          settingsXpath= HomePagePO.ReplaceString(HomePagePO::HamburgerMenuBtns_xpath, 'SETTINGS')  
          if UtilsMobile.TapElementWithXpath(driverEle, settingsXpath) == false
              Log.Error("Settings button not tapped in the home page.")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
              return false
          end
          
          # tap on inhouse button
          inhouseXpath= SettingsPagePO.ReplaceString(SettingsPagePO::GeneralXpath, "IN-HOUSE") 
          if UtilsMobile.TapElementWithXpath(driverEle, inhouseXpath) == false
              Log.Error("In-House button not tapped in the settings page.")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
              return false
          end
          
          if ["wireless_devel", "wireless_qa", ""].include?(stage)
              possibleOptionsHash = {"wireless_devel" => "devel", "wireless_qa" => "qa", "" => "live"}
          else
            Log.Error("Stage is not valid")
            Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
            return false
          end 
          
          
          overrideField = UtilsMobile.GetElementWithXpath(driverEle, SettingsPagePO::LimaOverRideFieldXpath) 
          if overrideField == false
              Log.Error("Lima Override field not found in the in-house page.")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
              return false
          end
      
          if deviceName.include? "iPhone"
                  setOverride = overrideField.send_keys(stage)
          else
                  setOverride = UtilsMobile.SetText(SettingsPagePO::LimaOverRideFieldXpath, stage)
          end
          
          btnApplyChangesXpath = SettingsPagePO.ReplaceString(SettingsPagePO::ButtontypeXpath, "Apply Changes") 
          tableNameXpath =  SettingsPagePO.ReplaceString(SettingsPagePO::CommonXpath, "tablename")
         # alertOkXpath = "//UIAApplication[1]/UIAWindow/UIAAlert[1]//UIAButton[@label='OK']" 
          
          if setOverride != nil | false
              if UtilsMobile.TapElementWithXpath(driverEle, btnApplyChangesXpath)
                   sleep 10
                   tableNameElement = UtilsMobile.GetElementWithXpath(driverEle, tableNameXpath)
                    tableName = UtilsMobile.GetValueFromElements(tableNameElement)
   
          else
              Log.Error("Error occurred when entering  #{stage} in lima override field")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
              return false
          end
          
          
          if tableName == possibleOptionsHash[stage]
              if tableName != "live"
              if UtilsMobile.TapElementWithXpath(driverEle, SettingsPagePO::UseStagingSwitchXpath)
                btnLogoutXpath = SettingsPagePO.ReplaceString(SettingsPagePO::ButtontypeXpath, "Log Out") 
                if UtilsMobile.TapElementWithXpath(driverEle, btnLogoutXpath)
                  useStagingText = SettingsPagePO.ReplaceString(SettingsPagePO::CommonXpath, "Using Staging") 
                  if UtilsMobile.GetElementWithXpath(driverEle, useStagingText, 20, false)  #"//UIAApplication[1]/UIAWindow/UIAStaticText[@value='Using Staging']" 
                    if UtilsMobile.Login(driverEle)
                      if UtilsMobile.TapElementWithXpath(driverEle, HomePagePO::HamBurger_xpath)
                        if UtilsMobile.TapElementWithXpath(driverEle, settingsXpath)
                          if UtilsMobile.TapElementWithXpath(driverEle, inhouseXpath)
                            tableNameElement = UtilsMobile.GetElementWithXpath(driverEle, tableNameXpath)
                            tableName = UtilsMobile.GetValueFromElements(tableNameElement)
                            if tableName == possibleOptionsHash[stage]
                              staggingSwitch = UtilsMobile.GetElementWithXpath(driverEle, SettingsPagePO::UseStagingSwitchXpath)
                              if UtilsMobile.GetValueFromElements(staggingSwitch) == true
                                return true
                              else
                                Log.Error("Staging switch is not turned on")
                                Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                                return false
                              end
                            else
                              Log.Error("Table name is set to #{tableName} where as #{possibleOptionsHash[stage]} is expected")
                              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                              return false
                            end
                          else
                            Log.Error("'inhouse' is not tapped after re-login")
                            Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                            return false
                          end
                        else
                          Log.Error("'Settings' is not tapped after re-login")
                          Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                          return false
                        end
                      else
                        Log.Error("'Hamburger' is not tapped after re-login")  
                        Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                        return false
                      end
                    else
                      Log.Error("Login failed in staging mode")
                      Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                      return false
                    end
                  else
                    Log.Error("Login screen did not appear using staging")
                    Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                    return false
                  end
                else
                  log.Error("Unable to tap on logout button")
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                  return false
                end
              else
                Log.Error("Unable to tap the staging switch")
                Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                return false
              end
              else
                return true
            end
          else
            Log.Error("when #{stage} is given in lima override table name didn't change to #{possibleOptionsHash[stage]} it rather shows #{tableName} ")
            Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
            return false
          end 
      
       end
    rescue Exception => e
      Log.Error e  
      Log.Message e.backtrace
      return false
    ensure
      Log.CloseUtility
    end
  end
#=========================================================================================#
#                                                                                         #     
#    FUNCTION: Login                                                                      # 
#                                                                                         #
#    NOTES: Use this function to login to FactSet Application                     #
#                                                       #
# First two parameters are mandatory with parameter 1st being the driver object,          #
# 2nd being the email pass to the email field                       #  
#           3rd parameter bFlag                                 #
#    RETURN: false if some exception is raised                              #
#        true if login to the app and find hamburger element              #
#=========================================================================================#
  def Login(driverEle = nil, email = Configuration.email, bFlag = true, deviceName=Configuration.deviceName)
    begin
          Log.Utility("UtilsMobile::Login")
          if driverEle.nil?
            Log.Warning "pass in valid arguments"
            return false
          end 
          userName = Configuration.username
          serialNumber = Configuration.serial_number
          password = Configuration.password
          #test step needs a change
          #verifying if the Notification Preferences alert shows up . If yes dismiss the alert.
          alertNotificationXpath = "//*[contains(@label,'Notifications')]"
          #alertNotificationXpath = "//*[contains(@id,'"FactSet" Would Like to send')]"
          
          alertNotification = UtilsMobile.GetElementWithXpath(driverEle, alertNotificationXpath, 10, false)
          if alertNotification != false
            #dontAllowAlert = "//UIAApplication[1]/UIAWindow/UIAAlert[contains(@label,'Notifications')]/UIACollectionView/UIACollectionCell[@label=\"Don't Allow\"]"
            #dontAllowButtonAlert = "//UIAApplication[1]/UIAWindow/UIAAlert[contains(@label,'Notifications')]/UIACollectionView//UIAButton[contains(@label,'Allow')]"
            dontAllowButtonAlert = "//*[contains(@label,'Allow')]"
            UtilsMobile.TapElementWithXpath(driverEle, dontAllowButtonAlert)
            #verify if tap is performed and then check if alert is dissmised
            alertNotification = UtilsMobile.GetElementWithXpath(driverEle, alertNotificationXpath, 20, false)
            #checking if the alert still exists
            if alertNotification != false
              Log.Error "The alert for FactSet notifications preferences alert could not be dismissed"
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
              return false
            end
          end
          
          emailFieldXpath = HomePagePO.ReplaceString(HomePagePO::InputFieldXpath, "email or factset.net ID")   # InputFieldXpath
          requestPasscodeBtnXpath =  HomePagePO.ReplaceString(HomePagePO::ButtontypeXpath, "Request passcode") 
          emailTextSent = UtilsMobile.SetText(emailFieldXpath, email,20,true)
          if emailTextSent != false
            requestPasscodeBtnTapped = UtilsMobile.TapElementWithXpath(driverEle,requestPasscodeBtnXpath)
            if requestPasscodeBtnTapped
              wrongEmailAlertXpath = HomePagePO::WrngEmailAlertXpath 
              wrongEmailAlertOkXpath = HomePagePO.ReplaceString(HomePagePO::ButtontypeXpath, "OK")
              wrongEmailAlert = UtilsMobile.GetElementWithXpath(driverEle, wrongEmailAlertXpath, 10, false)
              if wrongEmailAlert != false
                UtilsMobile.TapElementWithXpath(driverEle, wrongEmailAlertOkXpath)
                if bFlag 
                  Log.Error "Wrong Email Entered in the login page"
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                  return false
                end
                return false
              else
                
                serialNumberFieldXpath = HomePagePO::SerlNumFildXpath    
                serialNoAlertOkBtnXpath = HomePagePO.ReplaceString(HomePagePO::ButtontypeXpath, "OK") 
                serialNumberTextSent = UtilsMobile.SetText(serialNumberFieldXpath, serialNumber.to_s, 20,true)
                if serialNumberTextSent
                  current_date_time = DateTime.now
                  UtilsMobile.TapElementWithXpath(driverEle, serialNoAlertOkBtnXpath)
                  #if for tap element
                  passCode = UtilsMobile.GetPasscode(userName, password, current_date_time, 300)
                  if passCode == false or passCode == nil
                    Log.Error("Pass code not fetched from the email #{Configuration.email}")
                    Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                    return false
                  end
                  passCodeFieldXpath =  HomePagePO.ReplaceString(HomePagePO::InputFieldXpath, "passcode")
                  passCodeSent = UtilsMobile.SetText(passCodeFieldXpath, passCode,20,true)
                  if passCodeSent != false
                    loginButtonXpath = HomePagePO.ReplaceString(HomePagePO::ButtontypeXpath, "Log in")
                    UtilsMobile.TapElementWithXpath(driverEle, loginButtonXpath)
                    #Handle the new enhamcement in 2.36 
                    appVersion = UtilsCommon.GetValueFromGroupIdHTML("Build")
                    if (!appVersion.include?"2.35")
                        array = ['Setup your password to access FactSet','Please re-enter your password']
                        for element in array
                            passwordfieldXpath =   HomePagePO.ReplaceString(HomePagePO::PwdFildXpath, element)  
                            passwordSent = UtilsMobile.SetText(passwordfieldXpath, "123456",20,true)
                            if passwordSent == false
                                Log.Error("Password not entered in to security field #{element}")
                                Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture");
                                return false
                            end
                            browser =  UtilsMobile.GetElementWithXpath(driverEle, passwordfieldXpath, 20, false)
                            browser.send_keys :enter 
                        end
                        if deviceName.include?("iPhone")
                            enabletouchXpath =  HomePagePO.ReplaceString(HomePagePO::StaticTxtFldXpath,"Enable Touch ID") 
                            if (UtilsMobile.GetElementWithXpath(driverEle, enabletouchXpath, 20, false)!= false)
                                cancelBtn = HomePagePO.ReplaceString(HomePagePO::ButtontypeXpath, "Cancel")
                                UtilsMobile.TapElementWithXpath(driverEle,cancelBtn)
                            else
                                Log.Error("Enable Touch id Pop up not found")
                                Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture");
                                return false
                            end
                        end
                    end
                    
      			         #if for tap element
                   
                    #considering hamburger being visible as successful login
                    hamburger = UtilsMobile.GetElementWithXpath(driverEle, HomePagePO::HamBurger_xpath, 10, false)
                    if hamburger == false
                      #check if app upgrade nitification exits and handle it
                      promptExists = UtilsMobile.GetElementWithXpath(driverEle, HomePagePO::AppUpdtePromt, 10, false)          
                      if promptExists != false
                        if UtilsMobile.TapElementWithXpath(driverEle, HomePagePO::UpdtePrmptRmdLtrBtn)
                          UtilsMobile.TapElementWithXpath(driverEle, HomePagePO::UpdtePrmptOkBtn)
                        end
                      end
       
                  if UtilsMobile.GetElementWithXpath(driverEle, HomePagePO::HamBurger_xpath, 10, false) != false
                    return true
                  end
                      
      				    # Handle the popup of What's new in factset .. version
				    
                
                    xpath_newfactset1 =  HomePagePO.ReplaceString(HomePagePO::PageIndicatorXpath,"page 1 of 3")
           
                    xpath_newfactset2 =  HomePagePO.ReplaceString(HomePagePO::PageIndicatorXpath,"page 1 of 2")  
         
                newfactset = UtilsMobile.GetElementWithXpath(driverEle, xpath_newfactset1, 10, false) 
                if newfactset == false
                	newfactset = UtilsMobile.GetElementWithXpath(driverEle, xpath_newfactset2, 10, false)
                end
                if newfactset != false 
                    xpath_closebutton = HomePagePO.ReplaceString(HomePagePO::ButtontypeXpath,"Close") #"//UIAButton[@label='Close']"
                    #driverEle.execute_script 'mobile: scroll', direction: 'right'
                    closebutton = UtilsMobile.SwipePagesForElement(driverEle, xpath_closebutton, 20)
                    if closebutton != false
                        closebutton = UtilsMobile.GetElementWithXpath(driverEle, xpath_closebutton, 20)
                        if closebutton != false
                           closebutton.click
                        else
                           Log.Error("Test step #{stepId}: delete tile is not found.")
                           Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                           return false    
                        end
                    else
                        Log.Error("Test step #{stepId}: delete tile is not found.")
                        Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                        return false 
                    end
                end
                #check if tutorial exists
                #in 2.16v tutorial name is not equal in both devices
                if deviceName.include?("iPad")
                    xpath = HomePagePO.ReplaceString(HomePagePO::TutorialXpath,"Tutorial") 
                    tutorialExists = UtilsMobile.GetElementWithXpath(driverEle, xpath, 20, false)
                else   
                    xpath = HomePagePO.ReplaceString(HomePagePO::TutorialXpath,"iPhone")                 
                    tutorialExists = UtilsMobile.GetElementWithXpath(driverEle, xpath, 10, false)
                end
                
                if tutorialExists != false
                  #updated with swipePagesForElement utility to compatible to all versions
                  btnCloseXpath = HomePagePO.ReplaceString(HomePagePO::ButtontypeXpath,"Close") #"//UIAApplication[1]/UIAWindow/UIAButton[@label='Close']"
                  if UtilsMobile.SwipePagesForElement(driverEle, btnCloseXpath)
                    UtilsMobile.TapElementWithXpath(driverEle, btnCloseXpath) 
                    if UtilsMobile.GetElementWithXpath(driverEle, HomePagePO::HamBurger_xpath, 20, false) != false
                      return true
                    end 
                  else 
                      Log.Error("Swipe didn't performed properly at tutorial page")
                      Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                      return false
                    end
                end
                #check if customize home screen window exists
                customizeHomeExists = UtilsMobile.GetElementWithXpath(driverEle,HomePagePO::CustmizXpath, 10, false)
                if customizeHomeExists
                  skipXpath = HomePagePO.ReplaceString(HomePagePO::ButtontypeXpath,"Skip") 
                  UtilsMobile.TapElementWithXpath(driverEle, skipXpath)
                  if UtilsMobile.GetElementWithXpath(driverEle, HomePagePO::HamBurger_xpath, 20, false) != false
                    return true
                  end
                end
                
                #hamburgerXpath = "//UIAApplication[1]/UIAWindow/UIANavigationBar/UIAButton[@label='Navigation list']"
                hamburger = UtilsMobile.GetElementWithXpath(driverEle, HomePagePO::HamBurger_xpath, 20, true, "Hamburger")
                #hamburger = driver.find_element(:name, 'Navigation list') 
                if hamburger == false
                  #the could not login error should be in else block
                  Log.Error("Could not login to FactSet wireless") 
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")                 
                  return false
                else
                  return true
                end               
              else
                return true
              end
            else
              return false
            end
          else
            return false
          end
        end
      else
        Log.Error "An error occurred when tapping Request Passcode Button"
        Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
        return false
      end
    else
      Log.Error "Email address is not entered in the email Text Field"
      Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
      return false
    end
    rescue Exception => e
      Log.Error e  
      Log.Message e.backtrace
      return false
    ensure
      Log.CloseUtility
    end
  end
#=========================================================================================#
#                                                                                         #     
#    FUNCTION: GetPasscode                                                              # 
#                                                                                         #
#    NOTES: Use this function to get the passcode from email to login to FactSet App      #
#                                                       #
# First three parameters are mandatory with parameter 1st being the username ,            #
# 2nd being the password, 3rd parameter being the after is a time after which we expect   #
#       password is sent to the email                             #
#    RETURN: false if some exception is raised                              #
#        true if login to the app and find hamburger element              #
#=========================================================================================#
  def GetPasscode(user, password, after = nil, wait_time = 60, interval = 3)
    begin
      Log.Utility("UtilsMobile::GetPasscode")
      if after.nil? then
        Log.Warning("Enter valid arguments")
        return false
      end
      limitTime = Time.now + wait_time
      passcode = nil
      last_date_time = nil
      while Time.now < limitTime do
	    searchSubject = "#{Configuration.serial_number}"
        passcode_emails = UtilsCommon.FetchEmails(after, nil,searchSubject,nil, Configuration.username, Configuration.password)
        if !passcode_emails then
          next
        end
        for item in passcode_emails do
          extract = ExtractPasscode(item.subject)  
          if extract != nil and extract != false
            if last_date_time == nil
              last_date_time = item.date_time_sent
              passcode = extract
            else
              if item.date_time_sent > last_date_time then
                 passcode = extract
              end
            end
          end
        end
        if passcode != nil 
          return passcode
        end
        sleep interval
      end   
    rescue Exception => e
      Log.Error e
      return false
    ensure
      Log.CloseUtility
    end
  end
#=========================================================================================#
#                                                                                         #     
#    FUNCTION: VerifyArray                                                                # 
#                                                                                         #
#    NOTES: Use this function to verify array elements                            #
#                                                       #
# First three parameters are mandatory with parameter 1st being the driver object,        #
# 2nd being the xpath, 3rd being the array of Expected Strings/Values           #  
#           4th parameter byAttr can take 2 values "value"/"text" "value being default    #
#     5th parameter verifyOrder to check the order of elements            #
#     6th parameter wait_time                               #
#    RETURN: false if some exception is raised                              #
#        true if ArrExp is equal to arrActual                             #
#=========================================================================================#  
  def VerifyArray(driverEle=nil, xpath=nil, arrExp=nil, byAttr = "value", verifyOrder = false, wait_time = 60)
    begin
      Log.Utility("UtilsMobile::VerifyArray")
      if driverEle.nil? || xpath.nil? || arrExp.nil? then
        Log.Warning("Enter valid arguments")
      end
      byAttr = byAttr.downcase
      if byAttr != "value" && byAttr != "text"
        Log.Warning("value or text is expected as fourth parameter of VerifyArray method")
      end
      arrActual = Array.new
      eleArr = UtilsMobile.GetElementsWithXpath(driverEle, xpath, wait_time, true)
      if eleArr != false
        if byAttr == "text"
          eleArr.each do |x|
            arrActual.push(x.text)
          end
        else
          eleArr.each do |x|
            arrActual.push(x.value)
          end
        end
        y = arrExp - arrActual
        if y.empty? == true
          #if verifyOrder is set to true
          if verifyOrder == true
            #commonarr will have arrActual INTERSECTION arrExp
            commonArr = arrActual - (arrActual - arrExp)
            if commonArr == arrExp
              return true
            else
              Log.Error("order of the elements is not same as expected, rather in the order #{commonArr}")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
              return false
            end
          else
            return true
          end
        else
          Log.Error("#{y} are not found in the page")
          Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
          return false
        end
      else
        Log.Error("Xpath: #{xpath} not found")
        Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
        return false
      end
    rescue Exception => e
       Log.Error e
       Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
       return false
    ensure 
       Log.CloseUtility
    end
  end

#=========================================================================================#
#                                                                                         #     
#    FUNCTION: ExtractPasscode                                                          # 
#                                                                                         #
#    NOTES: Use this function to extract passcode from mail server to login FactSet App   #
#                                                       #
# one mandatory parameter is used as subject of mail for Eg: FactSet Passcode             #
#    RETURN: nil if some exception is raised                              #
#        passcode if fetches using regular Expression                   #
#=========================================================================================#   
  def ExtractPasscode(s)
    re = /FactSet passcode "([0-9]*)" for /
    match_data = re.match(s)
    if match_data then
      passcode = match_data.captures.last
    else
      return nil
    end
  end

#=========================================================================================#
#                                                                                         #     
#    FUNCTION: Logout                                                                 # 
#                                                                                         #
#    NOTES: Use this function to logout from FactSet Application                #
#                                                       #
# one mandatory parameter is used being driver object                     #
#    RETURN: false if some exception is raised                              #
#        true if logout from the application                      #
#=========================================================================================#
  
  def Logout(driverEle = nil)
    if(UtilsMobile.TapElementWithXpath(driverEle, HomePagePO::HamBurger_xpath))      
      settingsXpath= HomePagePO.ReplaceString(HomePagePO::HamburgerMenuBtns_xpath, "SETTINGS")
      if UtilsMobile.TapElementWithXpath(driverEle, settingsXpath, 20)
        
        generalXpath =  SettingsPagePO.ReplaceString(SettingsPagePO::GeneralXpath, "GENERAL")
        if UtilsMobile.TapElementWithXpath(driverEle, generalXpath)
          lgOutBtn = SettingsPagePO.ReplaceString(SettingsPagePO::ButtontypeXpath, "Logout")
          if UtilsMobile.TapElementWithXpath(driverEle, lgOutBtn, 20) == false
              Log.Error("'Logout' button is not tapped")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
              return false
            else
              emailFieldXpath = HomePagePO.ReplaceString(HomePagePO::InputFieldXpath, "email or factset.net ID")
              if UtilsMobile.GetElementWithXpath(driverEle, emailFieldXpath) == false
                  Log.Error("Could not LogOut from FactSet Application")
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                  return false
              end
          end
        else
          Log.Error("Test step #{stepId}  'General' button is not tapped")
          Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
          return false
        end
      else
        Log.Error("'Settings' is not tapped")
        Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
        return false
      end
    else
      Log.Error("'Hamburger' is not tapped")  
      Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
      return false
    end
  end
#=========================================================================================#
#                                                                                         #     
#    FUNCTION: SelectFromHomeMenu                                                     # 
#                                                                                         #
#    NOTES: Use this function to select an option from Home Menu                #
#                                                       #
# First two parameters are mandatory 1st is being driver object and             #
#                     2nd is being menu item to tap           #
#    RETURN: false if some exception is raised                              #
#        true if any item in menu list tapped                     #
#=========================================================================================#

  def SelectFromHomeMenu(driverEle, menu)
    begin
      Log.Utility("UtilsMobile::SelectFromHomeMenu")
      if driverEle.nil? || menu.nil? then
        Log.Warning("Pass in valid arguments")
      end
      menu = menu.upcase
      
      arrAvailableOptions = ["HOME", "MARKETS", "NEWS", "PORTFOLIOS", "WATCH LISTS", "FACTSET DRIVE", "ALERTS", "CHARTING", "PORTFOLIO DASHBOARD", "IN-HOUSE URLS", "SETTINGS"]
      if arrAvailableOptions.include? menu == false
        Log.Error("#{menu} does not exist in HOME MENU")
        Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
        return false
      end
      
      if menu == "SETTINGS" 
        xpath = HomePagePO.ReplaceString(HomePagePO::HamburgerMenuBtns_xpath, "SETTINGS") 
      else
        xpath = HomePagePO.ReplaceString(HomePagePO::HamburgerMenuTxtBtns_xpath, menu)
      end 
      if UtilsMobile.TapElementWithXpath(driverEle, HomePagePO::HamBurger_xpath)
        if UtilsMobile.TapElementWithXpath(driverEle, xpath)
          return true
        else
          Log.Error("Test step #{stepId}:  #{menu} is not tapped")
          Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
          return false
        end
      else
        Log.Error("Test step #{stepId}  'Hamburger' is not tapped")
        Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
        return false
      end
    rescue Exception => e
      Log.Error e
      return false
    ensure
      Log.CloseUtility
    end
  end

#=========================================================================================#
#                                                                                         #     
#    FUNCTION: SwipePagesForElement                                                   # 
#                                                                                         #
#    NOTES: Use this function to swipe when there are page indicators and search      #
#                             for needed data           #
#                                                       #
# First two parameters are mandatory 1st is being driver object and             #
#                     2nd is being xpath for page indicator     #
#           3rd parameter is wait_time                      #
#    RETURN: false if some exception is raised                              #
#        true if swiping and finding the data is success                #
#=========================================================================================#

  def SwipePagesForElement(driverEle, xpath, wait_time=20)
        begin
            Log.Utility("UtilsMobile::SwipePagesForElement")
            if driverEle.nil? || xpath.nil? then
                Log.Warning("Pass in valid arguments")
            end
            pageIndicator = UtilsMobile.GetElementWithXpath(driverEle, HomePagePO::PageIndicatorValXpath)
            pIndctrValue = GetValueFromElements(pageIndicator)
          if pIndctrValue != false
            pageCount = (pIndctrValue[-1..-1]).to_i 
                (0..pageCount-1).each { |x|
                  driverEle.execute_script 'mobile: scroll', direction: 'right'
				          #pageIndicator.send_keys x
				  
				  if UtilsMobile.GetElementWithXpath(driverEle, xpath, wait_time, false) != false
                return true
            end
               
                }         
            else
                return false
            end
        rescue Exception => e
            Log.Error e
            return false
        ensure
            Log.CloseUtility
        end
    end
  
#=========================================================================================#
#                                                                                         #     
#    FUNCTION: VeifyInHousePage                                                       # 
#                                                                                         #
#    NOTES: Use this function to verify the IN-HOUSE page in Settings             #
#                                                         #
#                                                       #
#    First parameter is mandatory it is driver object                     #
#    RETURN: false if an expected element is not present or if some exception is raised   #
#        true if the page has all the expected elements                 #
#=========================================================================================#

  def VeifyInHousePage(driverEle)
        begin
            Log.Utility("UtilsMobile::VeifyInHousePage")
            if driverEle.nil?
                Log.Warning("Pass in valid arguments")
            end
      
            # Tap Hamburger
      if UtilsMobile.TapElementWithXpath(driverEle, HomePagePO::HamBurger_xpath)
        settingsXpath = HomePagePO.ReplaceString(HomePagePO::HamburgerMenuBtns_xpath, "SETTINGS")
        if UtilsMobile.TapElementWithXpath(driverEle, settingsXpath)
          inhouseXpath = SettingsPagePO.ReplaceString(SettingsPagePO::GeneralXpath, "IN-HOUSE")
          if UtilsMobile.TapElementWithXpath(driverEle, inhouseXpath)
            #fetching all the text and button name from the inhouse settings page
              inhouseExpValArr = ["Lima Override:", "Current Table:", "Use Staging:","PA debug mode: ","Apply Changes", "Morph", "key chain", "running requests"]
			      for ele in inhouseExpValArr
			          xpath = SettingsPagePO.ReplaceString(SettingsPagePO::InhousePageElementsXpath,ele)
			          if UtilsMobile.GetElementWithXpath(driverEle, xpath) == false
			              Log.Error("#{ele} not found in the in-house page")  
                    Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                    return false  
			          end
			      end
			      
          else
            Log.Error("'In-House' button is not tapped")  
            Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
            return false
          end
        else
          Log.Error("'Settings' button is not tapped")  
          Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
          return false
        end
      else
          Log.Error("'Hamburger' is not tapped")
          Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
          return false      
      end
        rescue Exception => e
            Log.Error e
            return false
        ensure
            Log.CloseUtility
        end
    end
#====================================================================================================================================#
#                                                                                                                #     
#    FUNCTION: ScrollElementToVisibilty                                                                          # 
#                                                                                                                #
#    NOTES: Use this function to scroll an element to visible screen if it is hidden                             #
# PRAMETERS:                                                                           #
#    First parameter is the xpath of the window or screen which needs to be scrolled for the element to be seen.               #                                  #
#    Second parameter is the xpath of the element you are looking for.(note that this element needs to have a scrollable ancestor)   #
#    RETURN: false if the any of no element exist with the given xpaths or if some exception is raised                 #
#        Watir web element which is scrolled into the view.                                      #
#====================================================================================================================================#

  def ScrollElementToVisibilty(wndwXpath = nil, eleXpath = nil)
        begin
            Log.Utility("UtilsMobile::ScrollElementToVisibilty")
            if wndwXpath.nil? || eleXpath.nil?
                Log.Warning("Pass in valid arguments")
            end
			#getting the parent element reference
			wndw = UtilsMobile.GetElementWithXpath(driver, wndwXpath)
			
			#getting the element reference which needs to be scrolled to visibility
			ele = UtilsMobile.GetElementWithXpath(driver, eleXpath,20,true,"element",false)
			                                     # driver, eleXpath,20,true,nil, true
			#driver_ele=nil, strat_val=nil, wait_time=20, flag_error=true, display_name=nil, is_visible=true|
			#ele =driver.find_element(:xpath => eleXpath)
			wndw.execute_script 'mobile: scrollTo', :element => ele.ref
			browser = Watir::Browser.new driver			
			return browser.element(element: ele)
=begin			
			Log.Utility("UtilsMobile::ScrollElementToVisibilty")
            if wndwXpath.nil? || eleXpath.nil?
                Log.Warning("Pass in valid arguments")
            end
            #getting the parent element reference
            #wndw = UtilsMobile.GetElementWithXpath(driver, wndwXpath)
            wndw = driver.element(:xpath => wndwXpath)
            #getting the element reference which needs to be scrolled to visibility
            ele = UtilsMobile.GetElementWithXpath(driver, eleXpath,20,true,"element",false)
            wndw.execute_script 'mobile: scrollTo', :element => ele.ref
            browser = Watir::Browser.new driver     
            return browser.element(element: ele)
            
            #getting the parent element reference
            #wndw = UtilsMobile.GetElementWithXpath(driver, wndwXpath)
            wndw = driver.element(:xpath => wndwXpath)
            #getting the element reference which needs to be scrolled to visibility
            #ele = UtilsMobile.GetElementWithXpath(driver, eleXpath,30)
            ele = driver.find_element(:xpath,wndwXpath)
            #driver.scrollTo(ele)
            #driver.execute_script 'mobile: scrollTo', :element => ele.ref
            driver.execute_script 'mobile: scroll',:direction =>'up', :element => ele.ref
            browser = Watir::Browser.new driver     
            return browser.element(element: ele)
=end            
        rescue Exception => e
            Log.Error e
            return false
        ensure
            Log.CloseUtility
        end
    end
#===================================================================================================#
# FUNCTION: TakeSimulatorScreenshot                                                                 #
# DESCRIPTION: Use this function to take the screenshot of the simulator                #
# Parameters: driverEle - Driver object                                                             #
#             strLocation - Path of Location to save the screenshot                                 #
#             imageName - Name of the image to save                                                 #
#===================================================================================================# 

  def TakeSimulatorScreenshot(driverEle = nil, imageName = nil, strLocation = nil)
    begin
      Log.Utility("UtilsMobile::TakeSimulatorScreenshot")
          
      # Check if save location is passed?
      if strLocation.nil? || strLocation == ""
        strLocation = File.expand_path(File.dirname( __FILE__)).split("Utils")[0]+"Images/"
      end
          
      # Set the image name as current time if it is not passed
      if imageName.nil? ||imageName == ""
        @time = Time.new
        imageName = @time.year.to_s+@time.month.to_s+@time.day.to_s+@time.hour.to_s+@time.min.to_s+@time.sec.to_s + ".png"
      else
        # Save the image with ".png" extension
        if imageName.to_s.split(".")[1].nil? || imageName.to_s.split(".")[1].downcase != "png"
          imageName = imageName + ".png"
        end
      end
           
      # Check if the location directory exists?
      if !Dir.exists?(strLocation)
        FileUtils.mkdir_p(strLocation)
      end
          
      # Append trailing back slashes to save location
      if (strLocation =~ /.*\/$/) == nil
        strLocation += "\/"
      end 
          
      strImagePath = strLocation + imageName
      # Save screenshot to file
      #the below commented line also works where driverEle is a Watir driver
      #driverEle.screenshot.save strImagePath
      begin
        tryCount ||= 3
        screenshot strImagePath
      rescue Exception => e
        sleep 2
        if !(tryCount -= 1).zero? then
          retry 
        else 
          Log.Message e
          return false
        end
      end
      return strImagePath
    rescue Exception => e
      Log.Error e
      return false
    ensure
      Log.CloseUtility()
    end
  end
#=============================================================================================#
#                                                                                             #     
#    FUNCTION: WaitForAppLoad                                                                 # 
#                                                                                             #
#    NOTES: Use this function when you would like to wait for the application to load       #
#           First parameter is mandatory being the driver object                #
#                                                                                             # 
#    RETURN: true if the loading symbol on the top left corner disappears in given wait time  #      
#=============================================================================================#
  def WaitForAppLoad(driverEle = nil, wait_time = 20)
    begin  
      Log.Utility("UtilsMobile::WaitForAppLoad")  
      if driver.nil? then
        Log.Warning "pass in valid arguments"
        return false
      end
      loadingComplete = UtilsCommon.WaitUntilElementDisappear(driverEle,HomePagePO::AppLoadingXpath, wait_time, "App Loading Indicator")
      if loadingComplete == true
        return true
      else
        return false
      end
    rescue Exception => e
      Log.Message e
      return false
    ensure  
          Log.CloseUtility
    end   
  end 
#=============================================================================================#
#                                                                                             #     
#    FUNCTION: SetContext                                                                     # 
#                                                                                             #
#    NOTES: Use this function when you would like set application to a specific context     #
#     First parameter can be 'NATIVE' or 'WEB'                      #
#     Second parameter is customFlag ,default to false. setting it to true will enable  #
#     the function to accept a cutom context other than 'NATIVE' and 'WEB'          #       
#                                                                                             # 
#    RETURN: false if there is some exception and Watir webdriver object of the app       #
#      in the respective context after setting the context                  #      
#=============================================================================================#
  def SetContext(context = nil, customFlag = false)
    begin  
      Log.Utility("UtilsMobile::SetContext")  
      if context.nil? then
        Log.Warning "pass in valid arguments"
        return false
      end
      if customFlag
        driver.appium_device.set_context context
        return Watir::Browser.new driver
      else 
        context = context.upcase
        if context != 'NATIVE' and context != 'WEB' then
          Log.Warning "pass in valid context which can be 'NATIVE' or 'WEB'"
          return false
        end
        if context == 'NATIVE' then
          driver.appium_device.set_context "NATIVE_APP"
          return Watir::Browser.new driver
        end
        if context == 'WEB' then
          driver.appium_device.set_context driver.appium_device.available_contexts.last
          return Watir::Browser.new driver
        end
      end
      return false
    rescue Exception => e
      Log.Error e
      return false
    ensure  
          Log.CloseUtility
    end   
  end
#=============================================================================================#
#                                                                                             #     
#    FUNCTION: SwipeCurrentPage                                                               # 
#                                                                                             #
#    NOTES: Use this function when you would like to swipe current page once          #
#     First parameter is Watir Driver                           #
#     Second parameter can be a string "rtl"(right-to-left) or "ltr(left-to-right)"     #       
#                                                                                             # 
#    RETURN: false if there is some exception and true if there is no exception         #      
#=============================================================================================#
  def SwipeCurrentPage(driverEle = nil, direction = "rtl")
    begin  
      Log.Utility("UtilsMobile::SwipeCurrentPage")  
      if driverEle.nil? then
        Log.Warning "pass in valid arguments"
        return false
      end
      if direction == "rtl"     
        driverEle.execute_script 'mobile: scroll', direction: 'right'
      elsif  direction == "ltr"
        driverEle.execute_script 'mobile: scroll', direction: 'left'
      else
        Log.Warning "pass in valid arguments"
        return false
      end       
=begin      
      pageIndicator = UtilsMobile.GetElementWithXpath(driverEle, HomePagePO::PageIndicatorValXpath)
      
            #this will have page indicator value as '<pageNO> of <Total No Of pages>' ex : '1 of 6'
      pIndctrValue = GetValueFromElements(pageIndicator)
          if pIndctrValue != false
        #stripping page no out of page indicator string
            pageNo = (pIndctrValue[-6..-6]).to_i
        
        #verifying if the current page is first page
        if pageNo.zero? and directionVar == -1 then 
          Log.Error("First page cant be swiped from left-to-right")
          Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
          return false
        end
        
        #verifying if the current page is last page
        if pageNo ==  pIndctrValue[-1..-1] and directionVar == +1 then 
          Log.Error("Last page cant be swiped from right-to-left")
          Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
          return false
        end
        
        swipeToIndex = pageNo + directionVar - 1
        pageIndicator = UtilsMobile.GetElementWithXpath(driverEle, HomePagePO::PageIndicatorValXpath)
            pageIndicator.send_keys swipeToIndex        
            else
                return false
            end
=end            
      return true
    rescue Exception => e
      Log.Error e
      return false
    ensure
          Log.CloseUtility
    end   
  end
  
#=============================================================================================#
#                                                                                             #     
#    FUNCTION: SwipeElementWithXpath                                                          # 
#                                                                                             #
#    NOTES: Use this function when you would like to swipe current page once          #
#     First parameter is Watir Driver                           #
#     Second parameter can be a string "rtl"(right-to-left) or "ltr(left-to-right)"     #       
#                                                                                             # 
#    RETURN: false if there is some exception and true if there is no exception         #      
#=============================================================================================#
  def SwipeElementWithXpath(driverEle = nil, eleXpath = nil, direction = "rtl", duration = 0.5)
    begin  
      Log.Utility("UtilsMobile::SwipeElementWithXpath")  
      if driverEle.nil? or eleXpath.nil? then
        Log.Warning "pass in valid arguments"
        return false
      end
      
      ele = UtilsMobile.GetElementWithXpath(driverEle, eleXpath)
      #getting width and height of the element for further use
      eleWidth = ele.size.width     
      eleHeight = ele.size.height
      leftXCord = ele.location.x
      #adding width to left x cordinate to get the x cordinate of the right edge of elemnt
      rightXCord = leftXCord + eleWidth
      #getting mid point ((x,y) is x1+x2/2 , y1+y2/2) (x,y) is the mid point 
      middleXCord = (leftXCord + rightXCord)/2
      topYCord = ele.location.y
      bottomYCord = topYCord + eleHeight
      middleYCord = (topYCord + bottomYCord)/2
      
      if direction == "rtl" 
        scriptToExecute = "target.dragFromToForDuration({x:'#{rightXCord - 5}', y:'#{middleYCord}'}, {x:'#{middleXCord}', y:'#{middleYCord}'}, '#{duration}');"
      elsif direction == "ltr"
        scriptToExecute = "target.dragFromToForDuration({x:'#{leftXCord + 5}', y:'#{middleYCord}'}, {x:'#{middleXCord}', y:'#{middleYCord}'}, '#{duration}');"
      else
        Log.Error("direction parameter can be 'rtl' or 'ltr' but '#{direction}' is passed")
        return false
      end
      
      driver.execute_script scriptToExecute     
      return true
    rescue Exception => e
      Log.Error e
      return false
    ensure  
          Log.CloseUtility
    end   
  end
#=============================================================================================#
#                                                                                             #     
#    FUNCTION: DragAndDropElementWithXpath                                                    # 
#                                                                                             #
#    NOTES: Use this function when you would like to swipe current page once          #
#     First parameter is Watir Driver                           #
#     Second parameter can be a string "rtl"(right-to-left) or "ltr(left-to-right)"     #       
#                                                                                             # 
#    RETURN: false if there is some exception and true if there is no exception         #      
#=============================================================================================#
  def DragAndDropElementWithXpath(driverEle = nil, eleXpath = nil, toPosition = nil, duration = 0.5)
    begin  
      Log.Utility("UtilsMobile::DragAndDropElementWithXpath")  
      if driverEle.nil? or eleXpath.nil? or toPosition.nil? then
        Log.Warning "pass in valid arguments"
        return false
      end
      
      ele = UtilsMobile.GetElementWithXpath(driverEle, eleXpath)
      #getting location of the element
      fromXCord = ele.location.x
      fromYCord = ele.location.y
      #verifying if cordinates are passed
      if /^\( {0,}\d, {0,}\d\)$/.match(toPosition).nil? == true
        #getting the location of element which is in the destination location
        destEle = driver.find_element :xpath, toPosition
        #getting location of the element
        toXCord = destEle.location.x
        toYCord = destEle.location.y        
      else
        toXCord = toPosition[1].to_i
        toYCord = toPosition[-2].to_i
      end     
        scriptToExecute = "target.dragFromToForDuration({x:'#{fromXCord}', y:'#{fromYCord}'}, {x:'#{toXCord}', y:'#{toYCord}'}, '#{duration}');"      
        driver.execute_script scriptToExecute     
      return true
    rescue Exception => e
      Log.Error e
      return false
    ensure  
          Log.CloseUtility
    end   
  end
end

UtilsMobile = MobileUtility.new