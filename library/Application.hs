{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

module Application where

import Control.Monad.Logger
import Database.Persist.Sqlite
import Foundation
import Handler.Home
import Yesod

mkYesodDispatch "Precursory" resourcesPrecursory

appMain :: IO ()
appMain = runStderrLoggingT $ do
  withSqlitePool "precursory.db" 10 $ \pool -> do
    liftIO $ warp 3000 (App pool)
