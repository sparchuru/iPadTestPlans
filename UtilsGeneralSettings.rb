module UtilsGeneralSettings
 
#=========================================================================================#     
#  FUNCTION: LaunchHomepageSetupWizard                                                    # 
#  NOTES: Use this function to launch 'Homepage Setup Wizard' from general settings page  #
#  One parameter is mandatory with 1st parameter being the driver object.               	#
#  RETURN:false if any exception is raised or the setup wizard is not launched as expected#
#=========================================================================================#
	def UtilsGeneralSettings.LaunchHomepageSetupWizard(driverEle=nil)
  		begin
  		    deviceName=Configuration.deviceName
    			Log.Utility("UtilsGeneralSettings::LaunchHomepageSetupWizard")
    			if driverEle.nil?
    				Log.Warning "Pass invalid arguments"
    				return false
    			end
    			#Selecting 'SETTINGS' from home menu
    			if UtilsMobile.SelectFromHomeMenu(driverEle, "SETTINGS") == false
    			   return false
    			end
    			#Tapping on general settings 
    			xpath_general = SettingsPagePO.ReplaceString(SettingsPagePO::GeneralXpath,'GENERAL')
    			click_generalXpath = UtilsMobile.TapElementWithXpath(driverEle, xpath_general, 20, false)
    			if (click_generalXpath == false)
              Log.Error("'General' button is not tapped")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
              return false
          end
          #tapping on 'Launch Homepage Setup Wizard' button in general settings page
          if deviceName.include?("iPhone")
              driver.execute_script 'mobile: scroll', direction: 'down';
          end
    			btnLaunchWizardXpath = CommonObjects.ReplaceString(CommonObjects::StaticText_xpath,'Launch Home Page Wizard');
    			clickbtnLaunchWizardXpath = UtilsMobile.TapElementWithXpath(driverEle, btnLaunchWizardXpath, 20, false)
    			if (clickbtnLaunchWizardXpath == false)
              Log.Error("'Launch Home Page Wizard' button is not tapped")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
              return false
          end
    			#verify if the screen has text 'Home Page Setup' in it.
    			homepageSetupXpath = CommonObjects.ReplaceString(CommonObjects::StaticText_xpath,'Home Page Setup');
    			if UtilsMobile.GetElementWithXpath(driverEle,homepageSetupXpath, 20, false) == false
    					Log.Error("'Home Page Setup' Page does not exist")
    					Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
    					return false
    			end
    			#verify if the screen has text 'Customize your home page' in it.
    			customizehomepageXpath = CommonObjects.ReplaceString(CommonObjects::StaticText_xpath,'Customize your home page');
    			if UtilsMobile.GetElementWithXpath(driverEle,customizehomepageXpath, 20, false) == false
    					Log.Error("'Customize your home page' option does not exist")
    					Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
    					return false
    			end
    			#verify if the screen has 'right pointing arrow(NavigationTile)' image in it.
    			if UtilsMobile.GetElementWithXpath(driverEle,SettingsPagePO::NavigationtileXpath, 20, false) == false
    				Log.Error("'Tile Navigation Arrow' did not appear")
    				Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
    				return false
    			end
    			#verify if the screen has 'skip' button in it.
    			skipXpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,'Skip');
    			puts skipXpath
    			if UtilsMobile.GetElementWithXpath(driverEle,skipXpath, 20, false) == false
    					Log.Error("'Skip' button does not exist")
    					Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
    					#return false
    			end
    			#returning true when there is no error.
    			return true				
  		rescue Exception => e
    			Log.Error e
    			Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
    			return false
  		ensure			
  			 Log.CloseUtility
  		end
	end
	
#=========================================================================================#     
#   FUNCTION: VerifyOpenStory                                                  		        # 
#   NOTES: Use this function to verify an opened news story is loaded without errors and  #
#           has data in it.																                                #
#   One parameter is mandatory with 1st parameter being the driver object.               	#
#   RETURN: false if some exception is raised or the news story did not load as expected  #
#=========================================================================================#
	def UtilsGeneralSettings.VerifyOpenStory(driverEle=nil)
		begin
			Log.Utility("UtilsGeneralSettings::VerifyOpenStory")
			if driverEle.nil?
				Log.Warning "Pass invalid arguments"
				return false
			end
