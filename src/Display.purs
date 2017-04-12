module Display where
import Prelude (show)
import React(ReactClass, createClassStateless)
import React.DOM
import React.DOM.Props as P

displayStyle ∷ { height ∷ String,
                 width ∷ String,
                 padding ∷ String,
                 margin ∷ String,
                 border ∷ String,
                 borderRadius ∷ String,
                 alignItems ∷ String,
                 display ∷ String,
                 justifyContent ∷ String,
                 fontSize ∷ String }
displayStyle = {
  height: "100px",
  width: "100px",
  padding: "2px",
  margin: "10px",
  border: "2px solid",
  borderRadius: "10px",
  alignItems: "center",
  display: "flex",
  justifyContent: "center",
  fontSize: "40px"
}

display ∷ ∀t. ReactClass { counter ∷ Int | t }
display = createClassStateless \props -> div [P.style displayStyle, P.className "mx-auto"]
                                             [text (show props.counter)]
