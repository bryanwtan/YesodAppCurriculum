{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ViewPatterns #-}

module Application where

import Control.Monad.Logger
import Database.Persist.Sqlite
import Foundation
import Handler.Org
import Handler.User
import Model.Org
import Model.User
import Yesod

-- http://www.yesodweb.com/book/scaffolding-and-the-site-template#scaffolding-and-the-site-template_foundation_and_application_modules
mkYesodDispatch "Precursory" resourcesPrecursory

getRequiredMigrations :: Migration
getRequiredMigrations =
  migrateModels
    [ entityDef (Nothing :: Maybe User)
    , entityDef (Nothing :: Maybe Org)
    ]

appMain :: IO ()
appMain = runStderrLoggingT $ do
  withSqlitePool "precursory.db" 10 $ \pool -> do
    runSqlPool (runMigration getRequiredMigrations) pool
    liftIO $ warp 3000 (App pool)
