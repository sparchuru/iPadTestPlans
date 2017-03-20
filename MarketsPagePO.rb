module MarketsPagePO
    Market_xpath = "//XCUIElementTypeTable[@label='FDSMarketViewController Table']//*[@label='@varData']"
    Index_xpath = "//XCUIElementTypeTable[@label='data grid']/XCUIElementTypeOther//XCUIElementTypeStaticText"
    ColumnHdr_xpath ="//XCUIElementTypeTable[@label='column header grid']//XCUIElementTypeCell[@label='column header 0']//XCUIElementTypeStaticText"
    
    #IPadColHdr_xpath = "//XCUIElementTypeTable[@label='column header grid']/UIATableCell[@label='column header 0']/UIAStaticText[@label='#{colName}']"
    
    def MarketsPagePO.ReplaceString(xpath, replacingWord, originalWord = "@varData")
           return xpath.gsub originalWord, replacingWord
    end
end 