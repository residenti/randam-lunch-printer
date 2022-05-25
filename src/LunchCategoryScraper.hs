{-# LANGUAGE OverloadedStrings #-}

module LunchCategoryScraper
  ( lunchCategories
  ) where

import Text.HTML.Scalpel
import qualified Data.Text as T

lunchCategories :: IO (Maybe [T.Text])
lunchCategories = scrapeURL "https://retty.me/category/" lunchCategories
  where
    lunchCategories :: Scraper T.Text [T.Text]
    lunchCategories = chroots ("td" // "a") lunchCategory
    lunchCategory :: Scraper T.Text T.Text
    -- TODO: ここ何してるか調べる
    lunchCategory = do
      lunchCategoryText <- text $ "a"
      return $ lunchCategoryText
