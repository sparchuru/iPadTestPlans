require File.expand_path(File.dirname(__FILE__) + '/UtilsAll.rb')
$portfolioInHomePage = 1
#==================================== UtilsiPadHome ======================================#
#       Here you will find utility functions for ipad home test cases                     #
#                                                                                         #          
#=========================================================================================# 

module UtilsiPadHome
    
#========================================================================================#
#    FUNCTION: Delete Tile from home                                                     #
#    NOTES: Use this function to Delete Tile from home                                   #
#    RETURN: true if exisists else false.                                                #
#========================================================================================#
  def UtilsiPadHome.DeleteTileFromHome(stepID=nil,driver=nil,xpath_tile=nil,xpath_tileClose=nil,waitTime = 20)
      begin
          Log.Utility("UtilsiPadHome::DeleteTileFromHome")
          #return if driver and xpath parameters are not passed 
          if driver.nil? || xpath_tile.nil? ||stepID.nil? ||xpath_tileClose.nil? then
              Log.Warning "pass in valid arguments"
              return false
          end  
          # Verify if tile  is already added and found in the home, delete and proceed
          tileInHome = UtilsMobile.SwipePagesForElement(driver, xpath_tile)
		      tileInHome = UtilsMobile.GetElementWithXpath(driver, xpath_tile,20,false)
          if tileInHome != false
              #Tap on the pencil (edit) button
              $portfolioInHomePage = 1
              xpath_pencilButton = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,'Edit tile');
              pencilIcon = UtilsMobile.GetElementWithXpath(driver, xpath_pencilButton,20,false)
              if pencilIcon != false
                  pencilIcon.click   
              else
                  Log.Error("Test step #{stepID}: Pencil(Edit) button was not found on the home page.") 
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                  return false  
              end
          end 
          # execute the below step if the watch list summary is available in the home page 
          if $portfolioInHomePage == 1    
              # Verify that the EDIT page option appears
              #Tap on the X icon (delete)next to Watch list Summary
              closeButton = UtilsMobile.GetElementWithXpath(driver, xpath_tileClose,20,false)
              if closeButton != false
                  closeButton.click   
              else
                  Log.Error("Test step #{stepID}: X icon(delete or close) button was not found next to Watch list Summary.") 
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                  return false  
              end 
              # Verify if the page have any other tiles in the home page after delete the watch list summary
              anyTilesInPage = UtilsMobile.GetElementsWithXpath(driver, IPadEditPagePO::Xpath_anyTilesInPage,20,false)
              if anyTilesInPage.length > 0
                  # Tap on check mark symbol
                  xpath_checkMarkButton = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,'Done Q');
                  checkMarkButton = UtilsMobile.GetElementWithXpath(driver, xpath_checkMarkButton,20,false)
                  if checkMarkButton != false
                     checkMarkButton.click   
                  else
                     Log.Error("Test step #{stepID}: Check Mark button is not found in the page to click after delete the Watch list summary tile.") 
                     Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                     return false
                  end
              end   
              # Verify that the deleted tile is removed from the home page
              tileInHome = UtilsMobile.SwipePagesForElement(driver, xpath_tile)
			        tileInHome = UtilsMobile.GetElementWithXpath(driver, xpath_tile,20,false)
              if tileInHome != false
                  Log.Error("Test step #{stepID}: Removed tile is found in the home page after removed.") 
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                  return false  
              end
          end 
      rescue Exception => e
          Log.Error e
          return false
      end
    end  
