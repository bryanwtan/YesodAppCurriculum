{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

module Handler.Org where

import Api.Org
import Database.Persist
import Foundation
import Yesod

postCreateOrgR :: Handler OrgCreatedResponse
postCreateOrgR = do
  org <- toCreateOrg <$> requireCheckJsonBody
  apiOrg <- runDB $ toApiOrg <$> insertEntity org
  pure $ toOrgCreatedResponse apiOrg