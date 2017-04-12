module Form where

import Data.Int(fromString)
import Prelude(Unit, ($), discard, void)
import Data.Maybe (fromJust)
import Unsafe.Coerce(unsafeCoerce)
import React (Event, ReactClass, ReactProps,
              ReactRefs, Read, Write, ReactState,
              createClassStateless, preventDefault)
import React.DOM (form, input,text, button)
import React.DOM.Props (onSubmit, _type, name, placeholder, className)
import DOM(DOM)
import DOM.HTML.HTMLFormElement(reset)
import Control.Monad.Eff(Eff)
import Control.Monad.Eff.Console
import Partial.Unsafe (unsafePartial)

submitHandler ∷ ∀ eff
               . (Int → Eff ( console ∷ CONSOLE, dom ∷ DOM | eff ) Unit)
               → Event
               → Eff ( console∷ CONSOLE, dom∷ DOM | eff ) Unit
submitHandler setCounter e = do
  void $ preventDefault e
  let value = (unsafeCoerce e).target.number.value
  case value of
       "" → log "Empty value"
       _  → do setCounter $ unsafePartial $ fromJust $ fromString value
               reset $ (unsafeCoerce e).target

inputForm ∷ ∀eff
            . ReactClass { setCounter ∷ Int
                                      → Eff (console ∷ CONSOLE,
                                             dom ∷ DOM,
                                             props ∷ ReactProps ,
                                             refs ∷ ReactRefs (read ∷ Read) ,
                                             state ∷ ReactState (read ∷ Read , write ∷ Write) | eff) Unit }
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

