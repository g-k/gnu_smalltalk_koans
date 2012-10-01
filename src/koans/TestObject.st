Koan subclass: TestObject [
  <comment: 'A collection of object tests.'>

  testEverythingIsAnObject [
    self expect: true toEqual: (1 isMemberOf: SmallInteger).
    self expect: true toEqual: (1.5 isMemberOf: FloatD).
    self expect: true toEqual: ((1/2) isMemberOf: Fraction).
    self expect: true toEqual: ('skim' isMemberOf: String).
    self expect: true toEqual: (nil isMemberOf: UndefinedObject).
    self expect: true toEqual: (Object isMemberOf: Object class).
  ]

  testSomeObjectsCanBeConvertedToStrings [
    self expect: '12345' toEqual: 12345 asString.
    self expect: '5/8' toEqual: (5/8) asString.
  ]

  testNilObjectCannotBeConvertedToString [
    self expect: [ nil asString ] toRaise: MessageNotUnderstood.
  ]

  testObjectsCanBeInspected [
    "
    Try out these examples on GNU Smalltalk (gst) REPL:

    1234 inspect.
    'qwerty' inspect.
    nil inspect.

     st> 1234 inspect
     An instance of SmallInteger
     1234
     st> 'qwerty' inspect
     An instance of String
     contents: [
     [1]: $q
     [2]: $w
     [3]: $e
     [4]: $r
     [5]: $t
     [6]: $y
     ]
     'qwerty'
     st> nil inspect
     An instance of UndefinedObject
     nil
    "
  ]

  testEveryObjectHasAnId [
    | object |
    object := Object new.

    self expect: SmallInteger toEqual: object hash class.
  ]

  testEveryObjectHasADifferentId [
    | object anotherObject |
    object := Object new.
    anotherObject := Object new.

    self expect: true toEqual: (object hash ~= anotherObject hash).
  ]

  testSomeSystemObjectsAlwaysHaveTheSameId [
    self expect: -1 toEqual: false hash.
    self expect: -2 toEqual: true  hash.
    self expect: -3 toEqual: nil   hash.
  ]

  testMostIntegersHaveFixedIds [
    self expect: 0 toEqual: 0      hash.
    self expect: 1 toEqual: 1      hash.
    self expect: 100000 toEqual: 100000 hash.
  ]

  testCopyCreatesADifferentObject [
    | object objectCopy result |
    object := Object new.
    objectCopy := object copy.

    self expect: false toEqual: (object = objectCopy).
    self expect: true toEqual: (object hash ~= objectCopy hash).
  ]
]
