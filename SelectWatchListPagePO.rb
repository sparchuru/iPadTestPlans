module SelectWatchListPagePO
    
    
    Watchlistwndw_xpath = "//XCUIElementTypeOther[@label='Filter Watch Lists']" #  Filter Watch List search
       
    Watchlist_xpath = "//XCUIElementTypeCell[@varData]/XCUIElementTypeStaticText"  # to  get first watch list in the page
    #SecondtWatchlist_xpath = "//XCUIElementTypeOther[@label='Filter Watch Lists']/following-sibling::XCUIElementTypeCell[2]/XCUIElementTypeStaticText"  # to  get second watch list in the page
    WatchListHeading = '//XCUIElementTypeNavigationBar[@name="FDS Navigation Bar"]//XCUIElementTypeButton[@label="@varData"]'
    def SelectWatchListPagePO.ReplaceString(xpath, replacingWord, originalWord = "@varData")
           return xpath.gsub originalWord, replacingWord
    end
end