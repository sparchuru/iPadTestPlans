#require File.expand_path(File.dirname(__FILE__) + '/UtilsAll.rb')
module UtilsMobile_Markets
#=========================================================================================#     
#    FUNCTION: TapMarketAndVerifyPage                                                     # 
#                                                                                         #
#    NOTES: Use this function to tap an element with the given MarketName and             #
#                    verify Market Page is loaded are not.                                #
# Four parameters are mandatory with parameter 1st being the driver object,               #
# 2nd being the MarketName to tap on particular Market, 3rd being the headingName         #
#             to check heading of the Market tapped,  4th being indexArrayExpected        # 
#             to check indices in the Market tapped                                       #              
#    RETURN: false if some exception is raised                                            #
#            true if everything goes well                                                 #
#=========================================================================================#

def UtilsMobile_Markets.TapMarketAndVerifyPage(driverEle=nil, marketName=nil, headingName=nil, indexArrExp=nil)
  begin
      Log.Utility("UtilsMobile_Markets::TapMarketAndVerifyPage")
      if driverEle.nil? || marketName.nil? || headingName.nil? || indexArrExp.nil? then
          Log.Warning "Pass valid arguments"
          return
      end
      xpath =  MarketsPagePO.ReplaceString(MarketsPagePO::Market_xpath, marketName) 
      if UtilsMobile.TapElementWithXpath(driverEle, xpath,60) != false
          headingXpath = CommonObjects.ReplaceString(CommonObjects::StaticText_xpath, marketName) 
          headingElement = UtilsMobile.GetElementWithXpath(driverEle, headingXpath,30)
          if headingElement != false
              titleValue = headingElement.value
              if titleValue != headingName
                  Log.Error("Expected titlename #{headingName} is not same as  #{titleValue} ")
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
                  return false
              end
          else
              Log.Error("HeadingXpath for #{headingName} is not found")
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
              return false
          end
          #indexXpath = 
          if UtilsMobile.VerifyArray(driverEle, MarketsPagePO::Index_xpath, indexArrExp) == false
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
              return false
          end
         #columnXpath = 
          columnArrExp = ["ID","Last","Chg","%","1W %","3M %","YTD %"]
          if UtilsMobile.VerifyArray(driverEle, MarketsPagePO::ColumnHdr_xpath, columnArrExp) == false
              Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
              return false
          end
      else
          Log.Error("Xpath for #{headingName} not found to tap")
          Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
          return false
      end
      return true
  rescue Exception => e
      Log.Error e
      return false
  ensure
      Log.CloseUtility  
  end
 end
 #=========================================================================================#     
#    FUNCTION: IpdMarketDataSort                                                             # 
#                                                                                         #
#    NOTES: Use this function to tap on given column in the given market                  #
#                 and verify that the data present under that column is sorting or not    #
#   Four parameters are mandatory with parameter 1st being the driver object,             #
#   2nd being the MarketName, 3rd being the column Name to tap on it, 4th being number    #
#             of rows under that column                                                   # 
#    NOTE: rowsNo parameter is taken from first Index except in Sector ETFs Market        #             
#    RETURN: false if some exception is raised                                            #
#            true if everything goes well                                                 #
#=========================================================================================#

