{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified System.Random as R
import qualified Codec.Binary.UTF8.String as U8Str
import qualified LunchCategoryScraper as LCS

main :: IO ()
main = do
  maybeCategories <- LCS.lunchCategories -- TODO 都度スクレイピングするの止める
  let categories = maybe [] id maybeCategories
  let categoriesLength = length categories
  index <- R.randomRIO (0, (categoriesLength - 1))
  let category = (categories !! index)
  putStrLn $ U8Str.decodeString category
