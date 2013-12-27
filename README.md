# rsvp

Ruby Schema Validation Project

## What is it?

An attempt to create a more universal schema format that can be used in Ruby
projects to validate _any_ incoming data, as long as it is a RUby object. At the
time of writing this the two data containers being focused on are YAML and
JSON.

## Why RSVP?

Aside from the fact it's polite? Seriously though, I have yet to see a clean,
simple, and straight-forward schema format that can be used against a variety
of different data containers. I was also having trouble finding a recent and
active YAML schema validation tool, specifically one written in Ruby. So here is
my attempt at one!

## How it works

The awesome part about RSVP is that you can write the schema in any data
container that can be parsed into a Ruby `Hash` or `Array`. I'll use YAML for my
examples, but only because I believe it has a clean and easy-to-read format. You
could use JSON, or even raw Ruby constructs; as long as it converts into a Ruby
object it can be considered a candidate for being the representation of a
desired schema.

Once you have your schema object constructed, you simply pass in a target Ruby
object for validation against the schema. The result of the validation is an
object with two key components: `valid?` and `errors`. The former returns `true`
if the object was considered valid or `false` if it wasn't. The latter is only
used in the case of invalid results, and contains an array of errors.

### Examples, oh boy!

    schema = Rsvp::Generator.from_yaml("schema.yaml")
    result = schema.validate(target)
    if result.valid?
      # `target` object is valid according to schema.yaml
    else
      # did not successfully validate; inspect `result.errors` for details
    end

The above example created a schema object from a YAML source file, then passed
in an arbitrary object `target` to be validated. Then we can use an if/else
block testing `result.valid?`, which is `true` if the object was valid and
`false` otherwise. Simple. The best part is that as long as the schema object is
created properly, you can use any source format to define a schema and validate
a Ruby object!

## Developer's Note

As of writing this, RSVP is targeted for use by another project of mine,
[Ruby View Abstractor][rva]. That means I will be developing, at first, with the
needs of the Ruby View Abstractor in mind. However, I hope the community likes
this concept and decides to help me grow and maintain the project. And since I
am using it for my Ruby View Abstractor project, any interested in seeing how
RSVP may be used in a real-life development effort can check out the abstractor.

[rva]: https://github.com/kolorahl/ruby-view-abstractor