=begin			
			textInStoryXpath = "//UIAApplication[1]/UIAWindow[1]/UIAScrollView[1]/UIAWebView[1]/UIAStaticText"
			imageInStoryXpath = "//UIAApplication[1]//UIAWindow[1]//UIAActivityIndicator[1]"#"//UIAApplication[1]/UIAWindow[1]/UIAScrollView[1]/UIAImage"
			doneButtonXpath = "//UIAApplication[1]/UIAWindow[1]/UIANavigationBar/UIAButton[@label='DONE']"
			pdfStoryxpath = "//UIAApplication[1]/UIAWindow[1]/UIAElement[1]/UIAScrollView[@name='PDF Paging Scroll View']"
			textInStoryArr = UtilsMobile.GetElementsWithXpath(driverEle, textInStoryXpath, 30, false)
			imagesInStoryArr = UtilsMobile.GetElementsWithXpath(driverEle, imageInStoryXpath, 30, false, false)
			pdfStoryArr = UtilsMobile.GetElementsWithXpath(driverEle, pdfStoryxpath, 30, false, false)
			if textInStoryArr.length < 1

		      if imagesInStoryArr.length < 1

		          if pdfStoryArr.length < 1
        		      Log.Error("No data when story is opened with Pdf format")
                  	  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                      return false
        	      end
        	  end
            end
=end			
      xpath_errorMsg = '//*[contains(@label,"system has encountered an error in retrieving this document")]'
			errorFound = UtilsMobile.GetElementWithXpath(driverEle,xpath_errorMsg, 20, false)
			if errorFound != false
			    Log.Error("Story not opened after tap on the portfolio/watchlist.")
                Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                return false
			end
			return true
		rescue Exception => e
			Log.Error e
			Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
			return false
		ensure			
			Log.CloseUtility
		end
	end
#=========================================================================================#     
#   FUNCTION: VerifyAddPortfolioWatchlistWnd                                              # 
#   NOTES: Use this function to verify Add Portfolios/Watch Lists window is loaded  	    #
#           without errors.																                                #
#   One parameter is mandatory with 1st parameter being the driver object.               	#
#   RETURN: false if some exception is raised or the window is not load as expected 	    #
#=========================================================================================#
	def UtilsGeneralSettings.VerifyAddPortfolioWatchlistWnd(driverEle=nil)
		begin
  			Log.Utility("UtilsGeneralSettings::VerifyAddPortfolioWatchlistWnd")
  			if driverEle.nil?
  				Log.Warning "Pass invalid arguments"
  				return false
  			end
  			#checking if the text 'Add Portfolio/Watch list' exists.
  			popupTitleXpath = CommonObjects.ReplaceString(CommonObjects::StaticText_xpath,'Add Portfolio/Watch list');
  			if UtilsMobile.GetElementWithXpath(driverEle, popupTitleXpath, 20, false) == false
            Log.Error("The pop-up with title 'Add Portfolios/Watch list' is not displayed")
            Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
            return false
        end
  			#getting a few elements from the pop up and checking them
  			array = ['CANCEL','NEW']
  			for element in array
    			  wndElementsXpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,element);
    			  arrEle = UtilsMobile.GetElementWithXpath(driverEle, wndElementsXpath, 20, false)
            if arrEle == false
                Log.Error("The pop-up window Add Portfolios/Watch list does not exist")
                Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
                return false
            end
  			end
  			searchEle = UtilsMobile.GetElementWithXpath(driverEle,AddPortfolioWatchListPagePO::Search_xpath, 20, false)
        if searchEle == false
            Log.Error("Serach box not found in  Add Portfolios/Watch list Window");
            Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture");
            return false
        end
  			#checking if there are portfolios and watch lists
  			if UtilsMobile.GetElementsWithXpath(driverEle, "//XCUIElementTypeTable[1]", 20, false) == false
    				Log.Error("The pop-up window Add Portfolios/Watch list did not have any portfolios or watch lists displayed");
    				Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture");
    				return false								
  			end
  			return true
		rescue Exception => e
  			Log.Error e
  			Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
  			return false
		ensure			
			 Log.CloseUtility
		end
	end	
