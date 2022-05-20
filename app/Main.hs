module Main where

import System.Random

categories :: [Char]
categories = ['和', '洋', '中']

categoriesLength :: Int
categoriesLength = length categories

main :: IO ()
main = do
  index <- randomRIO (0, (categoriesLength - 1))
  let category = (categories !! index)
  putChar category
  putStrLn "" -- TODO: 改行のために実装しているが消したい
