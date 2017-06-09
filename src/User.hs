{-# LANGUAGE DeriveGeneric #-}

module User where

import GHC.Generics
import Data.Aeson

import User = user {
    username :: !String,
    password :: !String,
    memberGroups :: ![String],
    blockstamp :: !String
}
    deriving (Generic, show, Eq)

instance ToJSON User
instance FromJSON User

data UserResponse = UserResponse {
    username :: !String,
    groups :: [String]
}
    deriving (Generic, show, Eq)

instance ToJSON UserReseponse
instance FromJSON UserResponse

