Class {
	#name : #BaselineOfGitExplore,
	#superclass : #BaselineOf,
	#category : #BaselineOfGitExplore
}

{ #category : #baselines }
BaselineOfGitExplore >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ "Dependencies"
			self lazygun: spec.

			"Packages"
			spec package: 'GitExplore' with: [ spec requires: #('Lazygun') ] ]
]

{ #category : #dependencies }
BaselineOfGitExplore >> lazygun: spec [ 
	spec
		baseline: 'Lazygun' with: [ spec repository: 'github://EwanDawson/pharo-lazygun/src' ]
]

{ #category : #accessing }
BaselineOfGitExplore >> projectClass [ 
	^ MetacelloCypressBaselineProject 
]
