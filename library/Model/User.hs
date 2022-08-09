{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE UndecidableInstances #-}

module Model.User where

import Data.Text
import Database.Persist.TH
import Yesod

share
  [mkPersist sqlSettings]
  [persistLowerCase|
User sql=users
    email Text
    username Text
    UniqueEmail email
    UniqueUsername email
|]