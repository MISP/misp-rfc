%%%
Title = "MispQL: A Query Language for Cyber Threat Intelligence"
abbrev = "MispQL"
category = "info"
docName = "draft-dulaunoy-mispql-00"
ipr = "trust200902"
area = "Security"
submissiontype = "independent"
date = 2026-11-26T00:00:00Z

[seriesInfo]
name = "Internet-Draft"
value = "draft-dulaunoy-mispql-00"
stream = "independent"
status = "informational"

[[author]]
initials = "A."
surname = "Dulaunoy"
fullname = "Alexandre Dulaunoy"
abbrev = "CIRCL"
organization = "Computer Incident Response Center Luxembourg"
 [author.address]
 email = "alexandre.dulaunoy@circl.lu"
%%%

.# Abstract

MispQL is a read-only, SQL-like query language for cyber threat
intelligence (CTI). This document specifies its text syntax using
Augmented Backus-Naur Form (ABNF), its query semantics, and a JSON
representation for its Boolean filters. A CTI platform can implement
MispQL over its own data model by describing the tables, fields, types,
and operators it supports. A transport binding describes how the Python
MispQL client uses the complex-search interface in MISP 3.0.

{mainmatter}

# Introduction

CTI platforms store indicators, event reports, analyst annotations, and
other records that analysts need to search across tools. MispQL provides
a common way to express such searches, including Boolean conditions,
projection, sorting, pagination, and counts. The language originated
in the MISP project. Its earlier MISP query format [@?MISP-QUERY]
describes legacy REST filters. This document specifies MispQL text and
composable filter trees as a separate interface.

A *table* is a named collection of records exposed by a platform. A
*schema profile* defines the tables and semantics an implementation
exposes to a caller. A *binding* maps a query or its filter to a
particular execution interface. Implementations can share the language
across different storage engines and transports. A query that names
fields from a particular profile is portable to platforms that expose
the same profile and implement the capabilities the query uses.

## Conventions and Terminology

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
"SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and
"OPTIONAL" in this document are to be interpreted as described in
BCP 14 [@!RFC2119] [@!RFC8174] when, and only when, they appear in
all capitals, as shown here.

# Text Syntax

This section defines the grammar in ABNF [@!RFC5234]. Quoted ABNF
strings are ASCII case-insensitive. Literal input is UTF-8
[@!RFC3629]. The start rule is `script`. A semicolon separates
statements. Leading, repeated, and trailing semicolons are allowed.
The final statement can end at end of input.

## Lexical Rules

Before applying the statement rules, a lexer MUST use the following
token boundaries to resolve adjacent tokens.

* A maximal run of ASCII letters, digits, and underscores is one
  word. A word beginning with a digit MUST consist entirely of
  digits. A lexer MUST NOT split a word to obtain a keyword or
  integer. For example, `SELECTid` and `100AND` are single words.
* `reserved` enumerates the keywords. Those words are recognized
  case-insensitively and MUST be quoted with backticks when used
  as identifiers. Unquoted identifiers are folded to ASCII
  lowercase. Quoted identifiers preserve their spelling and MUST
  decode to a nonempty value.
* Single and double quotes delimit strings. Backticks delimit
  identifiers. Two consecutive copies of the current delimiter
  within a quoted token encode one copy of that delimiter.
  Backslash is an ordinary character. A lexer MUST consume a
  quoted token through its first undoubled closing delimiter.
* Outside quotes, `--` starts a comment through the next LF or end
  of input. The lexer consumes the longest comparison operator
  available, so `>=`, `<=`, `<>`, and `!=` are each a single token.
  Optional whitespace and comments occur only at the positions of
  `ws`. In particular, a hyphenated name contains no whitespace.

## ABNF

The lexical rules and the ABNF together define syntactic validity.
Schema and clause checks are applied after parsing.

~~~ abnf
script          = ws *(";" ws)
                  [statement *(ws 1*(";" ws) statement)
                   ws *(";" ws)] [eof-comment]

statement       = select-stmt / show-tables / describe-stmt
                  / session-stmt
select-stmt     = "SELECT" ws projection ws "FROM" ws name
                  [ws where-clause] [ws order-clause]
                  [ws limit-clause] [ws offset-clause]
                  [ws format-clause]

projection      = "*" / "COUNT" ws "(" ws "*" ws ")"
                  / field *(ws "," ws field)
where-clause    = "WHERE" ws expression
order-clause    = "ORDER" ws "BY" ws order-item
                  *(ws "," ws order-item)
