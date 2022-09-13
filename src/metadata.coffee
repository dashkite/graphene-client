import * as Meta from "@dashkite/joy/metaclass"

import {
  invoke
  wrap
  timestamps
} from "./helpers"

class List

  Meta.mixin @, [
    wrap
  ]

  Meta.mixin @::, [
    Meta.getters
      entries: -> Metadata.wrap @parent, entry for entry in @_        
  ]

class Metadata

  @List: List

  Meta.mixin @, [
    invoke
    wrap
  ]

  Meta.mixin @::, [
    timestamps
    Meta.getters
      db: -> @_.db
      collection: -> @_.collection
      entry: -> @_.entry
      key: -> @_.entry
      content: -> @_.content
  ]

  @get: ( parent, entry ) ->
    { db, collection } = parent
    @wrap parent,
      await @invoke parent,
        resource: 
          name: "metadata"
          bindings: { db, collection, entry }
        method: "get"

  @put: ( parent, entry, content ) ->
    { db, collection } = parent
    @wrap parent,
      await @invoke parent,
        resource: 
          name: "metadata"
          bindings: { db, collection, entry }
        content: content
        method: "put"

  @list: ( parent ) ->
    { db, collection } = parent
    @wrap parent,
      await @invoke parent,
        resource:
          name: "metadata list"
          bindings: { db, collection }
        method: "get"

  @query: ( parent, query ) ->
    { db, collection } = parent
    @wrap parent,
      await @invoke parent,
        resource: 
          name: "metadata query"
          bindings: { db, collection, query  }
        method: "get"

  @queryAll: ( parent, query ) ->
    { db, collection } = parent
    @wrap parent,
      await @invoke parent,
        resource: 
          name: "metadata query all"
          bindings: { db, collection, query  }
        method: "get"

  @delete: ( parent, entry ) ->
    { db, collection } = parent
    @invoke parent,
      resource:
        name: "metadata"
        bindings: { db, collection, entry }
      method: "delete"

export { Metadata }