#========================================================================================#
#    FUNCTION: SelectTile                                                                #
#    NOTES: Use this function to select Tile                                             #
#    RETURN: true if exisists else false.                                                #
#========================================================================================#
  def UtilsiPadHome.SelectTile(stepID=nil,driver=nil,xpath_tile=nil,tileType = nil,waitTime = 20)
      begin  
          Log.Utility("UtilsiPadHome::SelectTile")
          #return if driver and xpath parameters are not passed 
          if driver.nil? || tileType.nil? || stepID.nil? then
              Log.Warning "pass in valid arguments"
              return false
          end
          if xpath_tile != nil
              if UtilsMobile.SelectFromHomeMenu(driver, "HOME") == false
                 Log.Error("Test step #{stepID}: There was an error while clicking on Home button") 
                 return false
              end
              #Tap on the + sign(add tile) button on the top right
              xpath_plusSign = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,'Add tile');
              plusSign = UtilsMobile.TapElementWithXpath(driver, xpath_plusSign)
              if plusSign == false
                  Log.Error("Test step #{stepID}: The + sign(add tile) button on the top right was not found after click operation on Home button.") 
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                  return false   
              end 
              # Select the Watch list Summary from the list and "Small" tile 
              driver.execute_script 'mobile: scroll', toVisible: 'true' ,:element => find_element(:xpath,xpath_tile).ref 
              tileSelected = UtilsMobile.TapElementWithXpath(driver, xpath_tile)
              if tileSelected == false
                 Log.Error("Test step #{stepID}: Expected tile was not found after click operation on the + sign(add tile) button on the top right.") 
                 Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                 return false 
              end   
              # Verify given tile is selected after click operation on it.
              xpath_smallTile = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,tileType);
              smallTile = UtilsMobile.GetElementWithXpath(driver, xpath_smallTile,20,false)
              if smallTile != false
                  smallTile.click
                  # Veirfy the tile is selected
                  xpath_smallTile = AddTileWindowPO.ReplaceString(AddTileWindowPO::Xpath_TileTypeActivated,tileType);
                  smallTile = UtilsMobile.GetElementWithXpath(driver, xpath_smallTile,20,false)
                  if smallTile == false
                      Log.Error("Test step #{stepID}: #{tileType} tile was not  selected after select operation on it.") 
                      Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                      return false
                  end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
              else
                  Log.Error("Test step #{stepID}: #{tileType} tile was not found in tile options window.") 
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                  return false
              end
           else   
               # Verify given tile is selected after click operation on it.
               xpath_smallTile = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,tileType);
               smallTile = UtilsMobile.GetElementWithXpath(driver, xpath_smallTile,20,false)
               if smallTile != false
                    smallTile.click
                    # Veirfy the tile is selected
                    xpath_smallTile = AddTileWindowPO.ReplaceString(AddTileWindowPO::Xpath_TileTypeActivated,tileType);
                    smallTile = UtilsMobile.GetElementWithXpath(driver, xpath_smallTile,20,false)
                    if smallTile == false
                        Log.Error("Test step #{stepID}: #{tileType} tile was not  selected after select operation on it.") 
                        Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                        return false
                    end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
                else
                    Log.Error("Test step #{stepID}: #{tileType} tile was not found in tile options window.") 
                    Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                    return false
                end
           end          
      rescue Exception => e
          Log.Error e
          Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
          return false
      end
    end
    
