module HomePagePO
     
     
     # LoginPage 
     
      InputFieldXpath = "//XCUIElementTypeTextField[@label='@varData']"  #[@label="email or factset.net ID"]' # email field
      WrngEmailAlertXpath = '//XCUIElementTypeAlert//XCUIElementTypeStaticText[contains(@label,"invalid email address")]'
      SerlNumFildXpath = '//XCUIElementTypeTextField[@label="Serial"]'
      PwdFildXpath = "//XCUIElementTypeStaticText[@label = '@varData']//following-sibling::XCUIElementTypeSecureTextField"
      AppUpdtePromt = "//XCUIElementTypeAlert[@label='App Upgrade Prompt']"
     
     UpdtePrmptRmdLtrBtn = "//XCUIElementTypeAlert[@label='App Upgrade Prompt']//XCUIElementTypeButton[@label='Remind me later']"
     UpdtePrmptOkBtn = "//XCUIElementTypeAlert[@label='App Upgrade Prompt']//XCUIElementTypeButton[@label='OK']"
     
     PageIndicatorXpath = "//XCUIElementTypePageIndicator[@value='@varData']"
     PageIndicatorValXpath = "//XCUIElementTypePageIndicator[1]"
     TutorialXpath = "//XCUIElementTypeImage[contains(@name,'@varData')]"
     CustmizXpath = "//XCUIElementTypeStaticText[contains(@label,'Home Page Setup')]" 
     
     AppLoadingXpath = "//*[@name='Network connection in progress'][1]"
     # Home Page 
     ButtontypeXpath = "//XCUIElementTypeButton[@label='@varData']"  # buttons in the page
     HamBurger_xpath = "//XCUIElementTypeButton[@label='Navigation list']" 
     
     HamburgerMenuBtns_xpath = "//XCUIElementTypeButton[@label='@varData']"  # to get the ref of all the buttons after click on hamburger
     HamburgerMenuTxtBtns_xpath = "//XCUIElementTypeTable[@label='Home menu']//XCUIElementTypeCell[@label = '@varData']"
     StaticTxtFldXpath = "//XCUIElementTypeStaticText[@label='@varData']"
     
     Watchlist_xpath = "//XCUIElementTypeStaticText[@label='WATCH LISTS']" # Watch List after click on Hamburger
     
     
     
     
     
     
     
     
     #Watchlistwndw_xpath = "//XCUIElementTypeOther[@label='Filter Watch Lists']" #  Filter Watch List search  moved to selectwatclist
      #"//UIASearchBar[@label='Select a Watch List']"  # "//UIAElement[@label='Filter Watch Lists']" # 
     #FirstWatchlist_xpath = "//UIAElement[@label='Filter Watch Lists']/following-sibling::UIATableCell[1]/UIAStaticText" moved to selectwatclist
     #SecondtWatchlist_xpath = "//UIAElement[@label='Filter Watch Lists']/following-sibling::UIATableCell[2]/UIAStaticText" moved to selectwatclist
     WatcListInHome_xpath = "//UIAStaticText[@label='@varData']" 
     WatcListBtnInHome_xpath = "//UIAButton[@label='More']"
     SelectWatcList_xpath = "//UIAStaticText[@label='Select or Edit a Watch List']"
     BtnsInWatchlistPage_xpath = "//*[contains(@label,'@varData')]"
     NewsTab_xpath = "//UIAButton[@label='NEWS']"
     NewsHeadlineUndrNews_xpath = '//UIATableView[@label="FDSNewsHeadlinesTableViewController"]/UIATableCell[1]'
     FirstNewsHeadlineUndrNews_xpath = '//UIATableView[@label="FDSNewsHeadlinesTableViewController"]/UIATableCell[1]'
     FirstNewsHeadlineUndrNewsText_xpath = '//UIATableView[@label="FDSNewsHeadlinesTableViewController"]/UIATableCell[1]/UIAStaticText[2]'
     
     FactsetDrive_xpath = '//UIAStaticText[@label="FACTSET DRIVE"]'
     AllTab_xpath = "//UIAButton[@label='ALL']"
     ResearchTab_xpath = "//UIAButton[@label='RESEARCH']"
     NewsHeadlineUndrResearchTab_xpath = '//UIATableView[@label="FDSNewsHeadlinesTableViewController"]/UIATableCell[1]'
     NewsHeadlineUndrResrch_xpath = '//UIATableView[@label="FDSNewsHeadlinesTableViewController"]/UIATableCell[1]'
     ReadNewsHeadlinesText ='//UIATableView[@label="FDSNewsHeadlinesTableViewController"]/UIATableCell[1]/UIAStaticText[2]'
     AlertXpath = '//UIAAlert'
     AlertOkBtn_xpath = '//UIAButton[@label="OK"]'
     BtnsInHmePage_xpath ="//UIAButton[@label='@varData']"
     SearchBar_xpath = "//UIASearchBar[@label='Company Name or Symbol']/UIASearchBar"
     SearchBar_xpathiOS8 = "//UIASearchBar[@value='Company Name or Symbol']/UIASearchBar"
     FdsUsInsearch_xpath ="//UIAStaticText[@label='FDS-US']/preceding-sibling::UIAStaticText[@label='FactSet Research Systems Inc.']"
     HelpIcon_xpath = '//UIAButton[@label="Company detail page"]'
     HelpAssistant_xpath = "//UIAStaticText[@label='@varData']"
    def HomePagePO.ReplaceString(xpath, replacingWord, originalWord = "@varData")
           return xpath.gsub originalWord, replacingWord
    end
end