{-# LANGUAGE CPP #-}
{-# LANGUAGE DeriveDataTypeable, StandaloneDeriving, TypeFamilies #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module Data.Version.Orphans () where

#if !MIN_VERSION_base(4,7,0)
import Data.Data
#endif

#if !MIN_VERSION_base(4,8,0)
import Data.Version

# if MIN_VERSION_base(4,7,0)
import GHC.Exts (IsList(..))
# endif
#endif

#if !MIN_VERSION_base(4,7,0)
deriving instance Data Version
#endif

#if !MIN_VERSION_base(4,8,0)
-- | Construct tag-less 'Version'
--
-- /Since: 4.8.0.0/
makeVersion :: [Int] -> Version
makeVersion b = Version b []

# if MIN_VERSION_base(4,7,0)
-- | /Since: 4.8.0.0/
instance IsList Version where
  type (Item Version) = Int
  fromList = makeVersion
  toList = versionBranch
# endif

#endif
