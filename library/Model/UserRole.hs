module Model.UserRole where

import Data.Text
import Data.Time
import Database.Persist.TH
import Model.Email
import Yesod

data UserRole = Administrator | Customer | Locked

roleToText :: UserRole -> Text
roleToText = \case
  Administrator -> "admin"
  Customer -> "customer"
  Locked -> "locked user"