order-item      = field [ws ("ASC" / "DESC")]
limit-clause    = "LIMIT" ws uint
offset-clause   = "OFFSET" ws uint
format-clause   = "FORMAT" ws format-name

expression      = and-expr *(ws "OR" ws and-expr)
and-expr        = not-expr *(ws "AND" ws not-expr)
not-expr        = "NOT" ws not-expr / "(" ws expression ws ")"
                  / predicate
predicate       = field ws (comparison ws literal
                  / [ "NOT" ws ] ("IN" ws literal-list
                  / "LIKE" ws string))
comparison      = "<=" / ">=" / "<>" / "!=" / "=" / "<" / ">"
literal-list    = "(" ws literal *(ws "," ws literal) ws ")"
literal         = string / integer / "TRUE" / "FALSE"
integer         = ["-" ws] uint
uint            = 1*DIGIT

show-tables     = "SHOW" ws "TABLES"
describe-stmt   = ("DESCRIBE" / "DESC") ws name
session-stmt    = "SHOW" ws "DATABASES"
                  / "USE" ws database-name / "WHOAMI"

field           = name *(ws "." ws name)
name            = bare-name / quoted-name
bare-name       = word-name  ; excluding reserved words
word-name       = (ALPHA / "_") *(ALPHA / DIGIT / "_")
hyphen-tail     = *("-" (word-name / uint))
format-name     = word-name hyphen-tail / quoted-name / string
database-name   = bare-name hyphen-tail / quoted-name

reserved        = "AND" / "ASC" / "BY" / "COUNT" / "DATABASES"
                  / "DESC" / "DESCRIBE" / "FALSE" / "FORMAT"
                  / "FROM" / "IN" / "LIKE" / "LIMIT" / "NOT"
                  / "OFFSET" / "OR" / "ORDER" / "SELECT" / "SHOW"
                  / "TABLES" / "TRUE" / "USE" / "WHERE" / "WHOAMI"

string          = squote *(sq-char / squote squote) squote
                  / DQUOTE *(dq-char / DQUOTE DQUOTE) DQUOTE
quoted-name     = backtick 1*(bt-char / backtick backtick)
                  backtick
squote          = %x27
backtick        = %x60
sq-char         = quoted-ws / %x20-26 / %x28-7E / utf8-non-ascii
dq-char         = quoted-ws / %x20-21 / %x23-7E / utf8-non-ascii
bt-char         = quoted-ws / %x20-5F / %x61-7E / utf8-non-ascii
quoted-ws       = HTAB / CR / LF

ws              = *(SP / HTAB / CR / LF / line-comment)
line-comment    = "--" *comment-char LF
eof-comment     = "--" *comment-char
comment-char    = HTAB / CR / %x20-7E / utf8-non-ascii

utf8-non-ascii  = %xC2-DF tail-byte
                  / %xE0 %xA0-BF tail-byte
                  / %xE1-EC 2tail-byte
                  / %xED %x80-9F tail-byte
                  / %xEE-EF 2tail-byte
                  / %xF0 %x90-BF 2tail-byte
                  / %xF1-F3 3tail-byte
                  / %xF4 %x80-8F 2tail-byte
tail-byte       = %x80-BF
~~~

# Query Semantics

## Schema Profiles and Validation

An implementation MUST validate the syntax and all names, value
types, operators, and clause combinations for the selected binding
and schema profile. It MUST reject an invalid or unsupported query as a
whole, without running a version with any condition or clause omitted.

A profile MUST document the exposed tables, filter fields and their
types and permitted operators, projected and sortable fields,
comparison and sort collations, default ordering, and any defaults
or limits on result size. Filter, projection, and sort capabilities
can differ for the same field. A profile MUST also describe any
aliases, how qualification and nested names are resolved, and how a
field drawn from related or multivalued records matches. For example, a
profile might define a related field to match a parent when at least
one visible child satisfies the predicate. Two independent predicates
on related fields do not imply that the same child satisfies both
predicates, unless the profile explicitly defines that behavior.

A field name can be a single identifier or a dotted path. A dot
inside a backtick-quoted identifier is part of that identifier.
A binding that flattens paths MUST resolve the name against the
profile before translating it and reject ambiguous mappings.

An implementation of the portable query language MUST support
row selection, projection, Boolean filters, and counting on at
least one exposed table. Operator support is described per field.
An implementation MUST support discovery through the text commands
or an equivalent programmatic interface. Support for a particular
schema profile, sort field, output format, or session command can
be claimed independently. The MISP binding has profile-specific
restrictions described below.

