import * as Meta from "@dashkite/joy/metaclass"

import {
  proxy
  invoke
  wrap
  timestamps
} from "./helpers"

class Index

  Meta.mixin @, [
    invoke, wrap
  ]

  Meta.mixin @::, [

    Meta.getters
      db: -> @_.db
      collection: -> @_.collection
      key: -> @_.key
      sort: -> @_.sort
      status: -> @_.status
  ]

  @create: ( parent, { key, sort }) ->
    { db, collection } = parent
    @wrap parent, await do =>
      @invoke parent,
        resource: 
          name: "collection indices"
          bindings: { db, collection }
        content: { key, sort }
        method: "post"    

  @list: ( parent ) ->
    { db, collection } = parent
    @invoke parent,
      resource: 
        name: "collection indices"
        bindings: { db, collection }
      method: "get"

  @get: ( parent, { key, sort } ) ->
    { db, collection } = parent
    @wrap parent, await do =>
      try
        @invoke parent,
          resource: 
            name: "collection index"
            bindings: { db, collection, key, sort }
          method: "get"

  @delete: ( parent, { key, sort } ) ->
    { db, collection } = parent
    @wrap parent, await do =>
      try
        @invoke parent,
          resource: 
            name: "collection index"
            bindings: { db, collection, key, sort }
          method: "delete"
  
export { Index }