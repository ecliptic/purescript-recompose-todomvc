module Test.Todo.State.Todos (testTodosState) where

import Prelude
import Control.Monad.Aff.AVar (AVAR)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Eff.Ref (REF)
import Data.Array ((:))
import Test.Unit (TIMER, TestSuite, suite, test)
import Test.Unit.Assert as Assert

import Todo.State.Todos (Action(..), State(..), Todo(..), update)

testTodosState :: forall eff. TestSuite
  ( err :: EXCEPTION, avar :: AVAR, timer :: TIMER, ref :: REF | eff )
testTodosState = suite "Test.Examples.Todos.State.Todos" do
  suite "update" do
    test "handles Add actions" do
      let initialState = State
            { todos: [ Todo { text: "Bowties are cool", id: 0, completed: false } ]
            , lastId: 0 }
          todo = Todo { text: "Sonic screwdrivers are pretty good, too", id: 1, completed: false }
          expected = initialState #
            \(State state) -> State
              state { todos = todo : state.todos, lastId = 1 }
          result = update (Add "Sonic screwdrivers are pretty good, too") initialState
      Assert.equal expected result

    test "handles Delete actions" do
      let initialState = State
            { todos: [ Todo { text: "Bowties are cool", id: 0, completed: false } ]
            , lastId: 0 }
          expected = State { todos: [], lastId: 0 }
          result = update (Delete 0) initialState
      Assert.equal expected result

    test "handles Edit actions" do
      let initialState = State
            { todos: [ Todo { text: "Bowties are cool", id: 0, completed: false } ]
            , lastId: 0 }
          expected = State
            { todos: [ Todo { text: "Sonic screwdrivers are pretty good, too", id: 0, completed: false } ]
            , lastId: 0 }
          result = update (Edit 0 "Sonic screwdrivers are pretty good, too") initialState
      Assert.equal expected result

    test "handles Complete actions" do
      let initialState = State
            { todos: [ Todo { text: "Bowties are cool", id: 0, completed: false } ]
            , lastId: 0 }
          expected = State
            { todos: [ Todo { text: "Bowties are cool", id: 0, completed: true } ]
            , lastId: 0 }
          result = update (Complete 0 true) initialState
      Assert.equal expected result

    test "handles CompleteAll actions" do
      let initialState = State
            { todos:
              [ Todo { text: "Bowties are cool", id: 0, completed: false }
              , Todo { text: "Sonic screwdrivers are pretty good, too", id: 0, completed: false } ]
            , lastId: 0 }
          expected = State
            { todos:
              [ Todo { text: "Bowties are cool", id: 0, completed: true }
              , Todo { text: "Sonic screwdrivers are pretty good, too", id: 0, completed: true } ]
            , lastId: 0 }
          result = update CompleteAll initialState
      Assert.equal expected result

    test "handles ClearComplete actions" do
      let initialState = State
            { todos:
              [ Todo { text: "Bowties are cool", id: 0, completed: true }
              , Todo { text: "Sonic screwdrivers are pretty good, too", id: 0, completed: true } ]
            , lastId: 0 }
          expected = State { todos: [], lastId: 0 }
          result = update ClearComplete initialState
      Assert.equal expected result
