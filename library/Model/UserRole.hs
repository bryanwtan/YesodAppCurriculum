module Model.UserRole where

import Data.Text

data UserRole = Administrator | Customer | Locked

roleToText :: UserRole -> Text
roleToText = \case
  Administrator -> "admin"
  Customer -> "customer"
  Locked -> "locked user"