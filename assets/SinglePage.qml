import bb.cascades 1.0

Page {

    Container {
        id: mainCont
        property int score: 0
        property int numOfRounds: 0
        property variant arrOfWords
        property int numOfWords
        onCreationCompleted: {
            mainCont.getAllWords();
            mainCont.getNewWord();

        }
        Container {
            layout: DockLayout {
            }

            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center

            ImageView {
                imageSource: "yellowbackground.jpg"
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                scalingMethod: ScalingMethod.AspectFill

            }
            Label {
                id: outputWordLB
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                textStyle.color: Color.create("#ffea0043")
                textStyle.fontSize: FontSize.XXLarge

            }

            Container {

                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                horizontalAlignment: HorizontalAlignment.Center

                verticalAlignment: VerticalAlignment.Top
                Label {

                    text: "Score is:"
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

        function updateScore(value) {
            mainCont.score += value;
            mainCont.numOfRounds ++;
            scoreLB.text = mainCont.score + "/" + mainCont.numOfRounds;

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

    }
    actions: [
        ActionItem {
            id: upScoreAction
            title: "Correct"
            imageSource: "images/icon_up.png"
            onTriggered: {
                mainCont.updateScore(1);
                mainCont.getNewWord();
            }
            ActionBar.placement: ActionBarPlacement.OnBar
        },
        ActionItem {
            id: downScoreAction
            title: "Incorrect"
            imageSource: "images/icon_down.png"
            onTriggered: {
                mainCont.updateScore(0);
                mainCont.getNewWord();
            }
            ActionBar.placement: ActionBarPlacement.OnBar
        },
        // General SHARE Framework call
        // Will display all the SHARE Targets available

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

    onCreationCompleted: {
        Application.thumbnail.connect(onThumbnailed);
        Application.fullscreen.connect(onFullScreen);

    }

    function onThumbnailed() {
        // Perform an action once the app is thumbnailed
        console.log("active framed");
        activeFrame.updateSingle(scoreLB.text);
    }

    function onFullScreen() {
        // Perform an action once the app is fullscreen
        console.log("full screen");

    }

}
