{-# LANGUAGE OverloadedStrings #-}

module LaunchCategoryScraper
  ( launchCategories
  ) where

import Text.HTML.Scalpel
import qualified Data.Text as T

launchCategories :: IO (Maybe [T.Text])
launchCategories = scrapeURL "https://retty.me/category/" launchCategories
  where
    launchCategories :: Scraper T.Text [T.Text]
    launchCategories = chroots ("td" // "a") launchCategory
    launchCategory :: Scraper T.Text T.Text
    -- TODO: ここ何してるか調べる
    launchCategory = do
      launchCategoryText <- text $ "a"
      return $ launchCategoryText
