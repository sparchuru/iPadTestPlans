# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/../Utils/UtilsAll.rb")
require File.expand_path(File.dirname(__FILE__) + "/../PageObjects/AllPageObjects.rb")
def RuniPhoneSetupWizard8()
  begin
    Log.TestScript("iPhoneSetupWizard8.rb")
    Log.TestCase(128328, "iPhoneSetupWizard8")
    get_driver(Configuration.capabilities, Configuration.server_url) 
    oPage = Watir::Browser.new driver

############################################################################################################
# NOTE: Here We don't have log in test step id's. So i gave zeros as test step id's 
  stepId = "000000,000000,000000"
  Log.TestStep(stepId, "Login")     
      begin
        if UtilsMobile.Login(oPage) == false
          Log.Error("Test step #{stepId}  Login is not successful")
          Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
          return false
        end
      rescue Exception => e
        Log.Error e
        Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")       
        return false
      ensure
        Log.CloseTestStep  
      end    
        
################################### Test Step ##############################################################   
    stepId = 000000
    Log.TestStep(stepId, "In-House page")     
      begin
        if UtilsMobile.VeifyInHousePage(oPage) == true
          inHouseSuccessFlag = true
        end
      rescue Exception => e
        Log.Error e
        Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")       
      ensure
        Log.CloseTestStep
      end
################################### Test Step ##############################################################
    stepId = 000000
    Log.TestStep(stepId, "Table")     
      begin
      if UtilsMobile.SetStage(oPage) == false
        Log.Error("Test step #{stepId} Could not log into correct environment as stage was not set") 
        Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
        return false
      end
      rescue Exception => e
        Log.Error e
        Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")       
        return false
      ensure
        Log.CloseTestStep
      end
   
