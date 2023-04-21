# :D

# Pages architecture

Quick trip through `authPages`
- The first paga is `hello_page` which caintain signin/signup button and flying cat
- After clicking signin/signup button you go to Auth0 page where logging or registering is possible
- There are two ways after authentication
    - THE FIRST ONE - the user doesn't have any role:
        - `user_page`
        - `forms_page` - Adopter form or Shelter form
        - Adopter after detailing the account will be redirect to `user_manager`
        - Shelter ---- I don't know
    - THE SECOND ONE - the user have a role:
        - `user_manager`

The view of business part 
- ....

# Auth0

The app uses Auth0 for IAM. All dependencies related with it are in files: 
- `lib/services/auth_services.dart`,
- `lib/cubits/appCubit/app_cubit.dart`,
- `lib/view/authPage/*`.
