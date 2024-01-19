generate:
	tuist fetch
	tuist generate
clean:
	rm -f .package.resolved
	rm -rf **/*.xcodeproj
	rm -rf **/*.xcworkspace
	tuist clean

