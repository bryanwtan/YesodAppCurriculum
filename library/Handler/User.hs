module Handler.User where

import Api.User
import Data.Int
import Data.Time
import Database.Persist
import Database.Persist.Sql
import Foundation
import GHC.Generics
import Model.User
import Orphans
import Yesod
import Yesod.Core.Types

returnJSONResponse :: (Monad m, ToJSON a) => a -> m (JSONResponse a)
returnJSONResponse = pure . JSONResponse

-- selectList [filters] [options]
getUserR :: UserId -> Handler UserResponse
getUserR userId = do
  user <- runDB $ get404 userId
  pure $ toUserResponse user

getUsersR :: Handler [ApiUser]
getUsersR = runDB $ map toApiUser <$> selectList [] []

postRegisterUserR :: Handler ApiUser
postRegisterUserR = do
  user <- toCreateUser <$> requireCheckJsonBody
  runDB $ toApiUser <$> insertEntity user