module Model.Email where

import Data.CaseInsensitive as CI
import Data.Text
import Data.Text.Encoding as TE
import Data.Time
import Database.Persist.Sql
import Database.Persist.TH
import Text.Regex.TDFA
import Text.Regex.TDFA.Text ()
import Yesod

-- https://www.w3.org/TR/html5/forms.html#valid-e-mail-address
emailRegex :: Text
emailRegex = "[a-zA-Z0-9+._-]+@[a-zA-Z-]+\\.[a-z]+"

makeEmail :: Text -> Maybe Email
makeEmail emailCandidate =
  if emailCandidate =~ emailRegex
    then Just (Email (CI.mk emailCandidate))
    else Nothing

newtype Email = Email {getCIText :: CI Text}
  deriving stock (Show)

instance ToJSON Email where
  toJSON (Email ci) = toJSON $ original ci

instance FromJSON Email where
  parseJSON (String t) = case makeEmail t of
    Nothing -> fail $ "Invalid email address: " ++ show t
    Just email -> pure email
  parseJSON x = fail $ "When trying to parse an Email, expected String, encountered " ++ show x

instance PersistField Email where
  toPersistValue email = PersistLiteralEscaped $ TE.encodeUtf8 $ CI.original $ getCIText email
  fromPersistValue (PersistLiteral_ _ bs) = case makeEmail $ TE.decodeUtf8 bs of
    Nothing -> Left $ pack $ "Deserialized invalid email from the database: " ++ show bs
    Just email -> Right email
  fromPersistValue x = Left $ pack $ "When trying to deserialize an `Email`, expected PersistLiteral_, received: " ++ show x

instance PersistFieldSql Email where
  sqlType _ = SqlOther "email"