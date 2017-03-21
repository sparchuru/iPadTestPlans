module MarketsPagePO
    Market_xpath = "//XCUIElementTypeTable[@label='FDSMarketViewController Table']//*[@label='@varData']"
    Index_xpath = "//XCUIElementTypeTable[@label='data grid']/XCUIElementTypeOther//XCUIElementTypeStaticText"
    ColumnHdr_xpath ="//XCUIElementTypeTable[@label='column header grid']//XCUIElementTypeCell[@label='column header 0']//XCUIElementTypeStaticText"
    IpadMrktsColsData_xpath = "//XCUIElementTypeTable[@label='data grid']/XCUIElementTypeCell['@varData']/XCUIElementTypeOther[@label='DataValues']"

    def MarketsPagePO.ReplaceString(xpath, replacingWord, originalWord = "@varData")
           return xpath.gsub originalWord, replacingWord
    end
end 