#========================================================================================#
#    FUNCTION: AddNewsHeadLinesToDrive                                                   #
#    NOTES: Use this function to open news and added to drive which was not added already#
#    RETURN: return false if any thing goes wrong.                                       #
#========================================================================================#
  def UtilsiPadHome.AddNewsHeadLinesToDrive(stepID=nil,driver=nil,numofheadlines = nil)
      begin  
           if driver.nil? || numofheadlines.nil?  then
              Log.Warning "pass in valid arguments"
              return false
           end
           deviceName=Configuration.deviceName
           if deviceName.include?("iPhone")
               xpath_delete = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,'Delete');
               addtoDriveBtn_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,'Add to Drive');
           else
               xpath_delete = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,'delete');
               addtoDriveBtn_xpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,'Docvault');
           end
           doneBtnXpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,'DONE');   
           textarray = []
           count = 0
           newsHdLinesFound = UtilsMobile.GetElementsWithXpath(driver,WatchlistPagePO::NewsHeadlines_xpath,20,false)
           if newsHdLinesFound.length > 0
               totalNewsHeadLines = newsHdLinesFound.length
           else
               Log.Error("Test step #{stepID}: No news headlines found under selected section to add to drive.") 
               Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
               return false
           end
           for i in 1..totalNewsHeadLines
               openedStryText =  newsHdLinesFound[i-1].label
               newsHdLinesFound[i-1].click
               UtilsGeneralSettings.VerifyOpenStory(driver)
               addtoDrvBtn = UtilsMobile.GetElementWithXpath(driver, addtoDriveBtn_xpath,20,false)
               if addtoDrvBtn != false
                   addtoDrvBtn.click
                   count = count +1
                   textarray <<  openedStryText
                   addtoDrvBtn = UtilsMobile.GetElementWithXpath(driver, addtoDriveBtn_xpath,20,false)
                   if addtoDrvBtn != false
                      Log.Error("Test step #{stepID}: Drive button still appearing in the page after click operation on it.") 
                      Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                      return false
                   end
                   if count == numofheadlines
                       break
			             else
                       doneBtn = UtilsMobile.GetElementWithXpath(driver,doneBtnXpath, 20, false)
                       if doneBtn != false
                          doneBtn.click
                       else
                          Log.Error("Test step #{stepID}: Done button not found in page.") 
                          Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                          return false
                       end
                   end
               else
                  deltedBtn = UtilsMobile.GetElementWithXpath(driver, xpath_delete,20,false)
                  if deltedBtn == false
                      Log.Error("Test step #{stepID}: delete button not found in Page.") 
                      Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                      return false
                  end
                  doneBtn = UtilsMobile.GetElementWithXpath(driver,doneBtnXpath, 20, false)
                  if doneBtn != false
                      doneBtn.click
                  else
                      Log.Error("Test step #{stepID}: Done button not found in page.") 
                      Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                      return false
                  end
               end
           end
           if i == totalNewsHeadLines
               Log.Error("Test step #{stepID}: All the news headlines are already added to the drive hence we can't proceed furthur.") 
               Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
               return false
           end
           return textarray
      rescue Exception => e
          Log.Error e
          return false
      end
  end
#========================================================================================#
#    FUNCTION: Delete All Tiles from home                                                #
#    NOTES: Use this function to Delete All Tiles from home                              #
#    RETURN: true if exisists else return false if any exception rise.                   #
#========================================================================================#
  def UtilsiPadHome.DeleteAllTilesFromHome(stepID=nil,driver=nil)
      begin
          Log.Utility("UtilsiPadHome::DeleteAllTilesFromHome")
          #return if driver and xpath parameters are not passed 
          if driver.nil? ||stepID.nil? then
              Log.Warning "pass in valid arguments"
              return false
          end 
          anyTilesInPage = UtilsMobile.GetElementsWithXpath(driver, IPadEditPagePO::Xpath_anyTilesInPage,20,false)
          if anyTilesInPage.length > 0 
              xpath_editEnabled = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,'Edit tile');
              editEnabled = UtilsMobile.GetElementWithXpath(driver,xpath_editEnabled,20,false)
              if editEnabled != false
                  editEnabled.click
                  #Check Edit Page is Appera or not
                  xpath_delteTiles = IPadEditPagePO.ReplaceString(IPadEditPagePO::Xpath_delteTiles,"Delete Q");
                  deleteTiles = UtilsMobile.GetElementsWithXpath(driver, xpath_delteTiles,20,false)
                  length = deleteTiles.count
                  while(length > 0)
                      xpath_delteTile = IPadEditPagePO.ReplaceString(IPadEditPagePO::Xpath_delteTiles,"Close");
                      deleteTile = UtilsMobile.GetElementsWithXpath(driver, xpath_delteTile,20,false)
                      if deleteTile.length > 0
                          deleteTile[0].click
                      else
                          xpath_delteTile = IPadEditPagePO.ReplaceString(IPadEditPagePO::Xpath_delteTiles,"Delete Q");
                          deleteTile = UtilsMobile.GetElementsWithXpath(driver, xpath_delteTile,20,false)
                          if deleteTile.count > 0
                              deleteTile[0].click
                          else
                						  Log.Error("Test step #{stepID}: Close button not found for tile in Edit page.") 
                						  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driver)}", "Screencapture")
                						  return false
                          end
                      end
    				          xpath_delteTiles = IPadEditPagePO.ReplaceString(IPadEditPagePO::Xpath_delteTiles,"Delete Q");
                      deleteTiles = UtilsMobile.GetElementsWithXpath(driver, xpath_delteTiles,20,false)
                      length = deleteTiles.count
                  end
              end
              return true
	      else
		      return true
        end
      rescue Exception => e
          Log.Error e
          return false
      end
    end   
end