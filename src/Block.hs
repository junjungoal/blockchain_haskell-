{-# LANGUAGE DeriveGeneric #-}

import Crypto.Hash as Cryp
import Time.System
import Time.Types
import GHC.Generics
import Data.Aeson
import Data.Bson.Generic
import System.IO.Unsafe
import Data.Maybe
import qualified Data.ByteString.Char8 as c8

data Block = Block {
    index :: !Integer,
    prevHash :: !String,
    timestamp :: !String,
    blockHash :: !String
}
    deriving (Generic, Show, Eq)

instance ToJSON Block
instance FromJSON Block

instance ToBSON Block
instance FromBSON Block

calculateHash :: Integer -> String -> String -> 
