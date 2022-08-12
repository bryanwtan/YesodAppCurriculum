{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE UndecidableInstances #-}

module Model.User where

import Data.Text
import Data.Time
import Database.Persist.TH
import Yesod

-- Haskell types, but these map to real sql columns
share
  [mkPersist sqlSettings, mkMigrate "migrateAll"]
  [persistLowerCase|
User sql=users
    email Text
    username Text
    dateOfBirth Day
    UniqueEmail email
    UniqueUsername username
    createdAt UTCTime
|]

-- deriving newtype persist field
-- email type instead of text type
-- consider username type as well
-- closer to domain
