Class {
	#name : #GERepositories,
	#superclass : #Object,
	#instVars : [
		'repos'
	],
	#classInstVars : [
		'default'
	],
	#category : #GitExplore
}

{ #category : #accessing }
GERepositories class >> default [
	^ default ifNil: [ default := self new ]
]

{ #category : #adding }
GERepositories >> add: aFileReference [
	"Add the repo pointed at by the given file reference"

	| file |
	file := aFileReference resolve.
	file isGitRepo
		ifTrue:
			[ repos at: file pathString put: (LGitRepository on: file) init ]
		ifFalse: [ self error: 'Not a git repo: ' , file printString ]
]

{ #category : #adding }
GERepositories >> addAll: aFileReference [
	"Recursively add all git repos found under the given directory"

	aFileReference resolve findGitRepos do: [ :repo | self add: repo ]
]

{ #category : #initialization }
GERepositories >> initialize [
	repos := Dictionary new
]
