{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Replace case with maybe" #-}
module Handler.User where

import Api.User
import Data.Int
import Data.Time
import Database.Persist
import Database.Persist.Sql ()
import Foundation
import GHC.Generics
import Model.User
import Orphans
import Yesod
import Yesod.Core.Types

returnJSONResponse :: (Monad m, ToJSON a) => a -> m (JSONResponse a)
returnJSONResponse = pure . JSONResponse

-- selectList [filters] [options]
getUserR :: UserId -> Handler ApiUser
getUserR userId = do
  user <- runDB $ getEntity userId
  case user of
    Nothing -> undefined
    Just user -> pure $ toApiUser user

getUsersR :: Handler [ApiUser]
getUsersR = runDB $ map toApiUser <$> selectList [] []

postRegisterUserR :: Handler UserCreatedResponse
postRegisterUserR = do
  user <- toCreateUser <$> requireCheckJsonBody
  apiUser <- runDB $ toApiUser <$> insertEntity user
  pure $ toUserCreatedResponse apiUser