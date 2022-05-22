{-# LANGUAGE OverloadedStrings #-}

module Main where

import System.Random
import Data.Text.IO as TIO
import LaunchCategoryScraper

main :: IO ()
main = do
  maybeCategories <- launchCategories -- TODO 都度スクレイピングするの止める
  let categories = maybe [] id maybeCategories
  let categoriesLength = length categories
  index <- randomRIO (0, (categoriesLength - 1))
  let category = (categories !! index)
  TIO.putStrLn category -- FIXME: 文字化け
