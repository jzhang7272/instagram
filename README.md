# Project 4 - Instagram v2.0

Instagram v2.0 is a photo sharing app using Parse as its backend.

Time spent: ~15 hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign up to create a new account using Parse authentication
- [x] User can log in and log out of his or her account
- [x] The current signed in user is persisted across app restarts
- [x] User can take a photo, add a caption, and post it to "Instagram"
- [x] User can view the last 20 posts submitted to "Instagram"
- [x] User can pull to refresh the last 20 posts submitted to "Instagram"
- [x] User can tap a post to view post details, including timestamp and caption.

The following **optional** features are implemented:

- [ ] Run your app on your phone and use the camera to take the photo
- [ ] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling.
- [ ] Show the username and creation time for each post
- [x] User can use a Tab Bar to switch between a Home Feed tab (all posts) and a Profile tab (only posts published by the current user)
- User Profiles:
  - [x] Allow the logged in user to add a profile photo
  - [ ] Display the profile photo with each post
  - [ ] Tapping on a post's username or profile photo goes to that user's profile page
- [ ] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse
- [ ] User can comment on a post and see all comments for each post in the post details screen.
- [x] User can like a post and see number of likes for each post in the post details screen.
- [x] Style the login page to look like the real Instagram login page.
- [ ] Style the feed to look like the real Instagram feed.
- [ ] Implement a custom camera view.

The following **additional** features are implemented:

- [X] Allow user to customize their profile with a bio

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. UI Design choices for the feed and profile

## Video Walkthrough

Here's a walkthrough of implemented user stories:

Log In Screen:

<img src='https://i.imgur.com/gDE2edu.gif' title='Log In Screen' width=''/>

Composing a Post:

<img src='https://i.imgur.com/4mkhIfI.gif' title='Posting' width=''/>

Interacting With a Post:

<img src='https://i.imgur.com/yqdIKi2.gif' title='Interacting with Post' width=''/>

Profile

<img src='https://i.imgur.com/sngfOo3.gif' title='Interacting with Post' width=''/>

GIF created with [Kap](EZGif).

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [Parse]


## Notes

There were small syntactical issues I had to work through in implementing the Parse server, such as subclass types and using specific functions that work for the general case but not for Parse.

I had a lot of trouble with dynamically sizing the header for my collection view in my profile tab. Unfortunately, the functions that I found were in Swift or were deprecated, and I was not able to solve the issue even with TA assistance. 

## License

    Copyright [yyyy] [name of copyright owner]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