def UtilsMobile_Markets.IpdMarketDataSort(driverEle=nil, marketName=nil, colName=nil, rowsNo=nil, deviceName=Configuration.deviceName)
   begin 
       Log.Utility("UtilsMobile_Markets::MarketDataSort")
       if driverEle.nil? || marketName.nil? || colName.nil? || rowsNo.nil?
           Log.Warning("Enter valid arguments")
       end
       colXpath = CommonObjects.ReplaceString(CommonObjects::StaticText_xpath, colName)
       if colName == "YTD %" ||colName == "3M %" || colName == "1W %" && deviceName.include?("iPhone")
               driver.execute_script 'mobile: scroll', direction: 'right'
       end
       if UtilsMobile.TapElementWithXpath(driverEle, colXpath, 20, true, true)
          xpath = CommonObjects.ReplaceString(CommonObjects::StaticText_xpath, "Last")
         # As scrollTo is screwing up finding data values under YTD column again scrollback to first column
           
           xpathArr = Array.new
           for i in 1..15
               xpath = MarketsPagePO.ReplaceString(MarketsPagePO::IpadMrktsColsData_xpath, "#{i}") 
               xpathArr.push(xpath)
           end       
           floatDataArr = UtilsMobile_Markets.GetMarketDataArr(driverEle, marketName, colName, rowsNo, xpathArr)
           # comparing array elements to check their order
           for i in 0..(floatDataArr.length) - 2
               if floatDataArr[i] < floatDataArr[i+1]
                   Log.Error("Elements of #{id} for #{marketName} are not in descending order")
                   Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
                   return false
               end
           end
       else
           Log.Error("Column #{colName} for #{marketName} is not tapped")
           Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
           return false
       end
       colXpath = CommonObjects.ReplaceString(CommonObjects::StaticText_xpath, colName) 
       if UtilsMobile.TapElementWithXpath(driverEle, colXpath, 20, true, true)
         # As scrollTo is screwing up finding data values under YTD column again scrollback to first column
           # if colName == "YTD %" && deviceName.include?("iPhone")
                # xpath = CommonObjects.ReplaceString(CommonObjects::StaticText_xpath, "Last")
                # driver.execute_script "mobile: scroll", :element => find_element(:xpath, xpath).ref   
           # end
           xpathArr = Array.new
           for i in 1..15
               xpath = MarketsPagePO.ReplaceString(MarketsPagePO::IpadMrktsColsData_xpath, "#{i}") 
               xpathArr.push(xpath)
           end
           floatArr = UtilsMobile_Markets.GetMarketDataArr(driverEle, marketName, colName, rowsNo, xpathArr)
           #comparing array elements to check their order
           for i in 0..(floatArr.length) - 2
               if floatArr[i] > floatArr[i+1]
                   Log.Error("Elements of #{id} for #{marketName} are not in ascending order")
                   Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
                   return false
               end
           end
       else
           Log.Error("Column #{colName} for #{marketName} is not tapped")
           return false
       end
       return true
   rescue Exception => e
       Log.Error e
       return false
   ensure
       Log.CloseUtility
   end
 end
#=========================================================================================#     
#    FUNCTION: MarketDataSort                                                             # 
#                                                                                         #
#    NOTES: Use this function to tap on given column in the given market                  #
#                 and verify that the data present under that column is sorting or not    #
#   Four parameters are mandatory with parameter 1st being the driver object,             #
#   2nd being the MarketName, 3rd being the column Name to tap on it, 4th being number    #
#             of rows under that column                                                   # 
#    NOTE: rowsNo parameter is taken from first Index except in Sector ETFs Market        #             
#    RETURN: false if some exception is raised                                            #
#            true if everything goes well                                                 #
#=========================================================================================#

def UtilsMobile_Markets.MarketDataSort(driverEle=nil, marketName=nil, colName=nil, rowsNo=nil, deviceName=Configuration.deviceName)
   begin 
       Log.Utility("UtilsMobile_Markets::MarketDataSort")
       if driverEle.nil? || marketName.nil? || colName.nil? || rowsNo.nil?
           Log.Warning("Enter valid arguments")
       end
       col_Xpath = CommonObjects.ReplaceString(CommonObjects::StaticText_xpath, colName)
       platform = Configuration.platformVersion
       if colName == "YTD %" ||colName == "3M %" || colName == "1W %" && deviceName.include?("iPhone")
               driver.execute_script 'mobile: scroll', direction: 'right'
       end
       #entering "Test Grouping" in the text box of the dialog
       UtilsMobile.TapElementWithXpath(driverEle, col_Xpath, 20, true, true)
       
       xpathArr = Array.new
       for i in 1..15
           xpath = MarketsPagePO.ReplaceString(MarketsPagePO::IpadMrktsColsData_xpath, "#{i}")
           xpathArr.push(xpath)
       end       
       floatDataArr = UtilsMobile_Markets.GetMarketDataArr(driverEle, marketName, colName, rowsNo, xpathArr)
      
       for i in 0..(floatDataArr.length) - 2
         if   floatDataArr[i] == "-"
              i = i+1
         else
             if floatDataArr[i] < floatDataArr[i+1]
                 Log.Error("Elements of #{id} for #{marketName} are not in descending order")
                 Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
                 return false
             end
         end  
       end
      
       
       col_Xpath = CommonObjects.ReplaceString(CommonObjects::StaticText_xpath, colName)
       UtilsMobile.TapElementWithXpath(driverEle, col_Xpath, 20, true, true)
       
       xpathArr = Array.new
       for i in 1..15
           xpath = MarketsPagePO.ReplaceString(MarketsPagePO::IpadMrktsColsData_xpath, "#{i}")
           xpathArr.push(xpath)
       end
       floatArr = UtilsMobile_Markets.GetMarketDataArr(driverEle, marketName, colName, rowsNo, xpathArr)
       #comparing array elements to check their order
       for i in 0..(floatArr.length) - 2
         if floatDataArr[i] == "-"
             i =i+1
         else
           if floatArr[i] > floatArr[i+1]
               Log.Error("Elements of #{id} for #{marketName} are not in ascending order")
               return false
           end
         end   
       end
       
       return true
   rescue Exception => e
       Log.Error e
       return false
   ensure
       Log.CloseUtility
   end
 end
