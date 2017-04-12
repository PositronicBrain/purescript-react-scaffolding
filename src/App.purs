module App where

import Prelude (($), bind, pure, void, Unit)
import React
import React.DOM(div, h1, text)
import React.DOM.Props (className)
import Display(display)
import Form(inputForm)
import Control.Monad.Eff(Eff)

type AppState = { counter ∷ Int }

initialState ∷ AppState
initialState = { counter: 0 }


setCounterf ∷ ∀ props eff t8. ReactThis props AppState
            → Int
            → Eff ( state ∷ ReactState ( write :: Write | t8 ) | eff ) Unit
setCounterf ctx x = do
  void $ writeState ctx ( { counter: x })

app :: ∀ props. ReactClass props
app = createClass $ spec initialState \ctx -> do
   state ← readState ctx
   pure $ div [ className "container" ]
              [ div [ className "row" ]
                    [div [ className "col-12 col-md-6 offset-md-3" ]
                         [ h1 [ className "text-center" ]
                              [ text "Register a number!" ]]],
                div [ className "row" ]
                               [ div [ className "col-12 col-md-6 offset-md-3" ]
                                     [ createElement display
                                     {counter: state.counter}
                                                     [] ]],
                div [ className "row" ]
                               [ div [ className "col-12 col-md-6 offset-md-3" ]
                               [ createElement inputForm  {setCounter: setCounterf ctx } [] ]]
                                     ]