#=========================================================================================#     
#   FUNCTION: SelectPortfoliosAndWatchlists                                               # 
#   NOTES: Use this function to select a specific number of portfolios or watch lists in  #
#           add portfolios and watch lists window.										                    #
# 	Three parameters are mandatory 1st parameter being the driver object.                 #
#	  2nd parameter is the count of portfolios to be selected								                #
#	  3rd parameter is the count of watch lists to be selected              	  	    		  #
#   RETURN:false if some exception is raised or the portfolios or watchlist are not added #
#=========================================================================================#
	def UtilsGeneralSettings.SelectPortfoliosAndWatchlists(driverEle=nil, pCount, wCount)
  		begin
  		    platform = Configuration.platformVersion
    			Log.Utility("UtilsGeneralSettings::SelectPortfoliosAndWatchlists")
    			if driverEle.nil?
      				Log.Warning "Pass invalid arguments"
      				return false
    			end
    			#getting all table cell elements before watch lists table group		
    			if platform == "9.3" 		
    			   arrPortfolios = UtilsMobile.GetElementsWithXpath(driverEle, AddPortfolioWatchListPagePO::Portfolios_Xpath, 20, false)
    			else
    			   arrPortfolios = UtilsMobile.GetElementsWithXpath(driverEle, AddPortfolioWatchListPagePO::Portfolios10x_Xpath, 20, false)
    			end
    			arrPrtfls = Array.new 
  				if arrPortfolios.length >= pCount
  				  k = arrPortfolios.length ;
  					#tapping on first 'pCount' portfolios from the array of tablecell elements
  					(0..pCount-1).each do |i|
  					   arrPortfolios[i].click
  					   if platform == "9.3"    
  					       portfolio_xpath = SettingsPagePO.ReplaceString(AddPortfolioWatchListPagePO::Portfolio_Xpath,"#{k-i}");
  					   else
  					       portfolio_xpath = SettingsPagePO.ReplaceString(AddPortfolioWatchListPagePO::Portfolio10x_Xpath,"#{i+1}");
  					   end
  					   textEle = UtilsMobile.GetElementWithXpath(driverEle,portfolio_xpath, 20, false)
  					   arrPrtfls.push(textEle.value)
  					end
  				else
    					Log.Error("there are only #{arrPortfolios.length} portfolios in the pop-up window")
    					Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
    					return false
  				end
    			# there is possibility that the watch list elements are not on the screen and these show up when the
    			#add portfolio/watch list window is scrolled down
    	    if platform == "9.3"    
              arrWatchlists = UtilsMobile.GetElementsWithXpath(driverEle, AddPortfolioWatchListPagePO::Watchlists_Xpath, 20, false);
          else
              arrWatchlists = UtilsMobile.GetElementsWithXpath(driverEle, AddPortfolioWatchListPagePO::Watchlists10x_Xpath, 20, false)
          end
    	    arrWtchlsts = Array.new
    	    if arrWatchlists.length >= wCount
    	        if platform == "9.3"
        	        xpath_watchlist = CommonObjects.ReplaceString(CommonObjects::StaticText_xpath,'Watch lists')
                  driver.execute_script 'mobile: scroll', toVisible: 'true' ,:element => find_element(:xpath,xpath_watchlist ).ref
              else
                  watchlistXpath = AddPortfolioWatchListPagePO.ReplaceString(AddPortfolioWatchListPagePO::Watchlist10x_Xpath,"1");
                  textEle = driverEle.find_element(:xpath,watchlistXpath )
                  portfolioname = textEle.value ;
                  xpath_watchlist = CommonObjects.ReplaceString(CommonObjects::StaticText_xpath,portfolioname)
                  driver.execute_script 'mobile: scroll', toVisible: 'true' ,:element => find_element(:xpath,xpath_watchlist).ref 
              end
    	        (0..wCount-1).each do |i|
                  arrWatchlists[i].click
                  if platform == "9.3"
                      watchlistXpath = AddPortfolioWatchListPagePO.ReplaceString(AddPortfolioWatchListPagePO::Watchlist_Xpath,"#{i+1}");
                  else
                      watchlistXpath = AddPortfolioWatchListPagePO.ReplaceString(AddPortfolioWatchListPagePO::Watchlist10x_Xpath,"#{i+1}");
                  end
                  textEle = driverEle.find_element(:xpath,watchlistXpath )
                  arrWtchlsts.push(textEle.value)
               end
    	    else
    	        Log.Error("there are only #{arrWatchlists.length} watchlists in the pop-up window")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
              return false
    	    end
    			btnOkXpath = CommonObjects.ReplaceString(CommonObjects::ButtonType_xpath,'OK');
    			if UtilsMobile.TapElementWithXpath(driverEle, btnOkXpath) == false
              Log.Error("OK button is not tapped")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture")
              return false
          end  
  				#logging error if the pop up window is not closed after tapping on ok button
  				if UtilsMobile.GetElementWithXpath(driverEle,"//XCUIElementTypeTable[1]", 20, false) != false
    					Log.Error("Tapping on okay button did not close the window");
    					Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture");
    					return false
  				end
    			#creating a new hash 'returnHash'
    			returnHash = Hash.new
    			returnHash["portfolios"] = arrPrtfls
    			returnHash["watchlists"] = arrWtchlsts
    			return returnHash
  		rescue Exception => e
    			Log.Error e
    			Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot(driverEle)}", "Screencapture");
    			return false
  		ensure			
  			  Log.CloseUtility
  		end
	end
end