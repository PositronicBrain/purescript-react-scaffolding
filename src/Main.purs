module Main where

import Prelude
import DOM (DOM())
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import DOM.HTML (window)
import DOM.HTML.Types (htmlDocumentToDocument)
import DOM.HTML.Window (document)
import DOM.Node.NonElementParentNode (getElementById)
import DOM.Node.Types (Element, ElementId(..), documentToNonElementParentNode)
import React(createElement)
import ReactDOM (render)

import Data.Maybe (fromJust)

import Partial.Unsafe (unsafePartial)

import App(app)

main :: ∀ e. Eff (dom:: DOM, console ∷ CONSOLE | e ) Unit
main = do
  log "Hello sailor!"
  let appEl = createElement app unit []
  root <- rootElm
  void $ render appEl root


rootElm :: ∀ t4. Eff ( dom ∷ DOM | t4 ) Element
rootElm = do
    win <- window
    doc <- document win
    elm <- getElementById (ElementId "react-app") (documentToNonElementParentNode (htmlDocumentToDocument doc))
    pure $ unsafePartial fromJust elm

