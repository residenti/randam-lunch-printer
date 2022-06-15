module Main where

import qualified Data.List as L
import qualified System.Environment as E
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
  if length args > 0 && head args == "--u"
    then do
      putStrLn "Start updating Lunch Categories List..."
      maybeCategories <- LCS.lunchCategories
      let categories = maybe [] id maybeCategories
      writeFile "categories.csv" $ U8Str.decodeString $ L.intercalate "," categories
      putStrLn "Completed!!"
    else do
      categoriesString <- readFile "categories.csv"
      let categories = wordsWhen (==',') categoriesString
      let categoriesLength = length categories
      index <- R.randomRIO (0, (categoriesLength - 1))
      let category = (categories !! index)
      putStrLn $  "イタダキマ～ス♪(●人´∀｀) ＼" ++ category ++ "／"
