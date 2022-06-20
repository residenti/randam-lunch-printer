module Main where

import qualified Data.List as L
import qualified System.Environment as E
import qualified System.Directory as D
import qualified System.Random as R
import qualified Codec.Binary.UTF8.String as U8Str
import qualified LunchCategoryScraper as LCS

-- NOTE: Referring to https://hackage.haskell.org/package/base-4.16.1.0/docs/src/Data-OldList.html#words
wordsWhen :: (Char -> Bool) -> String -> [String]
wordsWhen p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : wordsWhen p s''
                            where (w, s'') = break p s'
main :: IO ()
main = do
  args <- E.getArgs
  homePath <- D.getHomeDirectory
  let configDirPath = homePath ++ "/" ++ ".lunch"
  let categoryListPath = configDirPath ++ "/" ++ "categories.csv"

  if length args > 0 && head args == "--setup"
    then do
      putStrLn "Start creating Lunch Category List..."
      maybeCategories <- LCS.lunchCategories -- NOTE: もはやcategories.csvを準備しといて、それをコピーすればスクレイピングの必要ない気が。。。
      let categories = maybe [] id maybeCategories
      D.createDirectoryIfMissing False configDirPath
      writeFile categoryListPath $ U8Str.decodeString $ L.intercalate "," categories
      putStrLn "Completed!!"
    else do
      categoriesString <- readFile categoryListPath
      let categories = wordsWhen (==',') categoriesString
      let categoriesLength = length categories
      index <- R.randomRIO (0, (categoriesLength - 1))
      let category = (categories !! index)
      putStrLn $  "イタダキマ～ス♪(●人´∀｀) ＼" ++ category ++ "／"
