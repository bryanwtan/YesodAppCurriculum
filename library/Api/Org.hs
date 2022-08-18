{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Api.Org where

import Data.Aeson hiding (Key)
import Data.Text
import Database.Persist
import GHC.Generics
import Model.Org

-- database
data ApiOrg = ApiOrg
  { id :: Key Org
  , orgName :: Text
  }

toApiOrg :: Entity Org -> ApiOrg
toApiOrg (Entity orgId Org {..}) =
  ApiOrg
    { id = orgId
    , orgName = orgOrgName
    }

-- incoming
newtype RegisterOrg = RegisterOrg
  { orgName :: Text
  }
  deriving stock (Generic)
  deriving anyclass (FromJSON)

toCreateOrg :: RegisterOrg -> Org
toCreateOrg RegisterOrg {..} =
  Org
    { orgOrgName = orgName
    }

-- outgoing
data OrgCreatedResponseData = OrgCreatedResponseData
  { responseMessage :: Text
  , responseOrgName :: Text
  }

instance ToJSON OrgCreatedResponseData where
  toJSON (OrgCreatedResponseData m o) = object ["message" .= m, "orgName" .= o]

newtype OrgCreatedResponse = OrgCreatedResponse {org :: OrgCreatedResponseData}
  deriving newtype (ToJSON)

toOrgCreatedResponse :: ApiOrg -> OrgCreatedResponse
toOrgCreatedResponse org = OrgCreatedResponse $ OrgCreatedResponseData "org created" (orgName (org :: ApiOrg))