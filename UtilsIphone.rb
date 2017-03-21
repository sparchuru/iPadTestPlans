module UtilsIphone
  #=========================================================================================#     
  #    FUNCTION: VerifyEditWndw                                                             # 
  #                                                                                         #
  #    NOTES: Verify the edit widow.                                                        #
  #   one parameter is mandatory with                                                       #
  #   1st parameter being the step id .                                                     #
  #   2nd parameter being the driver object.                                                #
  #                                                                                         #              
  #    RETURN: false if some exception is raised or the edit window is not opened.          #
  #=========================================================================================#
  def UtilsIphone.VerifyEditWndw(stepId,driverEle=nil)
      begin
        Log.Utility("UtilsIphone::VerifyEditWndw")
        if driverEle.nil?
          Log.Warning "Passed invalid arguments"
          return false
        end
            #Verify the Editpage is appear or not
            array = ["Favorites","Portfolio Contribution Summary","Watch List Summary","FactSet Drive","News Alerts","Quote Alerts","Top News"]
            for i in array
                 keyword = i
                 array_xpath = EditPagePO.Replace(EditPagePO::Ticker_xapth, keyword)
                 verify = UtilsMobile.GetElementWithXpath(driverEle, array_xpath, 20, false)
                 if verify == false
                    Log.Error("Test step #{stepId}:Homepage doesn't appear after clicked on edit button in home page.")
                    Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                    return false
                end
            end
            todaywatchlist_xpath = "//UIAStaticText[contains(@label,'Events Summary')]"
            todaywatchlist = UtilsMobile.GetElementWithXpath(driverEle,todaywatchlist_xpath, 20, false)
            if todaywatchlist == false
                Log.Error("Test step #{stepId}:Today's events summary doesn't appear after clicked on edit button in home page.")
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
  #    FUNCTION: VerifyNewsheadlinesinHome                                                  # 
  #                                                                                         #
  #    NOTES: Verify the number of news headlines under different [Favorites,Portfolio Contribution Summary,Watch List Summary,FactSet Drive,Quote Alerts,Top News,Today's events summary]
  #              sections/tablegroups in home page                                          #
  #    five parameters is mandatory,                                                        #
  # step id ,driver object ,Element name (section/tablegroup name),count of the headlines.  #
  #    5th parameter falg value to verify the exact number or atleast one headline found under the section.
  #    RETURN: false if some exception is raised or the edit window is not opened.          #
  #=========================================================================================#
  def UtilsIphone.VerifyNewsheadlinesinHome(stepId ,driverEle = nil , elementName = nil , totalHeadlines = nil,flag = nil)
      begin
        count = 0
        Log.Utility("UtilsIphone::VerifyNewsheadlinesinHome")
        if driverEle.nil?
          Log.Warning "Passed invalid arguments"
          return false
        end
            
            if elementName == "Events Summary"
                tablegroup_xpath = "//UIATableGroup[contains(@name,'Events Summary' )]/following-sibling::UIATableCell" 
                wndw_xpath ="//UIATableView[1]"
                tablegroup1_xpath = "//UIATableGroup[contains(@name,'Events Summary' )]"
                tablegroupisvisiable = UtilsMobile.GetElementWithXpath(driverEle,tablegroup1_xpath,40,false,nil,true)
                if tablegroupisvisiable == false
                    begin
                        UtilsMobile.ScrollElementToVisibilty(wndw_xpath,tablegroup1_xpath)
                    rescue Exception => e
                        if (e.message.include? "scrollToVisible cannot be used because this element has no scrollable ancestor.")
                                count = count + 1
                                 if count < 3
                                   retry
                                end
                        end
                    end
                end
            else
                tablegroup_xpath = IPhoneHomePagePO.ReplaceString(IPhoneHomePagePO::Tablegroup_xpath, elementName)
                wndw_xpath ="//UIATableView[1]"
                section_xpath = IPhoneHomePagePO.ReplaceString(IPhoneHomePagePO::TablegroupsinHome_xpath, elementName) 
                tablegroupisvisiable = UtilsMobile.GetElementWithXpath(driverEle,section_xpath,40,false,nil,true)
                if tablegroupisvisiable == false
                    begin
                        UtilsMobile.ScrollElementToVisibilty(wndw_xpath,section_xpath)
                    rescue Exception => e
                        if (e.message.include? "scrollToVisible cannot be used because this element has no scrollable ancestor.")
                                count = count + 1
                                 if count < 3
                                   retry
                                end
                        end
                    end
                end
            end
                
            tablecells = UtilsMobile.GetElementsWithXpath(driverEle,tablegroup_xpath,40,false,false,nil)
            if tablecells.length > 0
                count = tablecells.length
            else
                Log.Error("Test step #{stepId}: News headlines are not found Under #{elementName} in home page.")
                Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                return false
            end
            #Find the total number of tablegroups 
            tablegroups = UtilsMobile.GetElementsWithXpath(driverEle,IPhoneHomePagePO::Xpath_totaltablegroups,40,false)
            if tablegroups.length > 0
                totaltablegroups = tablegroups.length
            else
                Log.Error("Test step #{stepId}: Table group Sections are not found in home page.")
                Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                return false
            end
            #Check the Required table group position is last or not
            position = 0
            for k in 1..totaltablegroups
                xpath_Sectionstext = "//UIATableView[1]/UIATableGroup[#{k}]/UIAStaticText"
                section = UtilsMobile.GetElementWithXpath(driverEle, xpath_Sectionstext, 40, false,"tablecell",false)
                if section != false
                    tickername = section.text
                    position = position+1
                    if elementName == "Events Summary"
                        if tickername == "Today's Events Summary"
                            break
                        end
                    else
                        if tickername == elementName
                            break
                        end
                    end
                else
                    Log.Error("Test step #{stepId}: Tickers are not found in the home page.")
                    Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                    return false
                end
            end
            if totaltablegroups == position
                count1 = 0
            else
                if elementName == "Events Summary"
                    nexttablegroup_xpath = "//UIATableGroup[contains(@name ,'Events Summary')]/following-sibling::UIATableGroup[1]/following-sibling::UIATableCell"
                else
                    nexttablegroup_xpath = IPhoneHomePagePO.ReplaceString(IPhoneHomePagePO::Tablegroup1_xpath, elementName)
                end
                tablecell = UtilsMobile.GetElementsWithXpath(driverEle,nexttablegroup_xpath,40,false,nil,false)
                if tablecell.length > 0
                    count1 = tablecell.length
                end
            end
            if flag == true
                #Verify the number of head lines
                if count - count1 != totalHeadlines
                    Log.Error("Test step #{stepId}: #{totalHeadlines} news headlines are not found Under #{elementName} group in home page.")
                    Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                    return false
                end
            else
                if count - count1 <= 0
                    Log.Error("Test step #{stepId}: news headlines are not found Under #{elementName} group in home page.")
                    Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                    return false
                end
            end
      rescue Exception => e
        Log.Error e
        return false
      ensure      
        Log.CloseUtility
      end
    end
