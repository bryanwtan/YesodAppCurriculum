module Handler.Home where

import Data.Aeson
import Data.Text
import Foundation
import GHC.Generics
import Model.User
import Orphans ()
import Yesod

data ApiUser = ApiUser
  { id :: Yesod.Key User,
    email :: Text,
    username :: Text
  }
  deriving stock (Generic)
  deriving anyclass (ToJSON)

instance ToTypedContent ApiUser where
  toTypedContent = TypedContent typeJson . toContent

instance ToContent ApiUser where
  toContent = toContent . encode

toApiUser :: Entity User -> ApiUser
toApiUser (Entity userId User {..}) =
  ApiUser
    { id = userId,
      email = userEmail,
      username = userUsername
    }

getHomeR :: Handler [ApiUser]
getHomeR = runDB $ Prelude.map toApiUser <$> selectList [] []
