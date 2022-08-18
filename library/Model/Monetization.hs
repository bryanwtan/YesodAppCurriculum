module Model.Monetization where

import Data.Fixed
import Database.Persist.Sql
import Yesod

newtype Percentage = Percentage Centi
  deriving stock (Show, Read)
  deriving newtype (Eq, Ord, PersistField, ToJSON)

data Plan = Essentials | Professional

data PaymentSchedule = Monthly | Yearly | Lifetime

newtype Offer = Offer {unOffer :: Percentage}