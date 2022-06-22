module RandamLunchPrinter
  ( wordsWhen
  , prepareConfigDirPath
  , prepareCategoryListPath
  ) where


import qualified System.Directory as D


-- NOTE: Referring to https://hackage.haskell.org/package/base-4.16.1.0/docs/src/Data-OldList.html#words
wordsWhen :: (Char -> Bool) -> String -> [String]
wordsWhen p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : wordsWhen p s''
                            where (w, s'') = break p s'

prepareConfigDirPath :: IO FilePath
prepareConfigDirPath = do
  homePath <- D.getHomeDirectory
  return $ homePath ++ "/" ++ ".lunch"

prepareCategoryListPath :: IO FilePath
prepareCategoryListPath = do
  configDirPath <- prepareConfigDirPath
  return $ configDirPath ++ "/" ++ "categories.csv"
