# RSVP Parsers

Parsers are used by the RSVP system to turn a schema source into a
`Rsvp::Schema` object. Unfortunately, Ruby doesn't have a concept of interfaces
or abstract classes to enforce requirements on custom implementations of code
pieces. This README document exists to define what methods must exist in a
parser, as these are the functions that will be used by the rest of the core
RSVP system.

## Construction

Parsers don't need to implement the `initialize` method, but they can if they
want. The RSVP core classes construct new parsers using the `send` method along
with an argument array that is extracted from the initial call to generate a
schema object.

## Schema Generation

The main function that absolutely must be implemented in a strict manner is
`generate/0`. For those not familiar with the syntax I just used, it is the
function name followed by the function **arity**, which is the number of
arguments required by the function. In this case, I'm saying "a function called
'generate' that takes zero arguments."

The `generate/0` function **must** return either `nil` or an instance of
`Rsvp::Schema`. Returning a `nil` value means that the function failed for some
reason. Returning an instance of `Rsvp::Schema` means the function succeeded and
Ruby objects may now be validated against the schema object.

## Error Inspection

If the `generate/0` function has a failure condition that results in a `nil`
return value, then it must also provide another function: `errors/0`. The return
value **must** be an `Array` with one or more strings. Each string in the array
is an error message or code of some kind, which should help the developer
identify why the generate function failed and what they should do to fix it.

## Interface Mock

Here is the short version of what is written in this document, in the form of a
fake interface.

    interface Rsvp::Parser
      Rsvp::Schema? generate()
      Array[String] errors()

The `?` at the end of `Rsvp::Schema?` takes it root from C#, which has something
called _Nullable Types_. This would allow non-reference types to possibly be
null, such as `int? width = null`. I just like the shorthand syntax it uses to
denote "X or Null" types.
