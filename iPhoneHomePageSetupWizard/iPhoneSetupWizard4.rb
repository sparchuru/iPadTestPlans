# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/../Utils/UtilsAll.rb")
require File.expand_path(File.dirname(__FILE__) + '/../PageObjects/AllPageObjects.rb')
def RuniPhoneSetupWizard4()
  begin
    Log.TestScript("iPhoneSetupWizard4.rb")
    Log.TestCase(128328, "iPhoneSetupWizard4")
    get_driver(Configuration.capabilities, Configuration.server_url) 
    oPage = Watir::Browser.new driver
   
############################################################################################################
# NOTE: Here We don't have log in test step id's. So we are using zeros as test step id's 
  stepId = "000000"
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
    stepId = 609650
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
    stepId = 609651
    Log.TestStep(stepId, "Setup Portfolios or Watch Lists")
      begin
          
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
    stepId = 609652
    Log.TestStep(stepId, "No - First question")
      begin
          #Tap on the Yes button
          keyword = 'NO'
          nobutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          nobutton = UtilsMobile.TapElementWithXpath(oPage,nobutton_xpath,20,true,true,"No Button ")
          if nobutton == false
              return false
          end
          arrExp = ["Would you like to see today’s performance for your Favorites?"]
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
    stepId = 609653
    Log.TestStep(stepId, "Select Portflios and Watchlists")
      begin
          #Tap on the Yes button
          keyword = 'YES'
          nobutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          nobutton = UtilsMobile.TapElementWithXpath(oPage,nobutton_xpath,20,true,true,"No Button ")
          if nobutton == false
              return false
          end
          arrExp = ["Would you like to receive up-to-date info on today’s top stories?"]
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
    stepId = 609654
    Log.TestStep(stepId, "Home page - FactSet Drive")
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
    stepId = 609655
    Log.TestStep(stepId, "Hom Page")
      begin
          #Tap on the Yes button
          keyword = 'YES'
          yesbutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          if UtilsMobile.TapElementWithXpath(oPage,yesbutton_xpath,20,true,true,"yes button ") == false
              return false
          end
          
          if UtilsIphone.VerifyNewsheadlinesinHome(stepId,oPage, "Favorites",1,false) == false
              return false
          end
          if UtilsIphone.VerifyNewsheadlinesinHome(stepId,oPage, "Top News",1,false) == false
              return false
          end
          if UtilsIphone.VerifyNewsheadlinesinHome(stepId,oPage, "FactSet Drive",1,false) == false
              return false
          end
          
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################ Test Step  #############################################################
    stepId = 621451
    Log.TestStep(stepId, "Open Story")
      begin
          #keyword = 'Top News'
          #newsHdline_xpath = GeneralPagePO.Replace(IPhoneHomePagePO::Xpath_newsHeadline,keyword)
          #UtilsMobile.ScrollElementToVisibilty(IPhoneHomePagePO::Xpath_window,newsHdline_xpath)
          keyword = 'Top News'
          newsHdline_xpath = IPhoneHomePagePO.ReplaceString(IPhoneHomePagePO::Xpath_newsHeadlineUndrLastSection,keyword)
          oPage.execute_script 'mobile: scroll',toVisible: 'true',:element => find_element(:xpath,newsHdline_xpath).ref 
          if UtilsMobile.TapElementWithXpath(oPage,newsHdline_xpath,20,true,true,"News HeadLine Under top news") == false
              return false
          end
          if UtilsGeneralSettings.VerifyOpenStory(oPage) == false
            return false
          end
          
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################ Test Step  #############################################################
    stepId = 621452
    Log.TestStep(stepId, "Close the Story")
      begin
          doneBtnXpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,"DONE")
          if UtilsMobile.TapElementWithXpath(oPage, doneBtnXpath) != false
             if UtilsMobile.GetElementWithXpath(oPage, HomePagePO::HamBurger_xpath, 20, false) == false 
                Log.Error("Test step #{stepId}  Tapping on done button did not close the opened story")
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
    stepId = 621453
    Log.TestStep(stepId, "Open Story")
      begin
          keyword = 'FactSet Drive'
          newsHdline_xpath = IPhoneHomePagePO.ReplaceString(IPhoneHomePagePO::Xpath_newsHeadlineUndrLastSection,keyword)
          oPage.execute_script 'mobile: scroll',toVisible: 'true',:element => find_element(:xpath,newsHdline_xpath).ref 
          if UtilsMobile.TapElementWithXpath(oPage,newsHdline_xpath,20,true,true,"News HeadLine Under top news") == false
              return false
          end
          if UtilsGeneralSettings.VerifyOpenStory(oPage) == false
            return false
          end
          
      rescue Exception => e
          Log.Error e
          return false
      ensure
          Log.CloseTestStep
      end
