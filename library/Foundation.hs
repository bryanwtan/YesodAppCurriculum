{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

module Foundation where

import Data.Pool
import Database.Persist.Sqlite
import Yesod

newtype Precursory = App
  {appConnectionPool :: Pool SqlBackend}

instance YesodPersist Precursory where
  type YesodPersistBackend Precursory = SqlBackend
  runDB action = do
    pool <- getsYesod appConnectionPool
    runSqlPool action pool

mkYesodData "Precursory" [parseRoutes|/ HomeR GET|]

instance Yesod Precursory