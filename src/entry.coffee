import * as Fn from "@dashkite/joy/function"
import * as Meta from "@dashkite/joy/metaclass"

import {
  invoke
  wrap
} from "./helpers"

class List

  Meta.mixin @, [
    invoke
    wrap
  ]

class Entry

  @List: List

  Meta.mixin @, [
    invoke
    wrap
  ]

  @get: (parent, entry ) ->
    { db, collection } = parent
    @invoke parent,
      resource: 
        name: "entry"
        bindings: { db, collection, entry  }
      method: "get"

  @put: ( parent, entry, content ) ->
    { db, collection } = parent
    @invoke parent,
      resource: 
        name: "entry"
        bindings: { db, collection, entry  }
      content: content
      method: "put"

  @list: ( parent ) ->
    { db, collection } = parent
    @invoke parent,
      resource:
        name: "entry list"
        bindings: { db, collection  }
      method: "get"

  @query: ( parent, query ) ->
    { db, collection } = parent
    @invoke parent,
      resource: 
        name: "entry query"
        bindings: { db, collection, query  }
      method: "get"

  @queryAll: ( parent, query ) ->
    { db, collection } = parent
    @invoke parent,
      resource: 
        name: "entry query all"
        bindings: { db, collection, query  }
      method: "get"

  @delete: ( parent, entry ) ->
    { db, collection } = parent
    @invoke parent,
      resource:
        name: "entry"
        bindings: { db, collection, entry }
      method: "delete"

  @increment: ( parent, entry, property ) ->
    { db, collection } = parent
    { content } = await @invoke parent,
      resource:
        name: "atomic update"
        bindings: { db, collection, entry, property: "views", expression: "+1" }
      method: "post"
    # TODO maybe this is what the API should return?
    content[ property ]

  @decrement: ( parent, entry, property ) ->
    { db, collection } = parent
    { content } = await @invoke parent,
      resource:
        name: "atomic update"
        bindings: { db, collection, entry, property: "views", expression: "-1" }
      method: "post"
    # TODO maybe this is what the API should return?
    content[ property ]

class Entries
  @fromConfiguration: ( client, configuration ) ->
    do Fn.flow [
      -> client.db.get configuration.db
      ( db ) -> db.collections.get configuration.collection
      (collection) -> collection.entries
    ]


export { Entry, Entries }