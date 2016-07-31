module Todo (init) where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION)
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
import React (ReactComponent)
import React (createElement) as React
import ReactDOM (render)
import Todo.Components.Layout.App (view)
import Todo.State.Store (createStore)
import Signal.Channel (CHANNEL)

init :: forall eff. Eff ( channel :: CHANNEL, dom :: DOM, err :: EXCEPTION | eff ) (Maybe ReactComponent)
init = do
  htmlDocument <- window >>= document
  htmlBody <- map (unsafePartial (fromJust <<< toMaybe)) $ body htmlDocument

  -- Create an element to house the application
  container <- Document.createElement "div" $ htmlDocumentToDocument htmlDocument
  setAttribute "id" "app" container

  -- Append it to the body
  appendChild (elementToNode container) (htmlElementToNode htmlBody)

  -- Kick off the store
  store <- createStore

  -- Render the app to the container
  render (React.createElement view { store: store } []) container
