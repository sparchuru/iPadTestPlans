module AddPortfolioWatchListPagePO
    GeneralXpath = "//XCUIElementTypeCell[@label='@varData']" 
    Search_xpath =  "//XCUIElementTypeOther[@label='Search']"
    ## iOS 9.x ####
    ScrollWatchlist_Xpath = "//XCUIElementTypeStaticText[@label='Watch lists']//ancestor::XCUIElementTypeOther[1]//following-sibling::XCUIElementTypeCell[@varData]//XCUIElementTypeStaticText[1]"
    
    #### iOS 10.x #######
    Portfolios10x_Xpath= "//XCUIElementTypeStaticText[@label='Portfolios']//ancestor::XCUIElementTypeOther[1]//following-sibling::XCUIElementTypeOther[1]//preceding-sibling::XCUIElementTypeCell"
    Portfolio10x_Xpath = "//XCUIElementTypeStaticText[@label='Portfolios']//ancestor::XCUIElementTypeOther[1]//following-sibling::XCUIElementTypeCell[@varData]//XCUIElementTypeStaticText[1]"
    Watchlists10x_Xpath= "//XCUIElementTypeStaticText[@label='Portfolios']//ancestor::XCUIElementTypeOther[1]//following-sibling::XCUIElementTypeOther[1]//following-sibling::XCUIElementTypeCell"
    Watchlist10x_Xpath = "//XCUIElementTypeStaticText[@label='Portfolios']//ancestor::XCUIElementTypeOther[1]//following-sibling::XCUIElementTypeOther[1]//following-sibling::XCUIElementTypeCell[@varData]//XCUIElementTypeStaticText[1]"     
     
     
    def AddPortfolioWatchListPagePO.ReplaceString(xpath, replacingWord, originalWord = "@varData")
           return xpath.gsub originalWord, replacingWord
    end
end