################################ Test Step  #############################################################
    stepId = 621454
    Log.TestStep(stepId, "Close the Story")
      begin
          doneBtnXpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,"DONE")
          if UtilsMobile.TapElementWithXpath(oPage, doneBtnXpath) != false
             if UtilsMobile.GetElementWithXpath(oPage, HomePagePO::HamBurger_xpath, 20, false) == false 
                Log.Error("Test step #{stepId}  Tapping on done button did not close the opened story")
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
    stepId = 621455
    Log.TestStep(stepId, "Edit page")     
      begin
          penclBtnXpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,"Navigation edit")
          if UtilsMobile.TapElementWithXpath(oPage,penclBtnXpath,20,true,true,"pencil") == false
              return false
          end
              
          #Verify the homepage is appear or not
          if UtilsIphone.VerifyEditWndw(stepId,oPage) == false
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
    stepId = 621456
    Log.TestStep(stepId, "Disable Favorites")     
      begin
          #Tap on the activate (include) button next to the Favorites
          keyword = 'Favorites'
          activeradiobutton_xpath = EditPagePO.Replace(EditPagePO::Activate_xpath, keyword)
          #quotebutton_xpath = EditPagePO.Replace(EditPagePO::Activate_xpath, keyword)
          quotebutton = UtilsMobile.GetElementWithXpath(oPage, activeradiobutton_xpath, 20, false)
          if quotebutton != false
              quotebutton.click
              #Verify  the circle is unselected or not
              #keyword = 'Quote Alerts'
              quotebutton_xpath = EditPagePO.Replace(EditPagePO::Deactivate_xpath, keyword)
              quotebutton = UtilsMobile.GetElementWithXpath(oPage, quotebutton_xpath,10, false)
              if quotebutton == false
                  Log.Error("Test step #{stepId}: The activate (include) button next to the Favorites is not deactivated.")
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
                  return false
              end 
          else
              quotebutton_xpath = EditPagePO.Replace(EditPagePO::Deactivate_xpath, keyword)
              quotebutton = UtilsMobile.GetElementWithXpath(oPage, quotebutton_xpath,10, false)
              if quotebutton == false
                  Log.Error("Test step #{stepId}:Include(activate)button followed by Favorites not found in edit window.")
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
                  return false  
              end
          end
      
          #Tap on the Done button
          doneBtnXpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,"DONE")
          done = UtilsMobile.TapElementWithXpath(oPage,doneBtnXpath,20,true,true,"done button")
          if done != false   
              if UtilsMobile.GetElementWithXpath(oPage, HomePagePO::HamBurger_xpath, 20, false) == false 
                Log.Error("Test step #{stepId}  Tapping on done button user not navigated to home page form edit page")
                Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
                return false
             end
              #Verify the "Favorites" section does not appear in the Home page.
              keyword = 'Favorites'
              quote_xpath = CommonObjects.ReplaceString(CommonObjects::ContainsLabel_xpath, keyword)
              #wndw_xpath = "//UIATableView[1]"
              #UtilsMobile.ScrollElementToVisibilty(wndw_xpath,quote_xpath)
              quotealerts=UtilsMobile.GetElementWithXpath(oPage,quote_xpath,5,false,'quote alerts',false)
              #quotealerts = oPage.find_element(:xpath => quote_xpath)
              if quotealerts != false
                  Log.Error("Test step #{stepId}: The Favorites section is showing in Home page even after disabling.")
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
                  return false
              end 
          else
              return false
          end
      rescue Exception => e
          Log.Error e
          Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")       
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