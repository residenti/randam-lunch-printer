module RandamLunchPrinter
  ( LatLon (..)
  , putLunchCategoryName
  , putShopName
  ) where


import qualified System.Directory as D
import qualified Data.Aeson as A
import qualified Data.ByteString.Char8 as BC
import qualified GHC.Generics as G
import qualified Network.HTTP.Simple as HS
import qualified System.Random as R


data Shop = Shop { name :: String } deriving (Show, G.Generic)
instance A.FromJSON Shop

data Shops = Shops  { shops :: [Shop] } deriving (Show, G.Generic)
instance A.FromJSON Shops

data LatLon = LatLon { latitude :: BC.ByteString
                     , longitude :: BC.ByteString }

putLunchCategoryName :: IO ()
putLunchCategoryName = do
  categoryListPath <- prepareCategoryListPath
  hasCategoryList <- D.doesFileExist categoryListPath

  if not hasCategoryList then do
    putStrLn "Start creating Lunch Category List..."
    configDirPath <- prepareConfigDirPath
    D.createDirectoryIfMissing False configDirPath
    D.copyFile "categories.csv" categoryListPath
    putStrLn "Completed!!"
  else return()

  categoriesString <- readFile categoryListPath
  let categories = wordsWhen (==',') categoriesString
  let categoriesLength = length categories
  index <- R.randomRIO (0, (categoriesLength - 1))
  let category = (categories !! index)
  putStrLn $ "イタダキマ～ス♪(●人´∀｀) ＼" ++ category ++ "／"

putShopName :: LatLon -> IO ()
putShopName latLon = do
  response <- HS.httpLBS $ request latLon
  let status = HS.getResponseStatusCode response
  if status == 200
  then do
    let responseBody = HS.getResponseBody response
    let maybeShops = A.decode responseBody :: Maybe Shops
    putRandomShopName maybeShops
  else putStrLn "request failed with error (￣_￣|||)"


-- TODO: host値入れる
host :: BC.ByteString
host = "<host>"

apiPath :: BC.ByteString
apiPath = "/production/shops"

query :: LatLon -> [HS.QueryItem]
query latLon = [("lat", Just $ latitude latLon) , ("lng", Just $ longitude latLon)]

buildRequest :: BC.ByteString -> BC.ByteString -> BC.ByteString -> [HS.QueryItem] -> HS.Request
buildRequest host method path query = HS.setRequestMethod method
                                    $ HS.setRequestHost host
                                    $ HS.setRequestPath path
                                    $ HS.setRequestQueryString query
                                    $ HS.setRequestSecure True
                                    $ HS.setRequestPort 443
                                    $ HS.defaultRequest

request :: LatLon -> HS.Request
request latLon = buildRequest host "GET" apiPath $ query latLon

-- TODO: 店名の取得までを行う処理にする
putRandomShopName :: Maybe Shops -> IO ()
putRandomShopName Nothing = putStrLn "条件にマッチするお店が見つかりませんでした (￣_￣|||)"
putRandomShopName (Just res) = do
  let shopData = shops res
  let shopsLength = length shopData
  index <- R.randomRIO (0, (shopsLength - 1))
  let shop = (shopData !! index)
  putStrLn $ name shop

-- NOTE: Referring to https://hackage.haskell.org/package/base-4.16.1.0/docs/src/Data-OldList.html#words
wordsWhen :: (Char -> Bool) -> String -> [String]
wordsWhen p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : wordsWhen p s''
                            where (w, s'') = break p s'

prepareConfigDirPath :: IO FilePath
prepareConfigDirPath = do
  homePath <- D.getHomeDirectory
  return $ homePath ++ "/" ++ ".lunch"

prepareCategoryListPath :: IO FilePath
prepareCategoryListPath = do
  configDirPath <- prepareConfigDirPath
  return $ configDirPath ++ "/" ++ "categories.csv"
