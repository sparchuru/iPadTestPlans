# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/../Utils/UtilsAll.rb")
require File.expand_path(File.dirname(__FILE__) + "/../PageObjects/AllPageObjects.rb")
def RuniPhoneSetupWizard5()
  begin
    Log.TestScript("iPhoneSetupWizard5.rb")
    Log.TestCase(129997, "iPhoneSetupWizard5")
    get_driver(Configuration.capabilities, Configuration.server_url) 
    oPage = Watir::Browser.new driver
    platform = Configuration.platformVersion

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
    stepId = 621457
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
    stepId = 621458
    Log.TestStep(stepId, "Home Page Wizard")
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
              Log.Error("Test step #{stepId}: Question #{keyword} is not found in the page.")
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
    stepId = 621459
    Log.TestStep(stepId, "Select Portfolios/watch lists")
      begin
          #Tap on the Yes button
          keyword = 'YES'
          yesbutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          yesbutton = UtilsMobile.TapElementWithXpath(oPage,yesbutton_xpath,20,true,true,"yes button")
          if yesbutton == false
              return false
          end
          #Verify the "Add Portfolio/Watch list" dialog window will appeared or not  
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
    stepId = 621460
    Log.TestStep(stepId, "Create New Watch List")
      begin
          #Tap on the "+ NEW" button
          keyword = 'NEW'
          plusNewbtn_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          plusNewbtn = UtilsMobile.TapElementWithXpath(oPage,plusNewbtn_xpath,20,true,true,"Plus New (+New) button")
          if plusNewbtn == false
              return false
          end
          #Verify the Watch List editor dialog will appear
          elements = ["Add Group","Untitled"]
          for i in elements
              keyword = i
              element_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
              element = UtilsMobile.GetElementWithXpath(oPage,element_xpath,20, false)
              if element == false
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
                  return false
              end
          end
          xpath = CommonObjects.ReplaceString(CommonObjects::InputField_xpath,"Add Security")
          addsecurityrextbox = UtilsMobile.GetElementWithXpath(oPage,xpath,20, false)
          if addsecurityrextbox == false
              Log.Error("Test step #{stepId}: Watch list Editor dailog not appear after click on PlusNEW button in 'Add Portfolio/Watch list' page.")
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
    stepId = 621461
    Log.TestStep(stepId, "Grouping")
      begin
          #Tap on the "Add Group" button
          keyword = 'Add Group'
          addGroupbtn_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          addGroupbtn = UtilsMobile.TapElementWithXpath(oPage,addGroupbtn_xpath,20,true,true,"Add  Group button")
          if addGroupbtn == false
              return false
          end
          #Verify the "Name Group" alert box appear or not 
          keyword ="Name Group"
          namegroupalert_xpath = CommonObjects.ReplaceString(CommonObjects::AlertWndw_xpath,keyword)
          namegroupalert = UtilsMobile.GetElementWithXpath(oPage,namegroupalert_xpath,20, false)
          if namegroupalert == false
               Log.Error("Test step #{stepId}: Name Group alert dailog not appear after click operation on Add Group button.")
               Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
               return false
          end
          #Enter the "Test Grouping" on the text box 
          keyword = 'Group Name'
          testgrouptext_xpath = CommonObjects.ReplaceString(CommonObjects::InputField_xpath,keyword)
          typetext = UtilsMobile.SetText(testgrouptext_xpath,"Test Grouping",20,true)
          if typetext == false
               return false
          end 
          
          #Tap on ok button 
          keyword = 'OK'
          okbtn_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          okbtn = UtilsMobile.TapElementWithXpath(oPage,okbtn_xpath,20,true,true,"ok button in alerts page")
          if okbtn == false
              return false
          end
          
          #verify the Alert Disappeared or not 
          namegroupalert_xpath = CommonObjects.ReplaceString(CommonObjects::AlertWndw_xpath,"Name Group")
          namegroupalert = UtilsMobile.WaitForElementToInvisible(oPage,namegroupalert_xpath,10)
          if namegroupalert != false
               Log.Error("Test step #{stepId}: Name Group alert dailog not disappear after click operation on ok button.")
               Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
               return false
          end
          #Verify the "Test Grouping" will appear on the watch list editor page.
          xpth = CommonObjects.ReplaceString(CommonObjects::StaticText_xpath,"Test Grouping")
          testgroupcell = UtilsMobile.GetElementWithXpath(oPage,xpth,20, false)
          if testgroupcell == false
               Log.Error("Test step #{stepId}: Test Grouping section not appear in watch list editor page after  Enter the 'Test Grouping' in alerts page.")
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
   
    #updat require
    stepId = 621462
    Log.TestStep(stepId, "Enter tickers list")
      begin
          elements = ["IBM-US","MMM-US","GOOGL-US","FB-US","FDS-US"]
          input_xpath = CommonObjects.ReplaceString(CommonObjects::InputField_xpath,"Add Security")
          for i in elements
              keyword = i
              #Enter the IBM ticker on the "Add Security" text box 
              typetext = UtilsMobile.SetText(input_xpath,i,20,true)
              if typetext == false
                   Log.Error("Test step #{stepId}: Unable to enter tickers in Add Security text box.")
                   Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
                   return false
              end
              #Select the IBM-US under the type heads
              ibmusticker_xpath = CommonObjects.ReplaceString(CommonObjects::StaticText_xpath,keyword)
              ibmusticker = UtilsMobile.TapElementWithXpath(oPage,ibmusticker_xpath,20,true,true,"#{i} Ticker")
              if ibmusticker == false
                  return false
              end
              #Verify the ticker that you have selected will appear under the "Test Grouping" section
              ibmusticker_xpath = GeneralPagePO.Replace(GeneralPagePO::Xpath_TckrUndrTestGrp,keyword)
              ibmusticker = UtilsMobile.GetElementWithXpath(oPage,ibmusticker_xpath,20,false)
              if ibmusticker == false
                  Log.Error("Test step #{stepId}: #{i} Ticker not appear under Test Grouping Section ,After click operation on it.")
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
    stepId = 621463
    Log.TestStep(stepId, "Edit Watch List Name")
      begin
          #Tap on save button 
          keyword = 'SAVE'
          savebtn_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          savebtn = UtilsMobile.TapElementWithXpath(oPage,savebtn_xpath,20,true,true,"Save button")
          if savebtn == false
              return false
          end
          #Verify the "Edit Watch List Name dailog
          keyword ="Edit Watch List Name"
          alert_xpath = CommonObjects.ReplaceString(CommonObjects::AlertWndw_xpath,keyword)
          editwatchlistnamealert = UtilsMobile.GetElementWithXpath(oPage,alert_xpath,20, false)
          if editwatchlistnamealert == false
               Log.Error("Test step #{stepId}: Edit Watch List Name alert dailog not appear after click operation on Save button.")
               Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
               return false
          end
          #Enter the "Test123" on the text box
          keyword = "Watch List Name"
          testgrouptext_xpath = CommonObjects.ReplaceString(CommonObjects::InputField_xpath,keyword)
          typetext = UtilsMobile.SetText(testgrouptext_xpath,"Test123",20,true)
          if typetext == false
               return false
          end 
          
          #Tap on ok button 
          keyword = 'OK'
          okbtn_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          okbtn = UtilsMobile.TapElementWithXpath(oPage,okbtn_xpath,20,true,true,"ok button in alerts page")
          if okbtn == false
              return false
          end
          
          #handle pop up or alert page 
          keyword = "Name Conflict"
          alert_xpath = CommonObjects.ReplaceString(CommonObjects::AlertWndw_xpath,keyword)
          nameconflictpopup = UtilsMobile.GetElementWithXpath(oPage,alert_xpath,20, false)
          if nameconflictpopup != false
               #Tap on ok button 
              keyword = 'OK'
              okbtn_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
              okbtn = UtilsMobile.TapElementWithXpath(oPage,okbtn_xpath,20,true,true,"ok button in alerts page")
              if okbtn == false
                  return false
              end
          end
          #verify the "Watch List saved successfully. OK"  message will appear
          keyword = "Watch List saved successfully"
          alert_xpath = CommonObjects.ReplaceString(CommonObjects::AlertWndw_xpath,keyword)
          editwatchlistnamealert = UtilsMobile.GetElementWithXpath(oPage,alert_xpath,30, false)
          if editwatchlistnamealert == false
               Log.Error("Test step #{stepId}: Watch List saved successfully and OK message alert dailog not appear after click operation on Save button.")
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
    stepId = 621464
    Log.TestStep(stepId, "New watch list name")
      begin
          #Tap on ok button 
          keyword = 'OK'
          okbtn_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          okbtn = UtilsMobile.TapElementWithXpath(oPage,okbtn_xpath,20,true,true,"ok button in alerts page")
          if okbtn == false
              return false
          end
          #verify the "Watch List saved successfully. OK"  message disappeared or not
          keyword = "Watch List saved successfully"
          alert_xpath = CommonObjects.ReplaceString(CommonObjects::AlertWndw_xpath,keyword)
          editwatchlistnamealert = UtilsMobile.WaitForElementToInvisible(oPage,alert_xpath,10)
          if editwatchlistnamealert != false
               Log.Error("Test step #{stepId}: Watch List saved successfully and OK message alert dailog not disappear after click operation on ok button.")
               Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
               return false
          end
          # End of the page is not coming to visible with one scroll so we are using two times below and might be reson that page is too long
          oPage.execute_script 'mobile: scroll', direction: 'down'
          oPage.execute_script 'mobile: scroll', direction: 'down'
          test123last = UtilsMobile.GetElementsWithXpath(oPage,GeneralPagePO::Xpath_bottomtest123,10, false)
          if test123last.length != 0
              Log.Error("Test step #{stepId}:  Test123 watch list name not appear on the bottom of the Watch List section.")
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
    stepId = 621465
    Log.TestStep(stepId, "Today's Events")
      begin
          #Tap on the radio button next to the "Testing"
          keyword = "TEST123"
          radiobtn_xpath = GeneralPagePO.Replace(GeneralPagePO::Radiobtndisabled_xpath,keyword)
          radiobtn = UtilsMobile.GetElementWithXpath(oPage,radiobtn_xpath,20, false,nil,false)
          if radiobtn != false
               radiobtn.click
               #verify enabled or not
               radiobtn_xpath = GeneralPagePO.Replace(GeneralPagePO::Radiobtnenabled_xpath,keyword)
               radiobtn = UtilsMobile.GetElementWithXpath(oPage,radiobtn_xpath,20, false)
               if radiobtn == false
                   Log.Error("Test step #{stepId}: Radio button next to test123 is not activated after click on it in Add Portfolio/Watch list Page.")
                   Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
                   return false
               end
          else
              radiobtn_xpath = GeneralPagePO.Replace(GeneralPagePO::Radiobtnenabled_xpath,keyword)
              radiobtn = UtilsMobile.GetElementWithXpath(oPage,radiobtn_xpath,20, false)
              if radiobtn == false
                  Log.Error("Test step #{stepId}: Radio button next to test123 Ticker is not found in Add Portfolio/Watch list Page.")
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
                  return false
              end
          end
          #Tap on ok button 
          keyword = 'OK'
          okbtn_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          okbtn = UtilsMobile.TapElementWithXpath(oPage,okbtn_xpath,20,true,true,"ok button in Add Portfolio/Watch list Page")
          if okbtn == false
              return false
          end
          #verify if the expected text exists on the screen
          arrExp = ["1 portfolios / watch lists have been set up.", "Redo", "Would you like to see today’s events for your portfolios and watch lists?"]
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
################################### Test Step  #############################################################
    stepId = 621466
    Log.TestStep(stepId, "No - Events")
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
              Log.Error("Test step #{stepId}: Question #{keyword} is not found in the page")
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
    stepId = 621467
    Log.TestStep(stepId, "No - Favorites")
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
              Log.Error("Test step #{stepId}: Question #{keyword}is not found in the page")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
              return false
          end
          # Verify the Yes, No and Skip button appeared or not
          array = ["YES","NO","Skip"]
          for i in array
              keyword = i
              element_xpath_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
              element_xpath = UtilsMobile.GetElementWithXpath(oPage,element_xpath_xpath,20, false)
              if element_xpath == false
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
    stepId = 621468
    Log.TestStep(stepId, "Today's Stories")
      begin
          #Tap on the Yes button
          keyword = 'YES'
          yesbutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          if UtilsMobile.TapElementWithXpath(oPage,yesbutton_xpath,20,true,true,"yes button ") == false
              return false
          end
          arrExp = ["Would you like to enable FactSet Drive?","Drive allows you to bookmark audio calls, news stories, research reports, transcripts, and filings to read later or while offline."]
          for i in arrExp
              keyword = i
              question_xpath =CommonObjects.ReplaceString(CommonObjects::ContainsLabel_xpath,keyword)
              question =UtilsMobile.GetElementWithXpath(oPage,question_xpath,20, false)
              if question == false
                  Log.Error("Test step #{stepId}: question/message -  #{i} not found in the page")
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
    stepId = 621469
    Log.TestStep(stepId, "No - FactSet Drive")
      begin
          #Tap on the NO button
          keyword = 'NO'
          nobutton_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,keyword)
          if UtilsMobile.TapElementWithXpath(oPage,nobutton_xpath,20,true,true,"no button ") == false
              return false
          end
          #Verify the  news headlines appear under the "Top News","FactSet Drive" sections in the Homepage.
          keyword = "Top News"
          if UtilsIphone.VerifyNewsheadlinesinHome(stepId,oPage,keyword ,3,false) == false
              return false
          end
          # Verify only the "Testing" watch list will appear under the "Watch List Summary" section
          if UtilsIphone.VerifyNewsheadlinesinHome(stepId,oPage, "Watch List Summary",1,true) == false
              return false
          end
          expctedArr = ["TEST123"]
         
          if UtilsIphone.VerifyAddedPortFliosTextInHome(stepId ,oPage,"Watch List Summary", 1, expctedArr) == false
              Log.Error("Test step #{stepId}: Error while verifying TEST123 under watch list section.")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
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