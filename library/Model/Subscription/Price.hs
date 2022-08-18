{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE UndecidableInstances #-}

module Model.Subscription.Price where

import Data.Text
import Data.Time
import Database.Persist.TH
import Yesod

share
  [mkPersist sqlSettings, mkMigrate "migrateAll"]
  [persistLowerCase|
Price sql=prices

  createdAt UTCTime default=CURRENT_TIME MigrationOnly
  updatedAt UTCTime default=CURRENT_TIME MigrationOnly
|]
