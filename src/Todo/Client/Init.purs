module Todo.Client.Init (init) where

import Prelude
import Control.Monad.Eff (Eff)
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Document (body)
import DOM.HTML.Types (htmlElementToNode, htmlDocumentToDocument)
import DOM.HTML.Window (document)
import DOM.Node.Document (createElement) as Document
import DOM.Node.Element (setAttribute)
import DOM.Node.Node (appendChild)
import DOM.Node.Types (elementToNode)
import Data.Maybe (Maybe, fromJust)
import Data.Nullable (toMaybe)
import Partial.Unsafe (unsafePartial)
import React (ReactClass, ReactComponent)
import React (createElement) as React
import ReactDOM (render)
import Todo.State.Store (createStore, initialState)
import Todo.Utils.Redux (provider, STORE)

foreign import app :: ReactClass {}

init :: forall eff. Eff (dom :: DOM, store :: STORE | eff) (Maybe ReactComponent)
init = do
  htmlDocument <- window >>= document
  htmlBody <- map (unsafePartial (fromJust <<< toMaybe)) $ body htmlDocument

  -- Create an element to house the application
  container <- Document.createElement "div" $ htmlDocumentToDocument htmlDocument
  setAttribute "id" "app" container

  -- Append it to the body
  appendChild (elementToNode container) (htmlElementToNode htmlBody)

  -- Kick off the store
  store <- createStore initialState

  -- Create an element instance from the app component
  let appElement = React.createElement app {} []
      element = React.createElement provider { store: store } [ appElement ]

  -- Render the element to the container
  render element container
