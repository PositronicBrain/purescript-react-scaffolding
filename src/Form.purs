module Form where

import Data.Int(fromString)
import Prelude(Unit, ($), (/=), bind, pure, discard, when, void)
import Data.Maybe
import Unsafe.Coerce
import React (Event, ReadWrite, ReactClass, ReactProps, ReactRefs, Read, Write, ReactState, createClassStateless, preventDefault)
import React.DOM (form, input,text, button)
import React.DOM.Props (onSubmit, _type, name, placeholder, className)
import DOM.Event.Event as D
import DOM(DOM)
import DOM.HTML.HTMLFormElement(reset)
import Control.Monad.Eff
import Control.Monad.Eff.Console
import Control.Monad.Eff.Exception (throw)
import Partial.Unsafe (unsafePartial)



-- setCounter ∷ Event -> Eff ( props :: ReactProps , refs :: ReactRefs ( read :: Read ) , state :: ReactState ( read :: Read , write :: Write ) | t7 ) 


{-

submitHandler :: forall eff.
                 (Int -> Eff (dom:: DOM, state :: ReactState ReadWrite| eff) Unit)
              -> Event
              -> Eff (dom:: DOM, state :: ReactState ReadWrite| eff) Unit
              -}
-- submitHandler :: ∀ t23 t4 t7. Discard t23 ⇒ (Int → Eff t7 t23) → Event → Eff t7 t4
submitHandler :: ∀ eff
               .  (Int → Eff ( console::CONSOLE, dom ∷ DOM | eff ) Unit )
               → Event
               → Eff ( console::CONSOLE, dom ∷ DOM | eff ) Unit
submitHandler setCounter e = do
  void $ preventDefault e
  let value = (unsafeCoerce e).target.number.value
  case value of
       "" -> log "Empty value"
       _ -> do setCounter $ unsafePartial $ fromJust $ fromString value
               reset $ (unsafeCoerce e).target
      {-

  when (value /= "") $ do setCounter 1
                          (unsafeCoerce e).target.reset
  when (value /= "") $ case (fromString value) of
         Nothing -> log "ciro"
         Just x -> do setCounter x
                      (unsafeCoerce e).target.reset
                      -}

inputForm :: ∀t7. ReactClass { setCounter ∷ Int -> Eff ( console:: CONSOLE, dom :: DOM, props :: ReactProps , refs :: ReactRefs ( read :: Read ) , state :: ReactState ( read :: Read , write :: Write ) | t7 ) Unit }
inputForm = createClassStateless $ \props -> form
            [onSubmit (\e -> submitHandler props.setCounter e)]
            [
              input [_type "number",
                     name "number",
                     placeholder "number",
                     className "form-control"]
                     [],
              button [_type "submit",
                      className "btn btn-primary form-control"]
                      [text "Submit"]
            ]

