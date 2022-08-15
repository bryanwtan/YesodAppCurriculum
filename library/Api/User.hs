{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Api.User where

import Data.Aeson hiding (Key)
import Data.Text
import Data.Time
import Database.Persist
import GHC.Generics
import Model.User

-- database
data ApiUser = ApiUser
  { id :: Key User
  , email :: Text
  , username :: Text
  , dateOfBirth :: Day
  }
  deriving stock (Generic)
  deriving anyclass (ToJSON)

toApiUser :: Entity User -> ApiUser
toApiUser (Entity userId User {..}) =
  ApiUser
    { id = userId
    , email = userEmail
    , username = userUsername
    , dateOfBirth = userDateOfBirth
    }

-- incoming
data RegisterUser = RegisterUser
  { email :: Text
  , username :: Text
  , dateOfBirth :: Day
  }
  deriving stock (Generic)
  deriving anyclass (FromJSON)

toCreateUser :: RegisterUser -> User
toCreateUser RegisterUser {..} =
  User
    { userEmail = email
    , userUsername = username
    , userDateOfBirth = dateOfBirth
    }

-- outgoing
data UserCreatedResponseData = UserCreatedResponseData
  { responseMessage :: Text
  , responseEmail :: Text
  }

instance ToJSON UserCreatedResponseData where
  toJSON (UserCreatedResponseData m e) = object ["message" .= m, "email" .= e]

newtype UserCreatedResponse = UserCreatedResponse {user :: UserCreatedResponseData}
  deriving newtype (ToJSON)

toUserCreatedResponse :: ApiUser -> UserCreatedResponse
toUserCreatedResponse user = UserCreatedResponse $ UserCreatedResponseData "user created" (email (user :: ApiUser))