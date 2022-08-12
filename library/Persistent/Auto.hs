module Persistent.Auto where

import Data.Time

-- This is necessary for columns that the DB auto-populates (& overrides) such as `createdAt` and `updatedAt`.
fakeUTCTime :: UTCTime
fakeUTCTime = UTCTime (fromGregorian 1 1 1) 0