# FindEmAll

<img width="1232" alt="Screenshot 2024-05-03 at 00 28 39" src="./imageAsset/Screenshot 2024-04-29 at 20.24.09.png"><br/>
A simple but interactive game using a popular API.<br/>
Point in creating the game was to become more familiar with API calls and how to handle data.
Morever, was backed by my love for the original game.

More features will be added for learning purposes as well as personal interest.
<br/><br/>


# TroubleShooting 🥊
## Development
### 🚧 ISSUE
> **unable to update display when collectionview is tapped**

**🔎 APPROACH**

- Initially, manually set cell's layout by giving height of collectionviewCell. Afterwards, using 'performBatchUpdate', updated the cell's UI as a whole according to each cell's indexPath.
    - [🗒️ Trials in creating UICollectionview Dynamic](https://velog.io/@jacks222/PerformBatch%EB%A1%9C-%EC%85%80%EC%9D%84-%EB%8B%A4%EC%9D%B4%EB%82%98%EB%AF%B9%ED%95%98%EA%B2%8C-%EB%A7%8C%EB%93%A4%EB%8B%A4)

### 🚧 ISSUE

> **Timer Effect using UIBezierPath displayed only in certain imageViews**

**🔎 APPROACH**

- Found out UIBezierPath and UIImageView creation timing were equal. This prevented the 2nd UIBezierPath layer from showing as ImageView was created AND loaded with only single UIBezierPath. In order to make the timing different, instantiated the Timer through layoutSubview()
    - [🗒️ Trials in creating UIBezierPath Layer](https://github.com/Madman-dev/BackLog/blob/main/Locker/UIBezierPath.md)
<br><br>
## Incorporating Jira
DATE | DESCRIPTION |
|:---:|---|
4.07 | - **Testing Jira Software Integration with Github** <br/> *Learned the basics of what a ticket is, how to integrate Jira with github - creating branches, commits using Jira.* |
4.11 | - **Found issue how current Jira Ticket is used** <br/> *Issued a ticket to every bugs, story, etc - although the ticket allowed me to track down the issue faster, I wasn't able to findout the main problem of the issue until I've read the commit message. NOT an effective use of tickets* |
4.15 | Tapped cell is able to grow, but when the screen moves away from origin, the cell is unable to maintain its expanded status - providing the item's frame origin value has created a limit to how the collectionviewcell could be utilized. Looking for an alternative. |




## Others
<details closed>
<summary>View details</summary>


DATE | DESCRIPTION | FIX |
|:---:|---|---|
04.11 | - **Simulator Keyboard issue** <br/> Error Message is keep popping up when using simulator keyboard.   | Turn off Hardware Keyboard within Simulator
<br/>
<details closed>
<summary>View Keyboard Error Message</summary>

*[HardwareKeyboard] -[UIApplication getKeyboardDevicePropertiesForSenderID:shouldUpdate:usingSyntheticEvent:], failed to fetch device property for senderID (778835616971358211) use primary keyboard info instead.*
</details>
