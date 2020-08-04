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
			[ repos at: file pathString asSymbol put: (LGitRepository on: file) ]
		ifFalse: [ self error: 'Not a git repo: ' , file printString ]
]

{ #category : #adding }
GERepositories >> addAll: aFileReference [
	"Recursively add all git repos found under the given directory"

	aFileReference resolve findGitRepos do: [ :repo | self add: repo ]
]

{ #category : #accessing }
GERepositories >> allRemotes [
	"Answer with a Set of all remotes found in my repositories"

	^ Set
		newFrom:
			(repos values
				flatCollect: [ :repo | repo allRemotes collect: [ :remote | remote url ] ])
]

{ #category : #enumerating }
GERepositories >> do: aBlock [
	"Evaluate the given block, passing in each of my repositories"
	
  ^ repos values do: aBlock
]

{ #category : #initialization }
GERepositories >> initialize [
	self reset
]

{ #category : #accessing }
GERepositories >> paths [
	"Anwser a collection of symbols representing the paths of all repositories I contain"
	
	^ OrderedCollection newFrom: repos keys
]

{ #category : #accessing }
GERepositories >> repo: aRepositoryPath [
	"Answer with the Git repository at the given path, or nil if no such repository
	is known to me"
	
  ^ repos at: aRepositoryPath asSymbol 
]

{ #category : #accessing }
GERepositories >> repos [
	"Anwser a collection of repositories I contain"
	
	^ OrderedCollection newFrom: repos values
]

{ #category : #accessing }
GERepositories >> reset [
	"Reset this instance, clearing it of all repos"

	repos := IdentityDictionary new
]
