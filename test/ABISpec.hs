module ABISpec where

import           Bio.ABI
import           Bio.MMTF.Decode.Codec
import           Bio.Sequence
import           Control.Monad.Except  (runExceptT)
import           Data.ByteString.Lazy  as BSL (readFile)
import           Data.Foldable         (Foldable (..))
import           Test.Hspec

abiExtractSpec :: Spec
abiExtractSpec =
  describe "decoding ABI file" $ do

    it "decode good ABI file" $ do
      file <- BSL.readFile "test/ABI/test.ab1"
      let Right r = extract file
      let list = toList r
      length list `shouldBe` 465
      fmap _object list `shouldBe` goodSequence
      fmap _weight list `shouldBe` goodQuality

    it "not decode non-ABI file" $ do
      file <- BSL.readFile "test/ABI/not_ab1.txt"
      let result = extract file
      result `shouldBe` Left "Error reading root: not enough bytes"

goodSequence :: String
goodSequence = "AATTGGCAGTATTTAGTAATAACAAATAGGGGTTCCGCGCACATTTCCCCGAAAAGTGCCACCTGCGGCCGCTGTACACTAGTGATCGTACGGGCCCATGCATGCTAGCAAGCTTGTCGACATTACCCTGTTATCCCTATTCGCTACCTTAGGACCGTTATAGTTACGACCCATACACTAGTGATCGTACGGGCCCATGCATGCTAGCAAGCTTGTCGACATTACCCTGTTATCCCTATTCGCTACCTTAGGACCGTTATAGTTACGCTTGTCGACATTACCCTGTTATCCCTATTCGCTACCTTAGGACCGTTATAGTTACGACCCATAATACCCATAATAGCTGTTTGCCAATCTAGAGGTACCTCCGGAATGTCGCTTCCTCGCTCACTGACTCGCTGCGCTCGGTCGTTCGGCTGCGGCGAGCGGTATCAGCTCACTCAAAGGCGGTAATACGGTTATCAA"

goodQuality :: [Double]
goodQuality = [11.0,6.0,3.0,3.0,3.0,3.0,4.0,4.0,6.0,4.0,5.0,11.0,23.0,6.0,14.0,5.0,4.0,10.0,26.0,6.0,7.0,7.0,26.0,26.0,26.0,51.0,39.0,41.0,51.0,58.0,49.0,49.0,58.0,54.0,58.0,58.0,54.0,58.0,36.0,29.0,48.0,46.0,28.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,41.0,41.0,62.0,62.0,62.0,47.0,49.0,62.0,62.0,49.0,62.0,54.0,54.0,47.0,41.0,24.0,24.0,27.0,22.0,27.0,22.0,22.0,14.0,11.0,16.0,32.0,51.0,62.0,59.0,59.0,59.0,59.0,28.0,35.0,54.0,62.0,62.0,62.0,59.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,59.0,59.0,59.0,59.0,62.0,62.0,59.0,62.0,59.0,59.0,46.0,54.0,48.0,62.0,59.0,62.0,62.0,59.0,59.0,59.0,62.0,59.0,59.0,62.0,62.0,62.0,59.0,62.0,62.0,62.0,62.0,54.0,54.0,59.0,59.0,62.0,62.0,62.0,62.0,62.0,59.0,62.0,62.0,62.0,62.0,62.0,62.0,59.0,62.0,62.0,62.0,62.0,62.0,54.0,54.0,62.0,54.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,59.0,62.0,62.0,62.0,62.0,59.0,62.0,62.0,62.0,62.0,59.0,59.0,62.0,59.0,59.0,59.0,59.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,59.0,59.0,62.0,62.0,62.0,62.0,59.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,59.0,59.0,59.0,50.0,59.0,59.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,59.0,62.0,54.0,62.0,62.0,54.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,59.0,62.0,59.0,62.0,62.0,62.0,62.0,62.0,62.0,59.0,62.0,59.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,59.0,62.0,62.0,62.0,62.0,59.0,62.0,51.0,62.0,62.0,62.0,62.0,54.0,49.0,62.0,62.0,62.0,62.0,59.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,59.0,62.0,59.0,62.0,62.0,62.0,62.0,62.0,62.0,59.0,62.0,59.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,59.0,62.0,62.0,62.0,51.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,59.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,56.0,56.0,62.0,62.0,56.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,43.0,43.0,62.0,62.0,62.0,59.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,59.0,59.0,46.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,56.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,62.0,49.0,49.0,62.0,62.0,62.0,62.0,56.0,42.0,42.0,56.0,46.0,56.0,43.0,36.0,43.0,51.0,62.0,7.0,8.0,8.0,9.0,5.0]


