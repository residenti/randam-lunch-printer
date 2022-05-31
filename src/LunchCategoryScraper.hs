{-# LANGUAGE OverloadedStrings #-}

module LunchCategoryScraper
  ( lunchCategories
  ) where

import qualified Text.HTML.Scalpel as HS

lunchCategories :: IO (Maybe [String])
lunchCategories = HS.scrapeURL "https://retty.me/category/" lunchCategories
  where
    lunchCategories :: HS.Scraper String [String]
    lunchCategories = HS.chroots ("td" HS.// "a") lunchCategory
    lunchCategory :: HS.Scraper String String
    -- TODO: ここ何してるか調べる
    lunchCategory = do
      lunchCategoryText <- HS.text "a"
      return lunchCategoryText
