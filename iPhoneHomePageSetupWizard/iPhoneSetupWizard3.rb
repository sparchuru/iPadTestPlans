# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/../Utils/UtilsAll.rb")
require File.expand_path(File.dirname(__FILE__) + "/../PageObjects/AllPageObjects.rb")
def RuniPhoneSetupWizard3()
  begin
    Log.TestScript("iPhoneSetupWizard3.rb")
    Log.TestCase(128328, "iPhoneSetupWizard3")
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
    stepId = 609603
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
    stepId = 609604
    Log.TestStep(stepId, "Setup Portfolios or Watch Lists")
      begin
           # tap anywhere in the page
          if UtilsMobile.TapElementWithXpath(oPage,SettingsPagePO::NavigationtileXpath,20,true,true,"Tilenav button") == false
              return false
          end
          arrExp = ["Would you like to set up your Portfolios or Watch lists?"]
          if UtilsIphone.VerifyQuestionPage(stepId,oPage,arrExp) == false
             return false
          end 
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################### Test Step  #############################################################
    stepId = 609605
    Log.TestStep(stepId, "Portfolio/watch list window")
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
    stepId = 609606
    Log.TestStep(stepId, "Select Portflios and Watchlists")
      begin
          #SELECT THE THREE WATCHLIST AND PORTFOLIOS
          selectedHash =  UtilsGeneralSettings.SelectPortfoliosAndWatchlists(oPage, 3, 3)
          if selectedHash != false 
              arr1 = selectedHash["portfolios"]
              arr2 = selectedHash["watchlists"]
          else
              return false
          end
          #verify if the expected text exists on the screen
          arrExp = ["6 portfolios / watch lists have been set up.", "Redo", "Would you like to see today’s events for your portfolios and watch lists?"]
          if UtilsIphone.VerifyQuestionPage(stepId,oPage,arrExp) == false
             return false
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################ Test Step  #############################################################
    stepId = 609607
    Log.TestStep(stepId, "Redo Hyperlink")
      begin
          #Tap on the Redo hyperlink
          keyword = "Redo"
          redo_xpath = CommonObjects.ReplaceString(CommonObjects::ContainsLabel_xpath,keyword)
          if UtilsMobile.TapElementWithXpath(oPage,redo_xpath,20,true,true,"redo button") == false
              return false
          end
          #Verify user is back to the first question or page "Would you like to setup your Portfolios or Watch lists? 
          arrExp = ["Would you like to set up your Portfolios or Watch lists?"]
          if UtilsIphone.VerifyQuestionPage(stepId,oPage,arrExp) == false
             return false
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################ Test Step  #############################################################
    stepId = 609635
    Log.TestStep(stepId, "Verify Portfolio/Watch list")
      begin
          #Tap on the Yes button
          keyword = 'YES'
          yesbutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          if UtilsMobile.TapElementWithXpath(oPage,yesbutton_xpath,20,true,true,"yes button ") == false
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
################################ Test Step  #############################################################
    stepId = 609608
    Log.TestStep(stepId, "Add Portfolio/Watch list")
      begin
          #SELECT THE FOUR WATCHLIST AND PORTFOLIOS
          selectedHash =  UtilsGeneralSettings.SelectPortfoliosAndWatchlists(oPage,4,4)
          if selectedHash != false 
              arr1 = selectedHash["portfolios"]
              arr2 = selectedHash["watchlists"]
          else
              return false
          end
          #verify if the expected text exists on the screen
          arrExp = ["8 portfolios / watch lists have been set up.", "Redo", "Would you like to see today’s events for your portfolios and watch lists?"]
          if UtilsIphone.VerifyQuestionPage(stepId,oPage,arrExp) == false
             return false
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################ Test Step  #############################################################
    stepId = 609609
    Log.TestStep(stepId, "No - Favorites")
      begin
          #Tap on the Yes button
          keyword = 'YES'
          yesbutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          if UtilsMobile.TapElementWithXpath(oPage,yesbutton_xpath,20,true,true,"yes button ") == false
              return false
          end
          #Verify the first question "Would you like to set up your Portfolios or Watch Lists? "
          arrExp =["Would you like to see today’s performance for your Favorites?"]
          if UtilsIphone.VerifyQuestionPage(stepId,oPage,arrExp) == false
             return false
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################ Test Step  #############################################################
    stepId = 609610
    Log.TestStep(stepId, "Today's top stories")
      begin
          #Tap on the NO button
          keyword = 'NO'
          nobutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          if UtilsMobile.TapElementWithXpath(oPage,nobutton_xpath,20,true,true,"no button ") == false
              return false
          end
          #Would you like to receive up-to-date info on today’s top stories?
          #Verify the question "Would you like to receive up-to-date info today's top stories?" 
          arrExp =["Would you like to receive up-to-date info on today’s top stories?"]
          if UtilsIphone.VerifyQuestionPage(stepId,oPage,arrExp) == false
             return false
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################ Test Step  #############################################################
    stepId = 609611
    Log.TestStep(stepId, "Enable-FactSet Drive")
      begin
          #Tap on the Yes button
          keyword = 'YES'
          yesbutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          if UtilsMobile.TapElementWithXpath(oPage,yesbutton_xpath,20,true,true,"yes button ") == false
              return false
          end
          arrExp = ["Would you like to enable FactSet Drive?","Drive allows you to bookmark audio calls, news stories, research reports, transcripts, and filings to read later or while offline."]
          if UtilsIphone.VerifyQuestionPage(stepId,oPage,arrExp) == false
             return false
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################ Test Step  #############################################################
    stepId = 609612
    Log.TestStep(stepId, "Verify Home page")
      begin
          #Tap on the "Yes" button
          keyword = 'YES'
          yesbutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          if UtilsMobile.TapElementWithXpath(oPage,yesbutton_xpath,20,true,true,"yes button ") == false
              return false
          end
          #Verify the Four Portfolios appear under the "Portfolio Contribution Summary" section in the Homepage.
          
          if UtilsIphone.VerifyAddedPortFliosTextInHome(stepId, oPage, "Portfolio Contribution Summary", 4, arr1) == false
             return false
          end
  
          #Verify the Four news headlines appear under the "Watch List Summary" section in the Homepage.
          if UtilsIphone.VerifyAddedPortFliosTextInHome(stepId, oPage, "Watch List Summary", 4, arr2) == false
             return false
          end
          
          arr = arr1 | arr2
          # Four portfolios and four watch lists that you have selected will appear under the "Today's Events Summary" section
          if UtilsIphone.VerifyAddedPortFliosTextInHome(stepId, oPage, "Today's Events Summary", 8, arr) == false
             return false
         end
          
          #Verify the News headlines will appear under the "Top News" and "FactSet Drive" section
          array = ["Top News","FactSet Drive"]
          for i in array
              keyword = i
              #Verify the  news headlines appear under the "Top News","FactSet Drive" sections in the Homepage.
              if UtilsIphone.VerifyNewsheadlinesinHome(stepId,oPage,keyword ,4,false) == false
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
    stepId = 609613
    Log.TestStep(stepId, "Home Page Wizard")
      begin
          if UtilsGeneralSettings.LaunchHomepageSetupWizard(oPage) == false
              return false
          end
          #Tap on the Skip button
          keyword = 'Skip'
          yesbutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          if UtilsMobile.TapElementWithXpath(oPage,yesbutton_xpath,20,true,true,"Skip button ") == false
              return false
          end
          #Verify the Four Portfolios appear under the "Portfolio Contribution Summary" section in the Homepage.
          
          if UtilsIphone.VerifyAddedPortFliosTextInHome(stepId, oPage, "Portfolio Contribution Summary", 4, arr1) == false
             return false
          end
  
          #Verify the Four news headlines appear under the "Watch List Summary" section in the Homepage.
          if UtilsIphone.VerifyAddedPortFliosTextInHome(stepId, oPage, "Watch List Summary", 4, arr2) == false
             return false
          end
          
          arr = arr1 | arr2
          # Four portfolios and four watch lists that you have selected will appear under the "Today's Events Summary" section
          if UtilsIphone.VerifyAddedPortFliosTextInHome(stepId, oPage, "Today's Events Summary", 8, arr) == false
             return false
         end
          
          #Verify the News headlines will appear under the "Top News" and "FactSet Drive" section
          array = ["Top News","FactSet Drive"]
          for i in array
              keyword = i
              #Verify the  news headlines appear under the "Top News","FactSet Drive" sections in the Homepage.
              if UtilsIphone.VerifyNewsheadlinesinHome(stepId,oPage,keyword ,4,false) == false
                  return false
              end
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