module Main where


import qualified System.Directory as D
import qualified System.Random as R
import qualified RandamLunchPrinter as RLP


main :: IO ()
main = do
  categoryListPath <- RLP.prepareCategoryListPath
  hasCategoryList <- D.doesFileExist categoryListPath

  if not hasCategoryList then do
    putStrLn "Start creating Lunch Category List..."
    configDirPath <- RLP.prepareConfigDirPath
    D.createDirectoryIfMissing False configDirPath
    D.copyFile "categories.csv" categoryListPath
    putStrLn "Completed!!"
  else return()

  categoriesString <- readFile categoryListPath
  let categories = RLP.wordsWhen (==',') categoriesString
  let categoriesLength = length categories
  index <- R.randomRIO (0, (categoriesLength - 1))
  let category = (categories !! index)
  putStrLn $ "イタダキマ～ス♪(●人´∀｀) ＼" ++ category ++ "／"
