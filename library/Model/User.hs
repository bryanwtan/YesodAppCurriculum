{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE UndecidableInstances #-}

module Model.User where

import Data.Text
import Data.Time
import Database.Persist.TH
import Model.Email
import Yesod

-- Haskell types, but these map to real sql columns
share
  [mkPersist sqlSettings, mkMigrate "migrateAll"]
  [persistLowerCase|
User sql=users
    email Email
    username Text
    dateOfBirth Day
    UniqueEmail email
    UniqueUsername username
    createdAt UTCTime default=CURRENT_TIME MigrationOnly
|]
