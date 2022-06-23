module Main where


import qualified Data.Aeson as A
import qualified System.Posix.Env.ByteString as E
import qualified System.Directory as D
import qualified System.Random as R
import qualified RandamLunchPrinter as RLP
import qualified Network.HTTP.Simple as HS
import qualified Data.ByteString.Char8 as BC

hasShopOption :: [BC.ByteString] -> Bool
hasShopOption args = length args > 0 && head args == "--s"

latLon :: [BC.ByteString] -> RLP.LatLon
latLon args = RLP.LatLon { RLP.latitude = lat, RLP.longitude = lon  }
  where
    lat = args !! 1
    lon = args !! 2

-- TODO 緯度経度を設定ファイルから読み取るようにする
main :: IO ()
main = do
  args <- E.getArgs
  if hasShopOption args
  then RLP.putShopName $ latLon args
  else RLP.putLunchCategoryName