#=========================================================================================#     
#    FUNCTION: GetMarketDataArr                                                           # 
#                                                                                         #
#    NOTES: Use this function to get the data array from the Market Data                  #
#   five parameters are mandatory with parameter 1st being the driver object,             #
#   2nd being the MarketName, 3rd being the column Name under which we need to retrieve   #
#                     data, 4th being number of rows under that column, 5th being the     #
#                     xpath array to get the data from those locations                    # 
#    NOTE: rowsNo parameter is taken from first Index except in Sector ETFs Market        #             
#    RETURN: false if some exception is raised                                            #
#            true if everything goes well                                                 #
#=========================================================================================#

def UtilsMobile_Markets.GetMarketDataArr(driverEle, marketName, colName, rowsNo, xpathArr)
  begin
      Log.Utility("UtilsMobile_Markets::GetMarketDataArr")
      if driverEle.nil? || marketName.nil? || colName.nil? || rowsNo.nil? || xpathArr.nil?
          Log.Warning("Enter valid arguments")
      end
      dataArrAct = Array.new
      if marketName == "Sector ETFs"
          for i in 9..(rowsNo)-1 
              dataEle = UtilsMobile.GetElementWithXpath(driverEle, xpathArr[i])
              if dataEle != false
                  datavalue = dataEle.value
                  a,last,b,chg,var,var1W,var3M, *ytd = datavalue.split(/, /)
                  case colName 
                    when "Last"
                        a=last.gsub(",","")
                        dataArrAct.push(a)
                    when "1W %"
                        dataArrAct.push(var1W)
                    when "YTD %"
                        dataArrAct.push(ytd)
                    when "Chg"
                        dataArrAct.push(chg)
                    when "%"
                        dataArrAct.push(var)
                    when "3M %"
                        dataArrAct.push(var3M)
                    else
                        Log.Error("Invalid column id")
                        return false
                    end 
              else  
                  Log.Error("Xpath of data rows for #{marketName} not found") 
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
                  return false
              end 
          end
      else 
          for i in 0..(rowsNo)-1
              dataEle = UtilsMobile.GetElementWithXpath(driverEle, xpathArr[i])
              if dataEle != false
                  datavalue = dataEle.value
                  a,last,b,chg,var,var1W,var3M, *ytd = datavalue.split(/, /)
                  case colName 
                    when "Last"
                        a=last.gsub(",","")
                        dataArrAct.push(a)
                    when "1W %"
                        dataArrAct.push(var1W)
                    when "YTD %"
                        dataArrAct.push(ytd)
                    when "Chg"
                        dataArrAct.push(chg)
                    when "%"
                        dataArrAct.push(var)
                    when "3M %"
                        dataArrAct.push(var3M)
                    else
                        Log.Error("Invalid column id")
                        return false
                    end 
              else  
                  Log.Error("Xpath of data rows for #{marketName} not found")
                  Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
                  return false
              end 
          end
      end 
      floatArr = Array.new
      # converting strings array into float array
      if colName != "YTD %"
          for i in 0..(dataArrAct.length - 1)
              floatArr.push(dataArrAct[i].to_f)
          end
      else
          for i in 0..(dataArrAct.length - 1)
              dataArrAct[i].each{|e|
                floatArr.push(e.to_f)     
              }
          end
      end  
      return floatArr
 
  rescue Exception => e
      Log.Error e
  ensure
      Log.CloseUtility
  end           
end