#========================================================================================#
#    FUNCTION: IphoneAddNewsHeadLinesToDrive                                             #
#                                                                                        #
#    NOTES: Use this function to open news and added to drive which was not added already#
#                                                                                        #
#    RETURN: return false if any thing goes wrong.                                       #
#========================================================================================#
   
   
  def UtilsIphone.IphoneAddNewsHeadLinesToDrive(stepID=nil,driver=nil,numofheadlines = nil)
      begin  
          if driver.nil? || numofheadlines.nil?  then
              Log.Warning "pass in valid arguments"
              return false
           end
          textarray = []
          count = 0
          newsHeadline_xpath = '//UIATableView[@label="FDSNewsHeadlinesTableViewController"]/UIATableCell'
          newsHdLinesFound = UtilsMobile.GetElementsWithXpath(driver, newsHeadline_xpath,20,false)
          if newsHdLinesFound != false
              totalNewsHeadLines = newsHdLinesFound.length
          else
              Log.Error("Test step #{stepID}: No news headlines found under selected section to add to drive.") 
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
              return false
          end
          for i in 1..totalNewsHeadLines
              newsHeadline_xpath = "//UIATableView[@label='FDSNewsHeadlinesTableViewController']/UIATableCell[#{i}]"
              newsHdLinesFound = UtilsMobile.GetElementWithXpath(driver, newsHeadline_xpath,20,false,nil,false)
              if newsHdLinesFound != false
                  openedStry = UtilsMobile.GetElementWithXpath(driver,newsHeadline_xpath, 20, false,nil,false)
                  if openedStry != false
                     openedStryText =  openedStry.text
                  else
                      Log.Error("Test step #{stepId}: News head lines under news tab not found after tap on news tab.") 
                      Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(oPage)}", "Screencapture")
                      return false
                  end
                  newsHdLinesFound.click
                  UtilsGeneralSettings.VerifyOpenStory(driver)
                  xpath_delete = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,"Delete") 
                  deltedBtn = UtilsMobile.GetElementWithXpath(driver, xpath_delete,20,false)
                  if deltedBtn == false
                      addtoDriveBtn_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,"Add to Drive")
                      addtoDrvBtn = UtilsMobile.GetElementWithXpath(driver, addtoDriveBtn_xpath,20,false)
                      if addtoDrvBtn != false
                        addtoDrvBtn.click
                        count = count +1
                        textarray <<  openedStryText
                        addtoDriveBtn_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,"Add to Drive") 
                        addtoDrvBtn = UtilsMobile.GetElementWithXpath(driver, addtoDriveBtn_xpath,40,false)
                        if addtoDrvBtn != false
                           Log.Error("Test step #{stepID}: Drive button still appearing in the page after click operation on it.") 
                           Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                           return false
                        end
                         
                              
                        if count == numofheadlines
                          break
                        else
                            doneBtnXpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,"DONE")
                            doneBtn = UtilsMobile.GetElementWithXpath(driver,doneBtnXpath, 40, false)
                            if doneBtn != false
                               doneBtn.click
                            else
                               Log.Error("Test step #{stepID}: Done button not found after click operation on add to drive.") 
                               Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                               return false
                            end  
                        end
                        
                      else
                          Log.Error("Test step #{stepID}: Add to drive button not found after opening the news headline to add to drive.") 
                          Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                          return false
                      end
                      
                  else
                     doneBtnXpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,"DONE")   
                     doneBtn = UtilsMobile.GetElementWithXpath(driver,doneBtnXpath, 40, false)
                     if doneBtn != false
                        doneBtn.click
                     else
                          Log.Error("Test step #{stepID}: Done button not found after click operation on add to drive.") 
                          Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                          return false
                     end
                  end
              else
                  Log.Error("Test step #{stepID}: No news headlines found under selected section to add to drive.") 
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                  return false
              end
			 if i == totalNewsHeadLines
				 Log.Error("Test step #{stepID}: All the news headlines are already added to the drive hence we can't proceed furthur.") 
				 Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
				 return false
			 end
          end
          return textarray
          
        
      rescue Exception => e
          Log.Error e
          return false
      end
  end
  #=========================================================================================#     
  #    FUNCTION: DisableAndSelectportfolios                                                             # 
  #                                                                                         #
  #    NOTES: Disable And  Select the portfolios/Watch lists.                                                        #
  #   one parameter is mandatory with                                                       #
  #   1st parameter being the step id .                                                     #
  #   2nd parameter being the driver object and 3rd is number of portfolios to be select.                                                #
  #                                                                                         #              
  #    RETURN: false if some exception is raised or the edit window is not opened.          #
  #=========================================================================================#
  def UtilsIphone.DisableAndSelectportfolios(stepId,driverEle=nil,totalportfolios=nil)
      begin
        Log.Utility("UtilsIphone::DisableAndSelectportfolios")
        if driverEle.nil?
          Log.Warning "Passed invalid arguments"
          return false
        end
           activatedradiobtn_xpath = EditPagePO::ActvRdioBtn_xpath
           activatedbtns = UtilsMobile.GetElementsWithXpath(driverEle,activatedradiobtn_xpath,20,false,nil,false)
           if activatedbtns.length > 0
               count = activatedbtns.length
           end
           for i in 1..count
               activatedradiobtn_xpath = EditPagePO::FirstActivRdioBtn_xpath
               activatedbtn = UtilsMobile.GetElementWithXpath(driverEle,activatedradiobtn_xpath,20,false,nil,true)
                if activatedbtn == false
                    #wndw_xpath ="//UIATableView[1]"
                    UtilsMobile.ScrollElementToVisibilty(wndw_xpath,activatedradiobtn_xpath)
                    flag = 3
                    activatedbtn = UtilsMobile.GetElementWithXpath(driverEle,activatedradiobtn_xpath,20,true,nil,true) 
                    if activatedbtn != false 
                        activatedbtn.click
                    else
                       Log.Error("Test step #{stepId}:Radio button next to portfolios/watch lists not found after perform the scrolling operation on it")
                       Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                       return false 
                    end
                else
                    activatedbtn.click
                end
           end
           activatedradiobtn_xpath = EditPagePO::ActvRdioBtn_xpath
           activatedbtns = UtilsMobile.GetElementsWithXpath(driverEle,activatedradiobtn_xpath,10,false,nil,false)
           if activatedbtns.length > 0
              Log.Error("Test step #{stepId}: Radio buttons next to the Portfolio are not disabled after click operation on it.")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
              return false
           end
           if flag == 3
               keyword = "#{flag}"
               radio_xpath = EditPagePO.Replace(EditPagePO::Radiobuttondeactivated_xpath, keyword)
               #wndw_xpath ="//UIATableView[1]"
               driver.execute_script 'mobile: scroll',toVisible: 'true',:element => find_element(:xpath,radio_xpath).ref 
               #UtilsMobile.ScrollElementToVisibilty(wndw_xpath,radio_xpath)
           end 
           array1 = []
           for i in 1..totalportfolios
               keyword = "#{i}"
               radio_xpath = EditPagePO.Replace(EditPagePO::Radiobuttondeactivated_xpath, keyword)
               radio = UtilsMobile.GetElementWithXpath(driverEle,radio_xpath, 20, false) 
               if radio != false
                   radio.click
                   radio_xpath = EditPagePO.Replace(EditPagePO::Radiobuttonactivated_xpath, keyword)
                   radio = UtilsMobile.GetElementWithXpath(driverEle,radio_xpath, 20, false)
                   if radio == false
                       Log.Error("Test step #{stepId}:Radio button next to portfolios/watch lists doesn't enabled after click on the that")
                       Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                       return false
                   end
                   text_xpath = EditPagePO.Replace(EditPagePO::Textofportfolios_xpath, keyword)
                   portfolio = UtilsMobile.GetElementWithXpath(driverEle,text_xpath,20, false)
                   if portfolio != false
                       text = portfolio.text
                       array1 << text
                   else
                       Log.Error("Test step #{stepId}: Unable to read the Text of activated radio button.")
                       Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                       return false
                   end
               else
                 Log.Error("Test step #{stepId}: Radio button not found in Portfolio contribution summary/Watch List page.")
                 Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                 return false
               end
           end 
           return array1
      rescue Exception => e
        Log.Error e
        return false
      ensure      
        Log.CloseUtility
      end
    end