## Filtering and Types

`WHERE` selects rows for which the expression is true. Parentheses
group expressions. From highest to lowest precedence, predicates
and parenthesized expressions bind before unary `NOT`, which binds
before `AND`, which binds before `OR`. `AND` requires all operands
to match and `OR` requires at least one. A query without `WHERE`
selects all visible rows subject to the other clauses and limits.

`=` tests equality. `!=` and `<>` are equivalent spellings.
`IN` tests equality with any member of a nonempty list. `LIKE`
matches a string using a pattern that contains a nonempty literal
portion and one `%` at the beginning, at the end, or at both ends.
A `%` matches zero or more characters. An internal `%` is invalid
in this pattern. Underscore and backslash are literal characters in
the portable pattern syntax. `!=`, `NOT IN`, and `NOT LIKE` are
the Boolean complements of `=`, `IN`, and `LIKE` respectively in
the portable semantics.

The ordered comparison operators `<`, `<=`, `>`, and `>=` apply
to ordered types declared in the profile. For portable field types
these are integers, timestamps, dates, and datetimes. Strings,
integers, and Booleans are distinct literal types. A numeric string
MUST NOT be silently converted to an integer. Each operand of `IN`
MUST be valid for the declared field type. A literal has no NULL,
floating-point, or implicit field-reference form. In the portable
semantics a missing or null field does not satisfy a positive
predicate. Its negation is true when the positive predicate is false.

A profile that exposes timestamps SHOULD accept integer seconds
since 1970-01-01 00:00:00 UTC. Profiles MAY support relative time
on temporal fields using a quoted unsigned decimal followed by
`d`, `h`, `m`, or `s` for days, hours, minutes, or seconds ago.
A profile that supports relative time MUST specify its clock,
calendar and time zone rules, and permitted units for each temporal
type. It MUST use one reference time per logical query, including
pages that together implement one query. Date and datetime strings
are lexical strings and are checked against the field type after
parsing.

A binding that provides special field or operator semantics MUST
document them as profile-specific behavior. A translator MUST
reject a query if it cannot preserve the requested semantics.

## Projection, Counting, Ordering, and Pagination

`SELECT *` returns the profile's default row representation.
An explicit projection returns the listed fields in the specified
order. `SELECT COUNT(*)` returns one nonnegative integer giving
the number of visible rows that match the filter. It requires a
`WHERE` and MUST NOT contain `ORDER BY`, `LIMIT`, `OFFSET`, or
`FORMAT`. An ordinary row query MUST include `WHERE` or `LIMIT`.

`ORDER BY` compares the listed keys in order. The first key that
differs determines the order. `ASC` is the default direction and
`DESC` reverses it. A profile MUST specify where missing and null
sort keys appear. An implementation SHOULD use a stable
tie-breaker for paginated results. `OFFSET` skips a zero-based
number of matching rows in the effective order, and `LIMIT` caps
the remaining results at a positive whole number. `OFFSET`
requires `LIMIT`. Concurrent data changes can affect paging when
the binding provides no snapshot isolation.

`FORMAT` requests a representation supported by the binding.
The profile MUST specify any restrictions on combining a format
with projection or pagination. An implementation MUST reject an
unsupported format rather than silently choosing a different one.

## Discovery and Session Commands

`SHOW TABLES` lists the tables available to the caller.
`DESCRIBE table` (also `DESC table`) describes the table's
schema and query capabilities. A profile SHOULD expose this
information programmatically, including limits where available.
Discovery MUST respect the caller's authorization.

`SHOW DATABASES`, `USE`, and `WHOAMI` are optional client
session commands. They list configured connections, select a
configured connection for subsequent statements, or display the
identity associated with the active connection, respectively.
They do not change data or form part of the filter representation.
An implementation without session support MUST reject such a
statement explicitly.

# JSON Filter Representation

A binding MAY exchange the `WHERE` expression as a JSON
[@!RFC8259] tree. This section defines the tree for that binding.
Each node is an object with exactly one member. Duplicate member
names MUST be rejected before evaluating a tree. The names `AND`,
`OR`, and `NOT` are reserved, case-sensitive tree keys.

| Node | Member value |
|------|--------------|
| `AND` or `OR` | A nonempty array of nodes |
| `NOT` | One node |
| A profile-resolved field name | A scalar or a one-member operator object |

