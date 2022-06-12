module Main where

import qualified Data.List as L
import qualified System.Random as R
import qualified Codec.Binary.UTF8.String as U8Str
import qualified LunchCategoryScraper as LCS

wordsWhen :: (Char -> Bool) -> String -> [String]
wordsWhen p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : wordsWhen p s''
                            where (w, s'') = break p s'
main :: IO ()
main = do
  -- TODO: フラグでスクレイピングとプリント処理を切り分けられるようにする
  -- maybeCategories <- LCS.lunchCategories
  -- let categories = maybe [] id maybeCategories
  -- writeFile "categories.csv" $ U8Str.decodeString $ L.intercalate "," categories

  categoriesString <- readFile "categories.csv"
  let categories = wordsWhen (==',') categoriesString
  let categoriesLength = length categories
  index <- R.randomRIO (0, (categoriesLength - 1))
  let category = (categories !! index)
  putStrLn category
