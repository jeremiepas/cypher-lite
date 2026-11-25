-- | 'Cypher.Lite' parses a subset of openCypher: read queries (MATCH, WHERE,
-- RETURN) and write statements (CREATE, MERGE, SET, REMOVE, DELETE, DETACH
-- DELETE).
--
-- Parse a query to a data structure you can inspect, or a statement to accept
-- both reads and writes. Anything outside the subset is a parse error with a
-- position, not a silent fallback.
--
-- > case parseStatement "MATCH (a:Function) RETURN a" of
-- >   Left problem -> putStrLn (show problem)
-- >   Right statement -> print statement
--
-- The data types are in 'Cypher.Lite.AST' and the entry points in
-- 'Cypher.Lite.Parser'.
module Cypher.Lite
  ( module Cypher.Lite.AST
  , module Cypher.Lite.Parser
  ) where

import Cypher.Lite.AST
import Cypher.Lite.Parser
