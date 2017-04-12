module NewsPagePO
  
  #Xpath_btnsInWatchlistPage = "//*[contains(@label,'@varData')]"
  FactsetDrive_xpath = "//UIAStaticText[@label='FACTSET DIRVE']"
  DoneBtnInStoryPage_xpath = '//UIAButton[@label="DONE"]'
  AllTab_xpath = '//UIAButton[@label="ALL"]'
  StoryUnderAlltab_xpath = "//UIAStaticText[@label='@varData']"
  #OpenedStryText_xpath="//"
  AddtoDriveBtn_xpath = "//UIAButton[@label='Docvault']" 
  #AddedtoDrivePopup_xpath = ''
  OkBtnInPopup_xpath = '//UIAButton[@label="OK"]'
  FstNewsHdLineUndrSection = '//XCUIElementTypeTable[@label="FDSNewsHeadlinesTableViewController"]//XCUIElementTypeCell[1]'
def NewsPagePO.ReplaceString(xpath, replacingWord, originalWord = "@varData")
           return xpath.gsub originalWord, replacingWord
    end
end