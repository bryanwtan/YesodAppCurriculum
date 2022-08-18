{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE UndecidableInstances #-}

module Model.Org where

import Data.Text
import Data.Time
import Database.Persist.TH
import Yesod

share
  [mkPersist sqlSettings, mkMigrate "migrateAll"]
  [persistLowerCase|
Org sql=orgs
  orgName Text
  createdAt UTCTime default=CURRENT_TIME MigrationOnly
  updatedAt UTCTime default=CURRENT_TIME MigrationOnly
|]
