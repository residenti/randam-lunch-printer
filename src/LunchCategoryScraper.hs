{-# LANGUAGE OverloadedStrings #-}

module LunchCategoryScraper
  ( lunchCategories
  ) where

import qualified Text.HTML.Scalpel as HS
import qualified Data.Text as T

lunchCategories :: IO (Maybe [T.Text])
lunchCategories = HS.scrapeURL "https://retty.me/category/" lunchCategories
  where
    lunchCategories :: HS.Scraper T.Text [T.Text]
    lunchCategories = HS.chroots ("td" HS.// "a") lunchCategory
    lunchCategory :: HS.Scraper T.Text T.Text
    -- TODO: ここ何してるか調べる
    lunchCategory = do
      lunchCategoryText <- HS.text $ "a"
      return $ lunchCategoryText
