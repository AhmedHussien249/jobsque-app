# Intro Feature

This feature handles the initial user experience:
- Splash screen with logo and animated circles
- Onboarding flow with multiple pages
- SharedPreferences to persist onboarding state

## Folders
- `presentation/`: UI for splash and onboarding
- `data/local/`: SharedPreferences wrapper (IntroLocalDataSource)

## Logic
- User sees onboarding only once
- Onboarding state is checked in SplashScreen

## Dependencies
- `shared_preferences`
- `smooth_page_indicator`