################################### Test Step  #############################################################
    stepId = 621713
    Log.TestStep(stepId, "Launch Home Page Wizard")
      begin
          if UtilsGeneralSettings.LaunchHomepageSetupWizard(oPage) == false
              return false
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################### Test Step  #############################################################
    stepId = 621714
    Log.TestStep(stepId, "Setup Portfolios or Watch Lists")
      begin
          #Tap anywhere on this page
          if UtilsMobile.TapElementWithXpath(oPage,SettingsPagePO::NavigationtileXpath,20,true,true,"Tilenav button") == false
              return false
          end
          #Verify the first question "Would you like to set up your Portfolios or Watch Lists? "
          keyword = "Would you like to set up your Portfolios or Watch lists?"
          question_xpath = CommonObjects.ReplaceString(CommonObjects::ContainsLabel_xpath,keyword)
          question =UtilsMobile.GetElementWithXpath(oPage,question_xpath,20, false)
          if question == false
              Log.Error("Test step #{stepId}:The question #{keyword} is not found in the page.")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
              return false
          end
          # Verify the Yes, No and Skip button appeared or not
          array = ["YES","NO","Skip"]
          for i in array
              keyword = i
              element_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
              element = UtilsMobile.GetElementWithXpath(oPage,element_xpath,20, false)
              if element == false
                  Log.Error("Test step #{stepId}: #{i} button not found in the page.")
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
                  return false
              end
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################### Test Step  #############################################################
    stepId = 621715
    Log.TestStep(stepId, "Yes - Portfolios/watch Lists")
      begin
          #Tap on the Yes button
          keyword = 'YES'
          yesbutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          yesbutton = UtilsMobile.TapElementWithXpath(oPage,yesbutton_xpath,20,true,true,"yes button ")
          if yesbutton == false
              return false
          end
          #Verify the "Add Portfolio/Watch list" dialog window will appear 
          if UtilsGeneralSettings.VerifyAddPortfolioWatchlistWnd(oPage) == false
            return false
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################### Test Step  #############################################################
    stepId = 621716
    Log.TestStep(stepId, "Select Portflios and Watchlists")
      begin
          #SELECT THE THREE WATCHLIST AND PORTFOLIOS
          selectedHash =  UtilsGeneralSettings.SelectPortfoliosAndWatchlists(oPage, 2, 2)
          if selectedHash != false 
              arr1 = selectedHash["portfolios"]
              arr2 = selectedHash["watchlists"]
          else
              return false
          end
          #verify if the expected text exists on the screen
          arrExp = ["4 portfolios / watch lists have been set up.", "Redo", "Would you like to see today’s events for your portfolios and watch lists?"]
          for i in arrExp
              keyword = i
              question_xpath = CommonObjects.ReplaceString(CommonObjects::ContainsLabel_xpath,keyword)
              question =UtilsMobile.GetElementWithXpath(oPage,question_xpath,20, false)
              if question == false
                  Log.Error("Test step #{stepId}: #{i} - is not found in the page.")
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
                  return false
              end
          end
          # Verify the Yes, No and Skip button appeared or not
          array = ["YES","NO","Skip"]
          for i in array
              keyword = i
              element_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
              element = UtilsMobile.GetElementWithXpath(oPage,element_xpath,20, false)
              if element == false
                  Log.Error("Test step #{stepId}: #{i} button not found in the page.")
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
                  return false
              end
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################ Test Step  #############################################################
    stepId = 621699
    Log.TestStep(stepId, "Favorites")
      begin
          #Tap on the NO button
          keyword = 'NO'
          nobutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          if UtilsMobile.TapElementWithXpath(oPage,nobutton_xpath,20,true,true,"no button ") == false
              return false
          end
          #Verify the first question "Would you like to set up your Portfolios or Watch Lists? "
          keyword ="Would you like to see today’s performance for your Favorites?"
          question_xpath = CommonObjects.ReplaceString(CommonObjects::ContainsLabel_xpath,keyword)
          question =UtilsMobile.GetElementWithXpath(oPage,question_xpath,20, false)
          if question == false
              Log.Error("Test step #{stepId}:The question #{keyword} is not found in the page")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
              return false
          end
          # Verify the Yes, No and Skip button appeared or not
          array = ["YES","NO","Skip"]
          for i in array
              keyword = i
              element_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
              element = UtilsMobile.GetElementWithXpath(oPage,element_xpath,20, false)
              if element == false
                  Log.Error("Test step #{stepId}: #{i} button not found in the page.")
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
                  return false
              end
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################ Test Step  #############################################################
    stepId = 621700
    Log.TestStep(stepId, "No - Today's performance")
      begin
          #Tap on the NO button
          keyword = 'NO'
          nobutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          if UtilsMobile.TapElementWithXpath(oPage,nobutton_xpath,20,true,true,"no button ") == false
              return false
          end
          #Verify the question "Would you like to receive up-to-date info today's top stories?" 
          keyword ="Would you like to receive up-to-date info on today’s top stories?"
          question_xpath = CommonObjects.ReplaceString(CommonObjects::ContainsLabel_xpath,keyword)
          question =UtilsMobile.GetElementWithXpath(oPage,question_xpath,20, false)
          if question == false
              Log.Error("Test step #{stepId}:The question #{keyword}is not found in the page")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
              return false
          end
          # Verify the Yes, No and Skip button appeared or not
          array = ["YES","NO","Skip"]
          for i in array
              keyword = i
              element_xpath= CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
              element = UtilsMobile.GetElementWithXpath(oPage,element_xpath,20, false)
              if element == false
                  Log.Error("Test step #{stepId}: #{i} button not found in the page.")
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
                  return false
              end
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################ Test Step  #############################################################
    stepId = 621701
    Log.TestStep(stepId, "No FactSet Drive")
      begin
          #Tap on the NO button
          keyword = 'NO'
          nobutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          if UtilsMobile.TapElementWithXpath(oPage,nobutton_xpath,20,true,true,"no button ") == false
              return false
          end
          arrExp = ["Would you like to enable FactSet Drive?","Drive allows you to bookmark audio calls, news stories, research reports, transcripts, and filings to read later or while offline."]
          for i in arrExp
              keyword = i
              question_xpath = CommonObjects.ReplaceString(CommonObjects::ContainsLabel_xpath,keyword)
              question =UtilsMobile.GetElementWithXpath(oPage,question_xpath,20, false)
              if question == false
                  Log.Error("Test step #{stepId}:question/message -  #{i} not found in the page")
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
                  return false
              end
          end
          # Verify the Yes, No and Skip button appeared or not
          array = ["YES","NO","Skip"]
          for i in array
              keyword = i
              element_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
              element = UtilsMobile.GetElementWithXpath(oPage,element_xpath,20, false)
              if element == false
                  Log.Error("Test step #{stepId}: #{i} button not found in the page.")
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
                  return false
              end
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################ Test Step  #############################################################
    stepId = 621702
    Log.TestStep(stepId, "High line No Color")
      begin
          #Swipe from the left to right
          oPage.execute_script 'mobile: scroll', direction: 'left'
          #Verify the question "Would you like to receive up-to-date info today's top stories?" 
          keyword ="Would you like to receive up-to-date info on today’s top stories?"
          question_xpath = CommonObjects.ReplaceString(CommonObjects::ContainsLabel_xpath,keyword)
          question =UtilsMobile.GetElementWithXpath(oPage,question_xpath,20, false)
          if question == false
              Log.Error("Test step #{stepId}:The question #{keyword}is not found in the page")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
              return false
          end
          # Verify the "No" button is high lining in blue color for the page/question "Would you like to receive up-to-date info on today's top stories?
          nobtninbluecolor_xpath = GeneralPagePO.Replace(GeneralPagePO::Xpath_btnInBluClr,"NO")
          nobtninbluecolor = UtilsMobile.GetElementWithXpath(oPage,nobtninbluecolor_xpath,20, false)
          if nobtninbluecolor == false
              Log.Error("Test step #{stepId}: 'NO' button is not high lining in blue color.")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
              return false
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################ Test Step  #############################################################
    stepId = 621703
    Log.TestStep(stepId, "high-line No color")
      begin
          #Swipe from left to the right again.
          oPage.execute_script 'mobile: scroll', direction: 'left'
          #Verify the first question "Would you like to set up your Portfolios or Watch Lists? "
          keyword ="Would you like to see today’s performance for your Favorites?"
          question_xpath = CommonObjects.ReplaceString(CommonObjects::ContainsLabel_xpath,keyword)
          question =UtilsMobile.GetElementWithXpath(oPage,question_xpath,20, false)
          if question == false
              Log.Error("Test step #{stepId}:The question #{keyword} is not found in the page")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
              return false
          end
          #Verify user will see the "No" button is high lining in the ligh blue color on the question or page "Would you like to see today's performacnce for your Favorites?
          nobtninbluecolor_xpath = GeneralPagePO.Replace(GeneralPagePO::Xpath_btnInBluClr,"NO")
          nobtninbluecolor = UtilsMobile.GetElementWithXpath(oPage,nobtninbluecolor_xpath,20, false)
          if nobtninbluecolor == false
              Log.Error("Test step #{stepId}: 'NO' button is not high lining in blue color.")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
              return false
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################ Test Step  #############################################################
    stepId = 621704
    Log.TestStep(stepId, "No - light blue color")
      begin
          #Swipe from the left to right on the page one more time
          oPage.execute_script 'mobile: scroll', direction: 'left'
          #verify if the expected text exists on the screen
          arrExp = ["4 portfolios / watch lists have been set up.", "Redo", "Would you like to see today’s events for your portfolios and watch lists?"]
          for i in arrExp
              keyword = i
              question_xpath = CommonObjects.ReplaceString(CommonObjects::ContainsLabel_xpath,keyword)
              question =UtilsMobile.GetElementWithXpath(oPage,question_xpath,20, false)
              if question == false
                  Log.Error("Test step #{stepId}: #{i} - is not found in the page.")
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
                  return false
              end
          end
          #Verify user will see the "No" button is high lining in the ligh blue color on the question or page "4 Porfolios/watch lists have been setup,Redo.
          nobtninbluecolor_xpath = GeneralPagePO.Replace(GeneralPagePO::Xpath_btnInBluClr,"NO")
          nobtninbluecolor = UtilsMobile.GetElementWithXpath(oPage,nobtninbluecolor_xpath,20, false)
          if nobtninbluecolor == false
              Log.Error("Test step #{stepId}: 'NO' button is not high lining in blue color.")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
              return false
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################ Test Step  #############################################################
    stepId = 621705
    Log.TestStep(stepId, "No - high-line color")
      begin
          #Tap on the "Yes" button
          keyword = 'YES'
          yesbutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          if UtilsMobile.TapElementWithXpath(oPage,yesbutton_xpath,20,true,true,"yes button ") == false
              return false
          end
          #Verify the first question "Would you like to set up your Portfolios or Watch Lists? "
          keyword ="Would you like to see today’s performance for your Favorites?"
          question_xpath = CommonObjects.ReplaceString(CommonObjects::ContainsLabel_xpath,keyword)
          question =UtilsMobile.GetElementWithXpath(oPage,question_xpath,20, false)
          if question == false
              Log.Error("Test step #{stepId}:The question #{keyword} is not found in the page")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
              return false
          end
          #Verify user will see the "No" button is high lining in the ligh blue color on the question or page "Would you like to see today's performacnce for your Favorites?
          nobtninbluecolor_xpath = GeneralPagePO.Replace(GeneralPagePO::Xpath_btnInBluClr,"NO")
          nobtninbluecolor = UtilsMobile.GetElementWithXpath(oPage,nobtninbluecolor_xpath,20, false)
          if nobtninbluecolor == false
              Log.Error("Test step #{stepId}: 'NO' button is not high lining in blue color.")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
              return false
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################ Test Step  #############################################################
    stepId = 621717
    Log.TestStep(stepId, "No - high-line color")
      begin
          #Swipe all the way from right to the left until to see the last page/question.
          
          pageIndicator = UtilsMobile.GetElementWithXpath(oPage, HomePagePO::PageIndicatorValXpath)
          #puts pageIndicator
          pIndctrValue = UtilsMobile.GetValueFromElements(pageIndicator)
          #puts pIndctrValue
          if pIndctrValue != false
             pageCount = (pIndctrValue[-1..-1]).to_i
             for i in 1..pageCount-1
                  oPage.execute_script 'mobile: scroll', direction: 'right'
             end        
             
          else
              Log.Error("Test step #{stepId}: the page indicator not found in the page.")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
              return false
          end
         #Verify the last page will appear "Would you like to enable FactSet Drive? Drive allows you to bookmark audio calls, news stories, research reports, transcripsts, and filings to read later or while offline. 
          arrExp = ["Would you like to enable FactSet Drive?","Drive allows you to bookmark audio calls, news stories, research reports, transcripts, and filings to read later or while offline."]
          for i in arrExp
              keyword = i
              question_xpath = CommonObjects.ReplaceString(CommonObjects::ContainsLabel_xpath,keyword)
              question =UtilsMobile.GetElementWithXpath(oPage,question_xpath,20, false)
              if question == false
                  Log.Error("Test step #{stepId}:question/message -  #{i} not found in the last page")
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
                  return false
              end
          end
          # Verify the Yes, No and Skip button appeared or not
          array = ["YES","NO","Skip"]
          for i in array
              keyword = i
              element_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
              element = UtilsMobile.GetElementWithXpath(oPage,element_xpath,20, false)
              if element == false
                  Log.Error("Test step #{stepId}: #{i} button not found in the page.")
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
                  return false
              end
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################ Test Step  #############################################################
    stepId = 621706
    Log.TestStep(stepId, "Result - Home Page")
      begin
          #Tap on the "Yes" button
          keyword = 'YES'
          yesbutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          if UtilsMobile.TapElementWithXpath(oPage,yesbutton_xpath,20,true,true,"yes button ") == false
              return false
          end
       
          #Verify the Four news headlines appear under the "Portfolio Contribution Summary" section in the Homepage.
          
          if UtilsIphone.VerifyAddedPortFliosTextInHome(stepId, oPage, "Portfolio Contribution Summary", 2, arr1) == false
             return false
          end

          #Verify the Four news headlines appear under the "Watch List Summary" section in the Homepage.
          
          if UtilsIphone.VerifyAddedPortFliosTextInHome(stepId, oPage, "Watch List Summary", 2, arr2) == false
             return false
          end
  
          
          #Verify the  "Events Summary" section appear in the Homepage.
          eventsummary_xpath =  CommonObjects.ReplaceString(CommonObjects::ContainsLabel_xpath, "Events Summary") #"//UIATableGroup[contains(@name,'Events Summary' )]"
          eventsummarysection = UtilsMobile.GetElementWithXpath(oPage,eventsummary_xpath,40,false,nil,true)
          if eventsummarysection == false
              driver.execute_script 'mobile: scroll',toVisible: 'true',:element => find_element(:xpath,tablegroup1_xpath).ref 
          end
          #Verify the News headlines will appear under the "Top News" and "FactSet Drive" section
          keyword = "FactSet Drive"
          #Verify the  news headlines appear under the "Top News","FactSet Drive" sections in the Homepage.
          if UtilsIphone.VerifyNewsheadlinesinHome(stepId,oPage,keyword ,4,false) == false
              return false
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
############################################################################################################
    stepID = 000000
    Log.TestStep(stepID,"Log off")
      begin
          logoutsuccess = UtilsMobile.Logout(oPage)
          if logoutsuccess == false
              Log.Error("Test Step: #{251390}: Logout is failed")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
          end
      rescue Exception => e
          Log.Error e
          Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
      ensure    
            Log.CloseTestStep   
      end 
  rescue Exception => e
      Log.Error e.inspect + "\nAdditional Details: " + e.backtrace.join("\n")   
      Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
  ensure
      begin
          driver_quit
      rescue Exception => e
          Log.Error e
          Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
      end
      Log.CloseTestCase
      Log.CloseTestScript       
  end #begin end
end #def end