#=========================================================================================#     
#    FUNCTION: VerifyExpansion                                                            # 
#                                                                                         #
#   NOTES:Use this function to check data under Index is expanded/collapsed when tap on it#
#   Three parameters are mandatory with parameter 1st being the driver object,            #
#   2nd being the Index Name, 3rd being the data under the Index to                       #
#                     verify Index Expansion/Collapsion by checking it's presence         #             
#    RETURN: false if some exception is raised                                            #
#            true if everything goes well                                                 #
#=========================================================================================#

 def UtilsMobile_Markets.VerifyExpansion(driverEle=nil,indexName=nil,data=nil  )
   begin
       Log.Utility("UtilsMobile_Markets::VerifyExpansion")
       if driverEle.nil? || indexName.nil? || data.nil? then
           Log.Warning("Pass valid arguments")
       end
       xpath = CommonObjects.ReplaceString(CommonObjects::StaticText_xpath, indexName) #"//UIAApplication[1]/UIAWindow/UIATableView[@label='data grid']//UIAStaticText[@value='#{indexName}']"
       checkDataXpath = CommonObjects.ReplaceString(CommonObjects::StaticText_xpath, data)#"//XCUIElementTypeTable[@label='data grid']/XCUIElementTypeCell"
       checkData = UtilsMobile.GetElementWithXpath(driverEle, checkDataXpath, 5, false)
       if checkData != false
           Log.Error("Indices Sections did not collapse after long tap")
           Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
           return false
       end
       #driver.execute_script "mobile: scrollTo", :element => find_element(:xpath, xpath).ref
       if UtilsMobile.TapElementWithXpath(driverEle, xpath) != false
           dataXpath = CommonObjects.ReplaceString(CommonObjects::StaticText_xpath, data) # "//UIAApplication[1]/UIAWindow/UIATableView[@label='data grid']//UIAStaticText[@label='#{data}']"
           dataElement = UtilsMobile.GetElementWithXpath(driverEle, checkDataXpath, 20, false)
           if dataElement == false
               Log.Error("#{indexName} is not expanded after tapping it")
               Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
               return false
           end
       else
           Log.Error("#{indexName} is not tapped")
           return false
       end  
       return true
   rescue Exception => e
       Log.Error e
       return false
   ensure
       Log.CloseUtility
   end
 end
 
#=========================================================================================#     
#    FUNCTION: MarketIndicesSort                                                          # 
#                                                                                         #
#   NOTES: Use this function to check Indices under Id column are getting sorted when tap #
#                                     on the column.                                      #
#   One mandatory Parameter is driver Object                                              #             
#    RETURN: false if some exception is raised                                            #
#            true if everything goes well                                                 #
#=========================================================================================#
 
def UtilsMobile_Markets.MarketIndicesSort(driverEle)
  begin
      Log.Utility("UtilsMobile_Markets::MarketIndicesSort")
      if driverEle.nil?
          Log.Warning "Enter valid arguments"
      end
      #indexXpath = "//UIAApplication[1]/UIAWindow[1]/UIATableView[@label='data grid']/UIATableGroup/UIAStaticText"
      #indexXpath = "//UIAApplication[1]/UIAWindow[1]/UIATableView[@label='data grid']/UIATableGroup/UIAStaticText"
      
      indexArrActual = Array.new
      indexElements = UtilsMobile.GetElementsWithXpath(driverEle, MarketsPagePO::Index_xpath, 20, false) #driverEle.elements(:xpath => MarketsPagePO::Index_xpath)#UtilsCommon.GetElementsWithXpath(driverEle, indexXpath,20,false)
      if indexElements != false
          for data in indexElements
            indexArrActual.push(data.value)
          end
      else
          Log.Error("IndexXpath is not found")
          Log.Picture("#{UtilsMobile.TakeSimulatorScreenshot()}", "Screencapture")
          return false
      end
      idXpath = CommonObjects.ReplaceString(CommonObjects::StaticText_xpath, 'ID')
      if UtilsMobile.TapElementWithXpath(driverEle, idXpath) != false
          indexArr = Array.new
          indexElements = UtilsMobile.GetElementsWithXpath(driverEle, MarketsPagePO::Index_xpath)
          if indexElements != false
              for data in indexElements
                indexArr.push(data.value)
              end
              # checking the order of elements
              if (indexArr == indexArrActual.sort{|j,k| k<=>j and k.upcase<=>j.upcase}) != true
                  Log.Error("Data under ID column is not in descending order")
                  return false
              end
          else
              Log.Error("Index Xpath is not found")
              return false
          end
      else
          Log.Error("Id column is not tapped")
          return false
      end
      # again tapping and checking they are in ascending order or not            
      if UtilsMobile.TapElementWithXpath(driverEle, idXpath) != false
          indexArr = Array.new
          indexElements = UtilsMobile.GetElementsWithXpath(driverEle, MarketsPagePO::Index_xpath)
          if indexElements != false
              for data in indexElements
                indexArr.push(data.value)
              end
              # checking the order of elements
              if (indexArr == indexArrActual.sort{|j,k| j<=>k and j.upcase<=>k.upcase}) != true
                  Log.Error("Data under ID column is not in ascending order")
                  return false
              end
          else
              Log.Error("Index Xpath is not found")
              return false
          end
      else
          Log.Error("Id column is not tapped")
          return false
      end
      return true
  rescue Exception => e
      Log.Error e
      return false
  ensure
      Log.CloseTestStep
  end
end
end
   