################################################################################################
#  FUNCTION: EnableHomePageOptions                                                             #
#  NOTES : to enable the hme page tickers from edit window 
#   1st parameter being the step id .                                                          #
#   2nd parameter being the driver object and 3rd is ticker Name to check enabled or not .  
#                                                                                              #
################################################################################################       
  def UtilsIphone.EnableHomePageOptions(stepId,driverEle=nil,tickerName=nil)
      begin
        Log.Utility("UtilsIphone::EnableHomePageTickers")
        if driverEle.nil?
          Log.Warning "Passed invalid arguments"
          return false
        end
        if UtilsMobile.TapElementWithXpath(driverEle,IPhoneHomePagePO::Xpath_PencilButton,20,true,true,"pencil button") != false
            #Verify the editpage is appear or not
            if UtilsIphone.VerifyEditWndw(stepId,driverEle) == false
                return false
            end
        else
            return false
        end
        #check the given tickercheck mark button is enabled or not
        if tickerName == "Events Summary"
            activeradiobutton_xpath = EditPagePO::EvntSmryActvRdioBtn_xpath 
            deactiveradiobutton_xpath = EditPagePO::EvntSmryDeActvRdioBtn_xpath
        else
            activeradiobutton_xpath = EditPagePO.Replace(EditPagePO::Activate_xpath, tickerName)
            deactiveradiobutton_xpath = EditPagePO.Replace(EditPagePO::Deactivate_xpath, tickerName)
        end
        radiobutton = UtilsMobile.GetElementWithXpath(driverEle, activeradiobutton_xpath, 20, false)
        if radiobutton == false
            radiobutton = UtilsMobile.GetElementWithXpath(driverEle, deactiveradiobutton_xpath, 20, false)
            if radiobutton != false
                radiobutton.click
                radiobutton = UtilsMobile.GetElementWithXpath(driverEle, activeradiobutton_xpath, 20, false)
                if radiobutton == false
                    Log.Error("Test step #{stepId}:Radio button next to the #{tickerName} is not enable after clicked on it in edit window.")
                    Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                    return false
                end
            else
                Log.Error("Test step #{stepId}:Radio button next to the #{tickerName} is not found in edit window.")
                Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                return false 
            end
        end
        #Tap on the Done button
        if UtilsMobile.TapElementWithXpath(driverEle,EditPagePO::Done_xpath,20,true,true,"done button") == false
            return false
        end
        if UtilsCommon.WaitForElementToInvisible(driverEle,EditPagePO::Done_xpath) != false
            Log.Error("Test step #{stepId}: User not navigated to home,After click on done button.")
            Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
            return false
        end
        return true
      rescue Exception => e
        Log.Error e
        return false
      ensure      
        Log.CloseUtility
      end
  end
end
