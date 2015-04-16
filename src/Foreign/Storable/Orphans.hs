{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module Foreign.Storable.Orphans () where

#if !MIN_VERSION_base(4,8,0)
import Data.Complex (Complex(..), realPart)
import Foreign.Ptr (castPtr)
import Foreign.Storable as Base
import GHC.Real (Ratio(..), (%))

-- The actual constraint in base-4.8.0.0 doesn't include RealFloat a, but it
-- is needed in previous versions of base due to Complex having lots of
-- RealFloat constraints in its functions' type signatures.
instance (Storable a, RealFloat a) => Storable (Complex a) where
    sizeOf a       = 2 * sizeOf (realPart a)
    alignment a    = alignment (realPart a)
    peek p           = do
                        q <- return $ castPtr p
                        r <- peek q
                        i <- peekElemOff q 1
                        return (r :+ i)
    poke p (r :+ i)  = do
                        q <-return $  (castPtr p)
                        poke q r
                        pokeElemOff q 1 i

instance (Storable a, Integral a) => Storable (Ratio a) where
    sizeOf (n :% _)    = 2 * sizeOf n
    alignment (n :% _) = alignment n
    peek p           = do
                        q <- return $ castPtr p
                        r <- peek q
                        i <- peekElemOff q 1
                        return (r % i)
    poke p (r :% i)  = do
                        q <-return $  (castPtr p)
                        poke q r
                        pokeElemOff q 1 i
#endif
