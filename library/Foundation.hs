{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ViewPatterns #-}

module Foundation where

import Data.Int
import Data.Pool
import Database.Persist.Sqlite
import Model.User
import Yesod
  ( RenderRoute (renderRoute),
    Yesod,
    YesodPersist (..),
    getsYesod,
    mkYesodData,
    parseRoutes,
  )

newtype Precursory = App
  {appConnectionPool :: Pool SqlBackend}

instance YesodPersist Precursory where
  type YesodPersistBackend Precursory = SqlBackend
  runDB action = do
    pool <- getsYesod appConnectionPool
    runSqlPool action pool

mkYesodData
  "Precursory"
  [parseRoutes|
/users/#UserId UserR GET
/users/ UsersR GET

/create/user/ RegisterUserR POST
|]

instance Yesod Precursory