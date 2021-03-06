{-# LANGUAGE DeriveGeneric #-}

module Dat where

import qualified Data.Map.Strict as Map
import Time.Types
import Data.Aeson
import Data.Bson.Generics
import GHC.Generics
import Crypto.Hash as Cryp
import qualified Data.ByteString.Char8 as c8

type Hash = Digest SHA256
type Dat = [Record]

data Record = T Transaction | GR GroupRegister | UR UserRegister | UGR UserGroupRegister
    deriving (Generic, Show, Eq)

instance ToJSON Record
instance FromJSON Record

instance ToBSON Record
instance FromBSON Record

data Transaction = Transaction {
    fromUser :: !String,
    toUser :: !String,
    group :: !String,
    value :: !Double,
    message :: !String,
    tstamp :: !String,
    chksum :: !String
}
    deriving (Generic, Show, Eq)

instance ToJSON Transaction
instance FromJSON Transaction

instance ToBSON Transaction
instance FromBSON Transaction

data GroupRegister = GroupRegister {
    identifier :: !String,
    description :: !String
}
    deriving (Generic, Show, Eq)

instance ToJSON GroupRegister
instance FromJSON GroupRegister

instance ToBSON GroupRegister
instance FromBSON GroupRegister

data UserRegister = UserRegister {
    name :: !String,
    password :: !String
}
    deriving (Generic, Show, Eq)

instance ToJSON UserRegister
instance FromJSON USerRegister

instance ToBSON UserRegister
instance FromBSON UserRegister}

newDat :: Dat
newDat = []

addRecord :: Record -> Dat -> Dat
addRecord t = (:) t

numTransasctions :: Dat -> Int
numTransactions = length

registerUser :: String -> String -> Record
registerUser username password = UR $ UserRegister {name = username, password = password}

createTransaction :: String -> String -> String -> Double -> String -> String -> Record
createTransaction fAddr tAddr g val msg ts =
    let
        csum = ((hash . C8.pack) . concat) [fAddr, tAddr, show val, msg, ts] :: Hash
    in
        T $ Transaction {fromUser = fAddr, toUser = tAddr, group = g, value = val, message = msg, tstamp = ts, chksum = show csum}

