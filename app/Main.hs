{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified System.Random as R
import qualified Data.Text.IO as TIO
import qualified LunchCategoryScraper as LCS

main :: IO ()
main = do
  maybeCategories <- LCS.lunchCategories -- TODO 都度スクレイピングするの止める
  let categories = maybe [] id maybeCategories
  let categoriesLength = length categories
  index <- R.randomRIO (0, (categoriesLength - 1))
  let category = (categories !! index)
  TIO.putStrLn category -- FIXME: 文字化け
