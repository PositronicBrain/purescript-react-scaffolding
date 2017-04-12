module Main where

import Prelude
import DOM (DOM())
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
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

main ∷ ∀ eff. Eff (dom ∷ DOM, console ∷ CONSOLE | eff) Unit
main = do
    let appElm = createElement app unit []
    rootElm ← getRootElm
    void $ render appElm rootElm


getRootElm ∷ ∀ eff. Eff (dom ∷ DOM | eff) Element
getRootElm = do
    win ← window
    doc ← document win
    elm ← getElementById (ElementId "react-app")
                          (documentToNonElementParentNode (htmlDocumentToDocument doc))
    pure $ unsafePartial fromJust elm

