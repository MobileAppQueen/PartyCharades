import bb.cascades 1.0
import bb.system 1.0
import CustomTimer 1.0

Page {
    id: mainPage
    property int defaultRoundNum: 120
    property bool gameStarted: false
    property bool gameEnded: false
    property variant arrOfWords
    property int numOfWords

    Container {
        id: mainCont
        property int score: 0
        property int numOfRounds: 0
        property int currentCount
        property int userDefault

        onCreationCompleted: {
            secsPerRoundPrompt.show();
            mainCont.getAllWords();
        }

        Timer {
            id: mainTimer

            // Specify a timeout interval of 1 second
            interval: 1000
            onTimeout: {
                // Decrement the counter and update the countdown text
                mainCont.currentCount -= 1;
                timerCountdownTA.text = "" + mainCont.currentCount;

                // When the counter reaches 0, change the traffic light
                // state, stop the countdown timer, and start the pause
                // timer
                if (mainCont.currentCount == 0) {
                    mainCont.endGame();
                }
            } // end of onTimeout signal handler
            onActiveChanged: {
            }
        } // end of Timer

        Container {
            layout: DockLayout {
            }

            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center

            ImageView {
                id: backgroundImg
                imageSource: "bluebackground.png"
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center

            }

            Button {
                id: startGameButton
                text: "Start"
                onClicked: {
                    console.log("button pressed");
                    mainCont.startGame();

                }
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
            }
            Label {
                id: outputWordLB
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                textStyle.color: Color.create("#ff004c84")
                textStyle.fontSize: FontSize.XXLarge
                textStyle.fontSizeValue: 2.0

            }

            Container {

                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                horizontalAlignment: HorizontalAlignment.Center

                verticalAlignment: VerticalAlignment.Top
                Label {
                    id: scoreIntrolLB
                    text: "Your score is"
                    textStyle.color: Color.Black
                    textStyle.fontSize: FontSize.XLarge
                }
                Label {
                    id: scoreLB
                    text: "0"
                    textStyle.color: Color.Black
                    textStyle.fontSize: FontSize.XLarge
                }
            }

        }
        Container {
            layout: DockLayout {

            }
            Label {
                id: timeIntroLB
                text: "Time Remaining                  "
                textStyle.fontSize: FontSize.Large
                horizontalAlignment: HorizontalAlignment.Right
            }
            Label {
                id: timerCountdownTA
                text: "Count"
                textStyle.fontSize: FontSize.Large
                horizontalAlignment: HorizontalAlignment.Right
                verticalAlignment: VerticalAlignment.Center
            }
        }

        function getAllWords() {
            var input = _app.readWords();
            console.log("input recived");
            //  mainCont.getNewWord();
            arrOfWords = input.split(",", 100);
            numOfWords = arrOfWords.length;
        }

        function getNewWord() {
            var ranNum = (Math.floor(Math.random() * (numOfWords - 1)));
            var OutText = arrOfWords[ranNum];
            console.log("random " + ranNum + " for word " + OutText);
            outputWordLB.text = OutText;

        }
        function updateScore(value) {
            mainCont.score += value;
            mainCont.numOfRounds ++;
            scoreLB.text = mainCont.score + "/" + mainCont.numOfRounds;

        }

        function startGame() {
            //reset values
            timerCountdownTA.text = mainCont.userDefault;
            mainCont.currentCount = mainCont.userDefault;
            mainCont.score = 0;
            mainCont.numOfRounds = 0;
            scoreLB.text = mainCont.score;
            gameEnded = false;

            mainCont.getNewWord();
            mainTimer.start();
            upScoreAction.enabled = true;
            downScoreAction.enabled = true;
            startGameButton.visible = false;
            gameStarted = true;

        }
        function endGame() {
            timerCountdownTA.text = "Done"
            gameEnded = true;
            gameStarted = false;
            mainTimer.stop();
            endGameDialog.show();
            upScoreAction.enabled = false;
            downScoreAction.enabled = false;
            startGameButton.visible = true;
            outputWordLB.text = ""

        }
    }
    actions: [
        ActionItem {
            id: upScoreAction
            title: "Correct"
            imageSource: "images/icon_up.png"
            enabled: false
            onTriggered: {
                mainCont.updateScore(1);
                mainCont.getNewWord();
            }
            ActionBar.placement: ActionBarPlacement.OnBar
        },
        ActionItem {
            id: downScoreAction
            title: "Incorrect"
            enabled: false
            imageSource: "images/icon_down.png"
            onTriggered: {
                mainCont.updateScore(0);
                mainCont.getNewWord();
            }
            ActionBar.placement: ActionBarPlacement.OnBar
        },
        ActionItem {
            id: actionBBMShare
            title: "Personal Msg"

            imageSource: "asset:///images/ic_bbm.png"
            onTriggered: {
                var data = "Play Party Charades. I just played scoring " + scoreLB.text + ". Challenge your friends to see who is better!";
                _app.updatePersonalMessage(data);
            }
            ActionBar.placement: ActionBarPlacement.InOverflow
        },
        InvokeActionItem {
            id: actionItemShare
            ActionBar.placement: ActionBarPlacement.InOverflow
            query {
                mimeType: "text/plain"
                invokeActionId: "bb.action.SHARE"
            }
            onTriggered: {
                data = "Play Party Charades. Challenge your friends to see who is better! ";
                console.log("to share" + data);
            }
        }
    ]

    attachedObjects: [
        SystemPrompt {
            id: secsPerRoundPrompt
            title: qsTr("Enter the seconds per round")
            modality: SystemUiModality.Application
            inputField.inputMode: SystemUiInputMode.NumericKeypad
            inputField.emptyText: defaultRoundNum
            inputField.defaultText: defaultRoundNum
            confirmButton.label: qsTr("Ok")
            confirmButton.enabled: true
            cancelButton.enabled: false
            onFinished: {
                if (result == SystemUiResult.ConfirmButtonSelection) {
                    //get user input if not a number set it to default
                    var userInput = inputFieldTextEntry();
                    var roundLengthInt = parseInt(userInput) || defaultRoundNum;
                    timerCountdownTA.text = roundLengthInt;
                    mainCont.currentCount = roundLengthInt;
                    mainCont.userDefault = roundLengthInt;
                } else if (result == SystemUiResult.CancelButtonSelection) {

                }
            }

        },
        SystemDialog {
            id: endGameDialog
            title: "Round Completed"
            body: "You completed the round with " + scoreLB.text
            cancelButton.enabled: false
            onFinished: {
                if (endGameDialog.result == SystemUiResult.CancelButtonSelection) {
                    console.log("cancel button");
                } else if (endGameDialog.result == SystemUiResult.ConfirmButtonSelection) {
                    console.log("confirm button");

                }
            }
        }

    ]

    onCreationCompleted: {
        Application.thumbnail.connect(onThumbnailed);
        Application.fullscreen.connect(onFullScreen);

    }

    function onThumbnailed() {
        // Perform an action once the app is thumbnailed
        console.log("active framed");
        console.log("game started:" + gameStarted);
        console.log("game ended:" + gameEnded);
        console.log("score:" + scoreLB.text);
        console.log("time:" + timerCountdownTA.text);
        mainTimer.stop();
        console.log("start update");

        activeFrame.updateSingleTimer(gameStarted, gameEnded, scoreLB.text, timerCountdownTA.text);
    }

    function onFullScreen() {
        // Perform an action once the app is fullscreen
        console.log("full screen");
        console.log(gameStarted);
        if (gameStarted == true && gameEnded == false) {
            mainTimer.start();
        }
    }
}
