Extension { #name : #LGitRepository }

{ #category : #'*GitExplore' }
LGitRepository >> id [
	^ self repositoryReference absolutePath fullName asSymbol
]
