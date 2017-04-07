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

    def HomePagePO.ReplaceString(xpath, replacingWord, originalWord = "@varData")
           return xpath.gsub originalWord, replacingWord
    end
end
