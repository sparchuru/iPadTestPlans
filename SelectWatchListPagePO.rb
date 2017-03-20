module SelectWatchListPagePO
    
    
    Watchlistwndw_xpath = "//XCUIElementTypeOther[@label='Filter Watch Lists']" #  Filter Watch List search
       
    FirstWatchlist_xpath = "//XCUIElementTypeOther[@label='Filter Watch Lists']/following-sibling::XCUIElementTypeCell[1]/XCUIElementTypeStaticText"  # to  get first watch list in the page
    SecondtWatchlist_xpath = "//XCUIElementTypeOther[@label='Filter Watch Lists']/following-sibling::XCUIElementTypeCell[2]/XCUIElementTypeStaticText"  # to  get second watch list in the page
    
    
    def HomePagePO.ReplaceString(xpath, replacingWord, originalWord = "@varData")
           return xpath.gsub originalWord, replacingWord
    end
end