A scalar MUST be a JSON string, Boolean, or integer number. JSON
integers in this format use the JSON integer syntax without a
fraction or exponent. Senders SHOULD stay within the interoperable
exact-integer range of JSON when the receiver's precision is
unknown. JSON null is invalid. An unwrapped scalar is shorthand
for equality. Operator object keys are the case-sensitive strings
in the following table.

| Operator keys | Member value |
|---------------|--------------|
| `=`, `!=`, `<`, `<=`, `>`, `>=` | A scalar accepted by the field |
| `IN`, `NOT IN` | A nonempty array of scalars accepted by the field |
| `LIKE`, `NOT LIKE` | A pattern string |

A translator MUST preserve the Boolean grouping and literal
types, normalize `<>` to `!=`, and resolve field names using the
profile. It MAY flatten adjacent identical `AND` or `OR` nodes
where grouping has no effect on the profile semantics. Table
selection, projection, paging, sorting, and output representation
remain outside the tree. This document defines no common request
envelope or result serialization for those parameters.

# Examples

These examples use an `attributes` table with integer `id` and
`timestamp` fields and string `type` and `value` fields.
`timestamp` is a UTC epoch timestamp and also accepts relative
time. The table supports sorting by `id` and projecting `id`,
`type`, and `value`. A CTI platform can map those fields to
its native indicator records.

## Filter, Sort, and Page

The following query selects domain and destination-IP attributes
with `id` greater than 50000, orders them by decreasing `id`,
skips ten matches, and returns up to ten rows.

~~~ sql
SELECT id, type, value FROM attributes
WHERE (type = 'domain' OR type = 'ip-dst') AND id > 50000
ORDER BY id DESC LIMIT 10 OFFSET 10;
~~~

The filter tree for this query is:

~~~ json
{
  "AND": [
    {"OR": [{"type": "domain"}, {"type": "ip-dst"}]},
    {"id": {">": 50000}}
  ]
}
~~~

`type IN ('domain', 'ip-dst')` is equivalent to the parenthesized
disjunction in this profile.

## Count Recent Indicators

This query counts visible domain attributes whose value ends in
`.example.org` and whose timestamp is at least as recent as the
cutoff seven days ago.

~~~ sql
SELECT COUNT(*) FROM attributes
WHERE type = 'domain' AND value LIKE '%.example.org'
  AND timestamp >= '7d';
~~~

The portable filter tree is:

~~~ json
{
  "AND": [
    {"type": "domain"},
    {"value": {"LIKE": "%.example.org"}},
    {"timestamp": {">=": "7d"}}
  ]
}
~~~

## Discovery and Quoting

~~~ sql
SHOW TABLES;
DESCRIBE attributes;
-- The literal value contains a single quote.
SELECT id FROM attributes WHERE value = 'analyst''s note' LIMIT 1;
~~~

## Negation and Membership

The following query selects attributes that are neither a domain
nor a destination IP and have an ID of at least 50000.

~~~ sql
SELECT id FROM attributes
WHERE NOT (type IN ('domain', 'ip-dst')) AND id >= 50000;
~~~

~~~ json
{
  "AND": [
    {"NOT": {"type": {"IN": ["domain", "ip-dst"]}}},
    {"id": {">=": 50000}}
  ]
}
~~~

## Invalid Queries

* `SELECT * FROM attributes WHERE id IN ();` is a syntax error
  because `IN` requires at least one operand.
* `SELECT * FROM attributes WHERE id = '50001';` parses but
  fails type validation for an integer field.
* `SELECT * FROM attributes WHERE id > 50000 OFFSET 10;`
  parses but fails validation because `OFFSET` requires `LIMIT`.
* `SELECT COUNT(*) FROM attributes WHERE id > 50000 LIMIT 1;`
  parses but fails validation because a count has no `LIMIT`.
* `SELECT * FROM attributes WHERE value LIKE 'a%b%';`
  parses but fails pattern validation because `%` is internal.

# MISP Binding

The MISP complex-search interface [@?MISP-COMPLEX] accepts the
filter tree in the `query` member of a JSON body sent by HTTP POST
to the selected `restSearch` endpoint. The table determines the
endpoint. For example, `attributes` maps to
`/attributes/restSearch`, while `notes` maps to
`/analyst_data/restSearch/Note`. The corresponding `queryDescribe`
endpoints expose field types, operators, sort capabilities, and
limits. Access to complex queries requires the applicable MISP
permission. MISP applies its access controls and any legacy
filters in conjunction with the supplied query.

For the paging example, the Python client can send the following
body to `/attributes/restSearch`. MISP numbers pages from one.
The client projects the returned rows to the requested columns.

