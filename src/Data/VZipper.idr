module Data.VZipper

import Control.Comonad
import Data.Vect

data VZipper : Nat -> Type -> Type where
  MkVZipper : Vect (S n) x -> Fin (S n) -> VZipper (S n) x

finVect : (n : Nat) -> Vect n (Fin n)
finVect n = reverse (k n) where
   k Z = []
   k (S Z) = [FZ]
   k (S n) = last :: (map weaken $ finVect n)

mapWithIndex : { n : Nat } -> (f : Fin n -> a -> b) -> (xs : Vect n a) -> Vect n b
mapWithIndex {n} f xs = map (uncurry f) (map (\x => (x, Data.Vect.index x xs)) (finVect n))

implementation Functor (VZipper n) where
  map f (MkVZipper xs i) = MkVZipper (map f xs) i

implementation Comonad (VZipper n) where
  extract (MkVZipper xs i) = index i xs
  duplicate (MkVZipper xs i) = MkVZipper (mapWithIndex (\j, _ => MkVZipper xs j) xs) i
