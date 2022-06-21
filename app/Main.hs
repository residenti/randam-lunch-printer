module Main where


import qualified Data.List as L
import qualified System.Directory as D
import qualified System.Random as R
import qualified Codec.Binary.UTF8.String as U8Str
import qualified RandamLunchPrinter as RLP


main :: IO ()
main = do
  categoryListPath <- RLP.prepareCategoryListPath
  hasCategoryList <- D.doesFileExist categoryListPath

  if not hasCategoryList then do
    putStrLn "Start creating Lunch Category List..."
    maybeCategories <- RLP.lunchCategories -- NOTE: もはやcategories.csvを準備しといて、それをコピーすればスクレイピングの必要ない気が。。。
    let categories = maybe [] id maybeCategories
    configDirPath <- RLP.prepareConfigDirPath
    D.createDirectoryIfMissing False configDirPath
    writeFile categoryListPath $ U8Str.decodeString $ L.intercalate "," categories
    putStrLn "Completed!!"
  else return()

  categoriesString <- readFile categoryListPath
  let categories = RLP.wordsWhen (==',') categoriesString
  let categoriesLength = length categories
  index <- R.randomRIO (0, (categoriesLength - 1))
  let category = (categories !! index)
  putStrLn $ "イタダキマ～ス♪(●人´∀｀) ＼" ++ category ++ "／"