~~~ json
{
  "returnFormat": "json",
  "limit": 10,
  "page": 2,
  "order": ["id desc"],
  "query": {
    "AND": [
      {"OR": [{"type": "domain"}, {"type": "ip-dst"}]},
      {"id": {">": 50000}}
    ]
  }
}
~~~

For an arbitrary offset the Python client can fetch adjacent pages
and trim parsed rows as necessary. For an export returned verbatim,
it requires the offset to be a multiple of the limit. A count is
read from the body for attributes and from `X-Result-Count` for
events using a one-row metadata request. These transport details
are specific to this binding.

MISP field semantics are defined by the target endpoint. For example,
some related fields on events and objects allow only positive
operators. Negated tag filters can also redact nested results, and
tags have special matching rules. MISP validates pattern and value
forms, including rejecting empty strings on its string fields and
rejecting equality or membership strings that begin or end with
`%`. Datetime interpretation can depend on the table. A client
targeting MISP MUST use its advertised capabilities and binding
rules rather than assuming that syntactic validity implies support.

Some versions of MISP can ignore an unrecognized `query` key.
A client MUST establish support before sending a filter and MUST
treat denied or unavailable discovery as a failure to execute the
filtered query. The Python client checks the response from
`/attributes/queryDescribe` before using the complex-search
interface, scoped to its active connection.

# Implementation Status

The open-source MispQL CLI and Python library [@?MISPQL-PY]
implement the text lexer, parser, and compiler. The compiler
produces request plans for the MISP binding. The CLI executes the
requests, while the library also supports callers that handle
transport themselves.

The MISP 3.0 development branch [@?MISP-3] implements the
server side of that binding. Its complex-query engine validates
the JSON tree and evaluates it through MISP's REST search
endpoints [@?MISP-COMPLEX]. The server interface consumes
structured filters. The Python client provides the text syntax
in front of it. These are implementations of complementary
parts of the binding. The proposed portable profile rules in
this draft can be used by other CTI platforms.

# Security Considerations

MispQL input and all decoded field names and values are untrusted.
A service MUST resolve field names and operators against an
allowlist and use parameterized values or a structured backend
query API. It MUST NOT treat MispQL source or decoded strings as
backend SQL or command text.

Authorization MUST apply before filtering, projection, sorting,
counting, paging, and other observable operations. An
implementation MUST also enforce authorization for related
records consulted by predicates. A service MUST NOT expose
restricted data through counts, sort keys, cursors, or discovery.
A client MUST NOT retry a denied or unsupported filter as an
unfiltered search.

Implementations SHOULD bound input size, tree depth, number of
nodes, operand lengths, list sizes, page size, and execution
time. Large disjunctions, substring searches, negation, and
queries over related records can be costly even when they return
few results. Implementations SHOULD apply limits before backend
execution where possible and return a clear error when execution
cannot finish within the applicable limits.

Queries, errors, and responses may contain sensitive intelligence.
Remote bindings SHOULD use authenticated and encrypted transport.
Implementations SHOULD avoid exposing credentials or sensitive
literals in diagnostic messages and logs. Clients that support
multiple connections MUST scope credentials to their intended
service and SHOULD make the active connection apparent before
executing a query.

# IANA Considerations

This document requests no IANA actions.

<reference anchor="MISP-QUERY" target="https://github.com/MISP/misp-rfc/blob/main/misp-query-format/raw.md">
  <front>
    <title>MISP query format</title>
    <author initials="A." surname="Dulaunoy" fullname="Alexandre Dulaunoy"/>
    <author initials="A." surname="Iklody" fullname="Andras Iklody"/>
    <date year="2018" month="October"/>
  </front>
</reference>

<reference anchor="MISPQL-PY" target="https://github.com/MISP/MispQL">
  <front>
    <title>MispQL CLI and Python library</title>
    <author><organization>MISP Project</organization></author>
    <date/>
  </front>
</reference>

<reference anchor="MISP-3" target="https://github.com/MISP/MISP/tree/3.0_wip">
  <front>
    <title>MISP 3.0 development branch</title>
    <author><organization>MISP Project</organization></author>
    <date/>
  </front>
</reference>

<reference anchor="MISP-COMPLEX" target="https://github.com/MISP/MISP/blob/3.0_wip/docs/restsearch-complex-query.md">
  <front>
    <title>Complex queries in restSearch</title>
    <author><organization>MISP Project</organization></author>
    <date/>
  </front>
</reference>

{backmatter}
