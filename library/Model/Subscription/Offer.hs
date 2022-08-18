{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE UndecidableInstances #-}

module Model.Subscription.Offer where

import Data.Text
import Data.Time
import Database.Persist.TH
import Yesod

share
  [mkPersist sqlSettings, mkMigrate "migrateAll"]
  [persistLowerCase|
Offer sql=plans

  createdAt UTCTime default=CURRENT_TIME MigrationOnly
  updatedAt UTCTime default=CURRENT_TIME MigrationOnly
|]
