# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/../Utils/UtilsAll.rb")
require File.expand_path(File.dirname(__FILE__) + '/../PageObjects/AllPageObjects.rb')
def RuniPhoneSetupWizard7()
  begin
    Log.TestScript("iPhoneSetupWizard7.rb")
    Log.TestCase(128328, "iPhoneSetupWizard7")
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
    stepId = 621688
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
    stepId = 621689
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
    stepId = 621690
    Log.TestStep(stepId, "Edit window")
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

################################ Test Step  #############################################################
    stepId = 621691
    Log.TestStep(stepId, "Cancel")
      begin
          keyword = 'CANCEL'
          yesbutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          yesbutton = UtilsMobile.TapElementWithXpath(oPage,yesbutton_xpath,20,true,true,"yes button ")
          if yesbutton == false
              return false
          end
          #Verify user is back to the first question or page "Would you like to setup your Portfolios or Watch lists? 
          keyword = "Would you like to set up your Portfolios or Watch lists?"
          question_xpath = CommonObjects.ReplaceString(CommonObjects::ContainsLabel_xpath,keyword)
          question =UtilsMobile.GetElementWithXpath(oPage,question_xpath,20, false)
          if question == false
              Log.Error("Test step #{stepId}:User not navigated to next page after click operation on YES  button.")
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
    stepId = 621692
    Log.TestStep(stepId, "Yes - Setup Portfolios/Watch Lists")
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
    stepId = 621693
    Log.TestStep(stepId, "Select Portflios and Watchlists")
      begin
          
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


################################### Test Step  #############################################################
    stepId = 621694
    Log.TestStep(stepId, "Setup Portfolios or Watch Lists")
      begin
          
          #Swipe from the left to right
          oPage.execute_script 'mobile: scroll', direction: 'left'
         
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
          keyword = 'YES'
          xpath = GeneralPagePO.Replace(GeneralPagePO::Xpath_btnInBluClr,keyword)
          yesBtnInBlue = UtilsMobile.GetElementWithXpath(oPage,xpath,20, false)
          if yesBtnInBlue == false
             Log.Error("Test step #{stepId}: Yes button is not higilited in blue color.")
             Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
             return false
          end
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end

################################### Test Step  #############################################################
    stepId = 621695
    Log.TestStep(stepId, "Setup Portfolios or Watch Lists")
      begin
          #Tap anywhere on this page
         # if UtilsMobile.TapElementWithXpath(oPage,GeneralPagePO::Xpath_tilenavbutton,20,true,true,"Tilenav button") == false
         #     return false
         # end
         #UtilsMobile.SwipeCurrentPage(oPage, "rtl")
         #Swipe from the left to right
          oPage.execute_script 'mobile: scroll', direction: 'right'
         #execute_script 'mobile: scroll', :direction => 'right'
          
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
################################### Test Step  #############################################################
    stepId = 621696
    Log.TestStep(stepId, "Setup Portfolios or Watch Lists")
      begin
          #Tap anywhere on this page
          #if UtilsMobile.TapElementWithXpath(oPage,GeneralPagePO::Xpath_tilenavbutton,20,true,true,"Tilenav button") == false
          #    return false
          #end
           #UtilsMobile.SwipeCurrentPage(oPage, "rtl")
          #Swipe from the right to left
          oPage.execute_script 'mobile: scroll', direction: 'right'
          #execute_script 'mobile: scroll', :direction => 'right'
          
          keyword = "Would you like to see today’s performance for your Favorites?"
          question_xpath = CommonObjects.ReplaceString(CommonObjects::ContainsLabel_xpath,keyword)
          question =UtilsMobile.GetElementWithXpath(oPage,question_xpath,20, false)
          if question == false
              Log.Error("Test step #{stepId}:User not navigated to next page after click operation on YES  button.")
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
    stepId = 621709
    Log.TestStep(stepId, "Setup Portfolios or Watch Lists")
      begin
          #Tap anywhere on this page
         # if UtilsMobile.TapElementWithXpath(oPage,GeneralPagePO::Xpath_tilenavbutton,20,true,true,"Tilenav button") == false
         #     return false
         # end
         #UtilsMobile.SwipeCurrentPage(oPage, "rtl")
         #Swipe from the right to left
          oPage.execute_script 'mobile: scroll', direction: 'right'
         #execute_script 'mobile: scroll', :direction => 'right'
          
          keyword = "Would you like to receive up-to-date info on today’s top stories?"
          question_xpath = CommonObjects.ReplaceString(CommonObjects::ContainsLabel_xpath,keyword)
          question =UtilsMobile.GetElementWithXpath(oPage,question_xpath,20, false)
          if question == false
              Log.Error("Test step #{stepId}:User not navigated to next page after click operation on YES  button.")
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
    stepId = 621697
    Log.TestStep(stepId, "Swipe - FactSet Drive")
      begin
          #Tap anywhere on this page
          #if UtilsMobile.TapElementWithXpath(oPage,GeneralPagePO::Xpath_tilenavbutton,20,true,true,"Tilenav button") == false
          #    return false
          #end
          #UtilsMobile.SwipeCurrentPage(oPage, "rtl")
          #Swipe from the right to left
          oPage.execute_script 'mobile: scroll', direction: 'right'
          #execute_script 'mobile: scroll', :direction => 'right'
          
          arrExp = ["Would you like to enable FactSet Drive?","Drive allows you to bookmark audio calls, news stories, research reports, transcripts, and filings to read later or while offline."]
          for i in arrExp
              keyword = i
              question_xpath = CommonObjects.ReplaceString(CommonObjects::ContainsLabel_xpath,keyword)
              question =UtilsMobile.GetElementWithXpath(oPage,question_xpath,20, false)
              if question == false
                  Log.Error("Test step #{stepId}: #{i} - message not found in the page")
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
    stepId = 621710
    Log.TestStep(stepId, "Verify Home page")
      begin
          
          keyword = "NO"
          nobutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          nobutton = UtilsMobile.TapElementWithXpath(oPage,nobutton_xpath,20,true,true,"NO button ")
          if nobutton == false
              return false
          end
          
         # if UtilsIphone.VerifyNewsheadlinesinHome(stepId,oPage, "Portfolio Contribution Summary",2,true) == false
         #     return false
         # end
         
         if UtilsIphone.VerifyAddedPortFliosTextInHome(stepId, oPage, "Portfolio Contribution Summary", 2, arr1) == false
             return false
         end
         if UtilsIphone.VerifyAddedPortFliosTextInHome(stepId, oPage, "Watch List Summary", 2, arr2) == false
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

