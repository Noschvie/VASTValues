'From VisualWorks®, 8.3 of 28. Juli 2017 on 28. Februar 2022 at 19:05:30'!

"Created 28. Februar 2022 um 19:05:30 by VA Smalltalk Transform(1.4.0.1,chaider)"
Application create: #ValuesTestingApp with: 
    (#( ValuesApp SUnit EsParsing )
        collect: [:each | Smalltalk at: each ifAbsent: [
            Application errorPrerequisite: #ValuesTestingApp missing: each]])!

ValuesTestingApp becomeDefault!
	Application subclass: #ValuesTestingApp
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!


ValuesTestingApp becomeDefault!
!ValuesTestingApp class privateMethods !
abtIsViewApplication

	^false! !
!ValuesTestingApp publicMethods!

developmentPrerequisites
	^#(#(#any 'SUnitToo' ''))!

notice
	^''!

packageName
	^'Values Testing'!

prerequisiteDescriptions
	^#(#(#name 'SUnitToo' #componentType #package))!

prerequisiteParcels
	^#(#('SUnitToo' ''))!

storeVersion
	^'3.0.0.0'!

 !TestCase
	subclass: #ValuemapTests
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

ValuemapTests comment:
'Tests for the behavior of OrderedDictionary as Dictionary and as Value'!

TestCase
	subclass: #ValuePrinterTests
	classInstanceVariableNames: ''
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''!

ValuePrinterTests comment:
'Tests for the source strings of Values'!

Value
	subclass: #Testvalue
	classInstanceVariableNames: ''
	instanceVariableNames: 'constant optional array dictionary'
	classVariableNames: ''
	poolDictionaries: ''!

Testvalue comment:
'Testvalue is a resource class for testing values'!

!Testvalue class publicMethods!

constant: constantSymbol optional: optionalSymbol array: arrayArray dictionary: dictionaryDictionary
	| inst |
	inst := self new.
	inst
		initializeConstant: constantSymbol
		optional: optionalSymbol
		array: arrayArray
		dictionary: dictionaryDictionary.
	^inst! !

!Testvalue class publicMethods!

constant: constantSymbol
	| inst |
	inst := self new.
	inst initializeConstant: constantSymbol optional: nil array: nil dictionary: nil.
	^inst!

constant: constantSymbol array: arrayArray
	| inst |
	inst := self new.
	inst initializeConstant: constantSymbol optional: nil array: arrayArray dictionary: nil.
	^inst!

constant: constantSymbol array: arrayArray dictionary: dictionaryDictionary
	| inst |
	inst := self new.
	inst
		initializeConstant: constantSymbol
		optional: nil
		array: arrayArray
		dictionary: dictionaryDictionary.
	^inst!

constant: constantSymbol dictionary: dictionaryDictionary
	| inst |
	inst := self new.
	inst
		initializeConstant: constantSymbol
		optional: nil
		array: nil
		dictionary: dictionaryDictionary.
	^inst!

constant: constantSymbol optional: optionalSymbol
	| inst |
	inst := self new.
	inst initializeConstant: constantSymbol optional: optionalSymbol array: nil dictionary: nil.
	^inst!

constant: constantSymbol optional: optionalSymbol array: arrayArray
	| inst |
	inst := self new.
	inst
		initializeConstant: constantSymbol
		optional: optionalSymbol
		array: arrayArray
		dictionary: nil.
	^inst!

constant: constantSymbol optional: optionalSymbol dictionary: dictionaryDictionary
	| inst |
	inst := self new.
	inst
		initializeConstant: constantSymbol
		optional: optionalSymbol
		array: nil
		dictionary: dictionaryDictionary.
	^inst! !

!Testvalue class publicMethods!

localSpecification
	<constant: #constant class: #(#Symbol)>
	<optional: #optional class: #(#Symbol) default: '#none'>
	<sequence: #array>
	<map: #dictionary>! !

!Testvalue class publicMethods!

example
	^Testvalue
		constant: #constantSymbol
		optional: #optionalSymbol
		array: #(1 #a $x 'name')
		dictionary: (Valuemap
			with: 1 -> #symbol
			with: #key -> 'string')! !

!Testvalue publicMethods!

array
	"<Array>"

	^array ifNil: [#()]!

constant
	"<Symbol>"

	^constant!

dictionary
	"<Dictionary>"

	^dictionary ifNil: [Dictionary new beImmutable]!

optional
	"<Symbol>"

	^optional ifNil: [#none]! !

!Testvalue publicMethods!

initializeConstant: constantSymbol optional: optionalSymbol array: arrayArray dictionary: dictionaryDictionary
	constant := constantSymbol.
	(optionalSymbol notNil and: [
	self optional ~= optionalSymbol]) ifTrue: [
			optional := optionalSymbol].
	(arrayArray notNil and: [
	arrayArray notEmpty]) ifTrue: [
			array := (Array withAll: arrayArray) beImmutable].
	(dictionaryDictionary notNil and: [
	dictionaryDictionary notEmpty]) ifTrue: [
			dictionary := (Valuemap withAll: dictionaryDictionary) beImmutable].
	self beImmutable! !

!Testvalue publicMethods!

passInstVars
	"for OpenTalk StSt"

	^#(#default #default #default #value)! !

!Testvalue publicMethods!

printvalueWith: printer
	| args |
	args := OrderedCollection new.
	args add: (printer constant: 'constant' value: self constant).
	args add: (printer optional: 'optional' value: optional).
	args add: (printer array: 'array' value: self array).
	args add: (printer dictionary: 'dictionary' value: self dictionary).
	^printer printvalue: self arguments: args! !

!ValuemapTests publicMethods!

testAdding
	| od od1 |
	od := Valuemap new.
	self assert: od isEmpty.
	od add: #foo -> 'bar'.
	self assert: od size = 1.
	self assert: (od atIndex: 1) = (#foo -> 'bar').
	self assert: (od at: #foo) = 'bar'.
	od at: #baz put: 'xxx'.
	self assert: od size = 2.
	self assert: (od atIndex: 2) = (#baz -> 'xxx').
	self assert: (od at: #baz) = 'xxx'.
	od1 := Valuemap new.
	od1 add: #foo -> 'baz'.
	od1 at: #baz put: 'yyy'.
	od addAll: od1.
	self assert: od size = 2.
	self assert: (od at: #foo) = 'baz'.
	self assert: (od at: #baz) = 'yyy'.!

testAddingWithGrowth
	"add iteratively elements, so that the dictionary must grow"

	| letters od od1 |
	letters := #(#a #b #c #d #e #f #g #h #i #j #k #l #m #n #o #p #q #r #s #t #u #v #w #x #y #z).
	od := Valuemap new.
	self shouldnt: [letters do: [:symbol | od add: symbol -> symbol asString]] raise: Error.
	self assert: od keys asArray = #(#a #b #c #d #e #f #g #h #i #j #k #l #m #n #o #p #q #r #s #t #u #v #w #x #y #z).
	od1 := Valuemap new.
	self shouldnt: [letters do: [:symbol | od1 at: symbol put: symbol asString]] raise: Error.
	self assert: od1 keys asArray = #(#a #b #c #d #e #f #g #h #i #j #k #l #m #n #o #p #q #r #s #t #u #v #w #x #y #z).!

testComparing
	self assert: (Valuemap with: #foo -> 'bar') = (Valuemap with: #foo -> 'bar').
	self deny: (Valuemap with: #foo -> 'bar') == (Valuemap with: #foo -> 'bar').
	self deny: (Valuemap with: #foo -> 'bar') = (Dictionary with: #foo -> 'bar').
	self deny: (Dictionary with: #foo -> 'bar') = (Valuemap with: #foo -> 'bar').
	self assert: (Valuemap with: #foo -> 'bar' with: $a -> 123) = (Valuemap with: #foo -> 'bar' with: $a -> 123).
	self deny: (Valuemap with: #foo -> 'bar' with: $a -> 123) = (Valuemap with: $a -> 123 with: #foo -> 'bar' ).
	self deny: (Valuemap with: #foo -> 'bar' with: $a -> 123) = (Valuemap with: #foo -> 123 with: $a -> 'bar' ).
	self deny: (Valuemap with: #foo -> 'bar' with: $a -> 123) = (Valuemap with: #foo -> 'bar' with: $a -> 1234).
	self deny: (Valuemap with: #foo -> 'bar' with: $a -> 123) = (Valuemap with: #foo -> 'bars' with: $a -> 123).
	self deny: (Valuemap with: #foo -> 'bar' with: $a -> 123) = (Valuemap with: #foo -> 'bar' with: $a -> 123 with: '' -> 0).!

testDescribe
	self assert: Valuemap example asSource = 
'((Valuemap new: 8)
	add: #isinTitle -> ''ISIN'';
	add: #isinValue -> ''DE0009999991'';
	add: #börsenwertTitle -> ''Börsenwert'';
	add: #börsenwertValue -> ''99,9 Mrd. €'';
	add: #hochTiefTitle -> ''Hoch/Tief'';
	add: #hochTiefValue -> ''10,00/20,00'';
	add: #kgvTitle -> ''KGV'';
	add: #kgvValue -> ''9,87'';
	yourself)'!

testDescribeAndReadBackNew
	| inst |
	inst := Valuemap new.
	self assert: inst asDescription = (Compiler evaluate: inst asSource) asDescription!

testEnumeration
	| od keys |
	od := Valuemap new.
	od add: #foo -> 'bar'.
	od at: #baz put: 'xxx'.
	od associationsDo: [:assoc |
		self assert: (assoc isKindOf: Association).
		self assert: assoc key isSymbol.
		self assert: assoc value isString].
	self assert: od keys asArray = #(#foo #baz).
	self assert: od values asArray = #('bar' 'xxx').
	keys := OrderedCollection new.
	od keysDo: [:k | keys add: k].
	self assert: keys asArray = #(#foo #baz).!

testIndexedAccess
	| od |
	od := Valuemap new.
	od add: #foo -> 'bar'.
	self assert: od size = 1.
	self assert: (od atIndex: 1) = (#foo -> 'bar').
	self should: [od atIndex: 0] raise: ExCLDTIndexOutOfRange.
	self should: [od atIndex: 2] raise: ExCLDTIndexOutOfRange.
	self should: [od atIndex: #key] raise: ExCLDTInvalidArgument.
	self should: [od atIndex: '1'] raise: ExCLDTInvalidArgument.!

testIndexOf
	| od |
	od := Valuemap new.
	self assert: od isEmpty.
	self assert: (od indexOf: #foo) isZero.
	od add: #foo -> 'bar'.
	self assert: od size = 1.
	self assert: (od indexOf: #foo) = 1.
	self assert: (od indexOf: #baz) isZero.
	od at: #baz put: 'xxx'.
	self assert: od size = 2.
	self assert: (od indexOf: #baz) = 2.!

testKeyedAccess
	| od |
	od := Valuemap new.
	od add: #foo -> 'bar'.
	od at: #baz put: 'xxx'.
	self assert: od size = 2.
	self assert: (od at: #foo) = 'bar'.
	self assert: (od at: #baz) = 'xxx'.
	self should: [od at: #bar] raise: ExCLDTKeyNotFound.
	self assert: (od at: #bar ifAbsent: [nil]) isNil.!

testReadBackAllTestInstances
	(Valuemap class organization listAtCategoryNamed: (Valuemap class whichCategoryIncludesSelector: #example)) do: [:sel |
		| inst readInst |
		inst := Valuemap perform: sel.
		self shouldnt: [readInst := Compiler evaluate: inst asSource] raise: Error.
		self assert: inst asSource = readInst asSource]!

testRemoving
	| od |
	od := Valuemap new.
	self assert: od isEmpty.
	self should: [od removeKey: #foo] raise: ExCLDTKeyNotFound.
	self shouldnt: [od removeKey: #foo ifAbsent: nil] raise: ExCLDTKeyNotFound.
	self assert: (od removeKey: #foo ifAbsent: nil) isNil.
	od add: #foo -> 'bar'.
	self assert: od size = 1.
	self assert: od keys asArray = #(#foo).
	self assert: (od removeKey: #foo) = 'bar'.
	self assert: od size = 0.
	self assert: od keys asArray = #().
	od add: #foo -> 'bar'.
	od at: #baz put: 'xxx'.
	self assert: od size = 2.
	self assert: od keys asArray = #(#foo #baz).
	self should: [od removeKey: #zzz] raise: ExCLDTKeyNotFound.
	self shouldnt: [od removeKey: #zzz ifAbsent: nil] raise: ExCLDTKeyNotFound.
	self assert: od size = 2.
	self assert: od keys asArray = #(#foo #baz).
	self assert: (od removeKey: #foo) = 'bar'.
	self assert: od size = 1.
	self assert: od keys asArray = #(#baz)! !

!ValuePrinterTests publicMethods!

testArray
	self assert: Array new asSource = '#()'.
	self assert: #(1 2 3 4) asSource = '#(1 2 3 4)'.
	self assert: #(1 2 3 4 5 6 7 8 9 10) asSource = '#(1 2 3 4 5 6 7 8 9 10)'.
	self assert: (Array with: 1 with: 2 with: 3 with: 4) asSource = '#(1 2 3 4)'.
	self assert: (Array with: 1 with: (Date d: 7 m: 7 y: 2007) with: ColorValue red) asSource = '(Array
	with: 1
	with: (Date d: 7 m: 7 y: 2007)
	with: ColorValue red)'.
	self assert: (#(1 2 3 4) , (Array with: (Date d: 7 m: 7 y: 2007))) asSource = '((OrderedCollection new: 5)
	add: 1;
	add: 2;
	add: 3;
	add: 4;
	add: (Date d: 7 m: 7 y: 2007);
	yourself)'.
	self assert: (Array with: Testvalue example with: (Date d: 7 m: 7 y: 2007) with: ColorValue red) asSource = '(Array
	with: (Testvalue
		constant: #constantSymbol
		optional: #optionalSymbol
		array: #(1 #a $x ''name'')
		dictionary: (Valuemap
			with: 1 -> #symbol
			with: #key -> ''string''))
	with: (Date d: 7 m: 7 y: 2007)
	with: ColorValue red)'.!

testArraySource
	self assert: (Testvalue
		constant: #constantSymbol
		optional: #optionalSymbol
		array: #(1 #a $x 'name')
		dictionary: (Dictionary
			with: 1 -> #symbol
			with: #key -> 'string')) asSource = '(Testvalue
	constant: #constantSymbol
	optional: #optionalSymbol
	array: #(1 #a $x ''name'')
	dictionary: (Valuemap
		with: 1 -> #symbol
		with: #key -> ''string''))'.!

testColorValue
	self assert: ColorValue red asSource = 'ColorValue red'.
	self assert: (ColorValue fromBytesRed: 255 green: 0 blue: 0) asSource = 'ColorValue red'.
	self assert: (ColorValue fromBytesRed: 255 green: 0 blue: 10) asSource = '(ColorValue fromBytesRed: 255 green: 0 blue: 10)'!

testDate
	self assert: (Date d: 7 m: 7 y: 2007) asSource = '(Date d: 7 m: 7 y: 2007)'!

testDictionary
	| dict |
	self assert: Valuemap new asSource = 'Valuemap new'.
	dict := Valuemap
		with: 1 -> 75
		with: #b -> $x.
	self assert: dict asSource = '(Valuemap
	with: 1 -> 75
	with: #b -> $x)'!

testDictionarySource
	self assert: (Testvalue
		constant: #constantSymbol
		optional: #optionalSymbol
		array: #(1 #a $x 'name')
		dictionary: (Dictionary
			with: 1 -> #symbol
			with: #key -> 'string')) asSource = '(Testvalue
	constant: #constantSymbol
	optional: #optionalSymbol
	array: #(1 #a $x ''name'')
	dictionary: (Valuemap
		with: 1 -> #symbol
		with: #key -> ''string''))'.
	self assert: (Testvalue constant: #Haider) asSource = '(Testvalue constant: #Haider)'!

testDictionaryWithValues
	| dict |
	dict := Valuemap
		with: 1 -> Testvalue example
		with: Testvalue example -> $x.
	self assert: dict asSource = '(Valuemap
	with: 1 -> (Testvalue
		constant: #constantSymbol
		optional: #optionalSymbol
		array: #(1 #a $x ''name'')
		dictionary: (Valuemap
			with: 1 -> #symbol
			with: #key -> ''string''))
	with: (Testvalue
		constant: #constantSymbol
		optional: #optionalSymbol
		array: #(1 #a $x ''name'')
		dictionary: (Valuemap
			with: 1 -> #symbol
			with: #key -> ''string'')) -> $x)'!

testLiteralArrays
	self assert: #(1 2 10 20 100) asSource = '#(1 2 10 20 100)'!

testLongDictionary
	| dict |
	dict := Valuemap new.
	dict at: 1 put: 75.
	dict at: #b put: $x.
	dict at: 42 put: 'Hello'.
	dict at: 'abc' put: 32.
	dict at: 2 put: #(#String).
	dict at: true put: #hi.
	self assert: dict asSource = '((Valuemap new: 6)
	add: 1 -> 75;
	add: #b -> $x;
	add: 42 -> ''Hello'';
	add: ''abc'' -> 32;
	add: 2 -> #(#String);
	add: true -> #hi;
	yourself)'!

testNumbers
	self assert: 42 asSource = '42'.
	self assert: 429999999939333 asSource = '429999999939333'.
	self assert: 2.5 asSource = '2.5'.
	"only VW, not Gemstone
	self assert: 2.5e7 asSource = '2.5e7'.
	self assert: 2.5e-7 asSource = '2.5e-7'.
	self assert: 2.5d137 asSource = '2.5d137'.
	self assert: 2.5d-137 asSource = '2.5d-137'.
	self assert: 25s7 asSource = '25.0000000s'.
	self assert: (2 / 5) asSource = '(2 / 5)'.
	"!

testOptionalConstantSource
	self assert: (Testvalue
		constant: #constantSymbol
		optional: #optionalSymbol
		array: #(1 #a $x 'name')
		dictionary: (Dictionary
			with: 1 -> #symbol
			with: #key -> 'string')) asSource = '(Testvalue
	constant: #constantSymbol
	optional: #optionalSymbol
	array: #(1 #a $x ''name'')
	dictionary: (Valuemap
		with: 1 -> #symbol
		with: #key -> ''string''))'.
	self assert: (Testvalue
		constant: #constantSymbol
		optional: #optionalSymbol
		array: #(1 #a $x 'name')) asSource = '(Testvalue constant: #constantSymbol optional: #optionalSymbol array: #(1 #a $x ''name''))'.
	self assert: (Testvalue constant: #constantSymbol optional: #optionalSymbol) asSource = '(Testvalue constant: #constantSymbol optional: #optionalSymbol)'.
	self assert: (Testvalue constant: #constantSymbol) asSource = '(Testvalue constant: #constantSymbol)'!

testPoint
	self assert: (1 @ 2) asSource = '1 @ 2'.
	self assert: (1 @ (Date d: 7 m: 7 y: 2007)) asSource = '1 @ (Date d: 7 m: 7 y: 2007)'!

testTime
	self assert: (Time h: 7 m: 27 s: 13) asSource = '(Time h: 7 m: 27 s: 13)'.
	self assert: (Time h: 7 m: 27 s: 0) asSource = '(Time h: 7 m: 27)'.
	self assert: (Time h: 7 m: 27) asSource = '(Time h: 7 m: 27)'.
	self assert: (Time h: 7 m: 0 s: 0) asSource = '(Time h: 7)'.
	self assert: (Time h: 7 m: 0) asSource = '(Time h: 7)'.
	self assert: (Time h: 7) asSource = '(Time h: 7)'.
	self assert: (Time h: 0) asSource = 'Time zero'.
	self assert: Time zero asSource = 'Time zero'!

testTimestamp
	self assert: (Timestamp d: 15 m: 7 y: 2007 h: 7 m: 27 s: 13) asSource = '(Timestamp d: 15 m: 7 y: 2007 h: 7 m: 27 s: 13)'.
	self assert: (Timestamp d: 15 m: 7 y: 2007 h: 7 m: 27 s: 0) asSource = '(Timestamp d: 15 m: 7 y: 2007 h: 7 m: 27)'.
	self assert: (Timestamp d: 15 m: 7 y: 2007 h: 7 m: 27) asSource = '(Timestamp d: 15 m: 7 y: 2007 h: 7 m: 27)'.
	self assert: (Timestamp d: 15 m: 7 y: 2007 h: 7 m: 0 s: 0) asSource = '(Timestamp d: 15 m: 7 y: 2007 h: 7)'.
	self assert: (Timestamp d: 15 m: 7 y: 2007 h: 7 m: 0) asSource = '(Timestamp d: 15 m: 7 y: 2007 h: 7)'.
	self assert: (Timestamp d: 15 m: 7 y: 2007 h: 7) asSource = '(Timestamp d: 15 m: 7 y: 2007 h: 7)'.
	self assert: (Timestamp d: 15 m: 7 y: 2007 h: 0) asSource = '(Timestamp d: 15 m: 7 y: 2007)'.
	self assert: (Timestamp d: 15 m: 7 y: 2007) asSource = '(Timestamp d: 15 m: 7 y: 2007)'! !

!Valuemap class publicMethods!

example
	"self example"

	| state |
	state := Valuemap new.
	state at: #isinTitle put: 'ISIN'.
	state at: #isinValue put: 'DE0009999991'.
	state at: #börsenwertTitle put: 'Börsenwert'.
	state at: #börsenwertValue put: '99,9 Mrd. €'.
	state at: #hochTiefTitle put: 'Hoch/Tief'.
	state at: #hochTiefValue put: '10,00/20,00'.
	state at: #kgvTitle put: 'KGV'.
	state at: #kgvValue put: '9,87'.
	^state! !


ValuesTestingApp initializeAfterLoad!
ValuesTestingApp loaded!