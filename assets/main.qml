import bb.cascades 1.0

NavigationPane {
    id: navigationPane
    
    attachedObjects: [
        ComponentDefinition {
            id: singlePageDefinition
            source: "SinglePage.qml"
        },     ComponentDefinition {
            id: singleTimePageDefinition
            source: "SinglePageTimer.qml"
        },
        
        ComponentDefinition {
            id: helpPageDefinition
            source: "HelpPage.qml"
        }
        ,  ComponentDefinition {

            id: infoPageDefinition
            source: "InfoPage.qml"
        }
    
    ] 
    
    Menu.definition: MenuDefinition {
        id: menuDef
        // Add a Help action
        helpAction: HelpActionItem {
            onTriggered: {
                var helpPage = helpPageDefinition.createObject();
                navigationPane.push(helpPage);
            }
        
        }
        
        
        // Add a Settings action
        //   settingsAction: SettingsActionItem {   }
        
        // Add any remaining actions
        actions: [
            
            ActionItem {
                id: actionInfo
                title: "Info"
                imageSource: "asset:///images/ic_info.png"
                onTriggered: {
                    var infoPage = infoPageDefinition.createObject();
                    navigationPane.push(infoPage);                }
            },
            ActionItem {
                id: actionDownload
                title: "Invite"
                imageSource: "asset:///images/ic_download.png"
                onTriggered: {
                    _app.inviteUserToDownloadViaBBM()
                }
            },
            ActionItem {
                id: actionEmailUs
                title: "Contact Us"
                imageSource: "asset:///images/ic_email.png"
                
                attachedObjects: [
                    Invocation {
                        id: invoke
                        query {
                            //id: invokeQuery
                            uri: "mailto:waynelahinds@yahoo.ca?subject=Party Charades Feedback/Support"
                            invokeActionId: "bb.action.SENDEMAIL"
                            invokeTargetId: "sys.pim.uib.email.hybridcomposer"
                        }
                    }
                ]
                onTriggered: {
                    invoke.trigger("bb.action.SENDEMAIL");
                }
            }
        
        ]
    }
    
    Page {
        titleBar: TitleBar {
            // Localized text with the dynamic translation and locale updates support
            title: qsTr("Party Charades") + Retranslate.onLocaleOrLanguageChanged
        }
        Container {
            layout: DockLayout {
                
            }
            Container {
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
            
            ImageView {
                imageSource: "asset:///images/background.png"
                opacity: 0.3
            }
        }
            
            Container {
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
     
                Label {
                    text: "To chose you can start a game that keeps track of time of not.<br>It will display words to act out.</br><br>Press thumbs up or down if you got it right or wrong. It will record your score and the number of rounds you have completed.</br><br>Enter the seconds per round when starting the timed game. </br><br>Enjoy and Have Fun</br>"
                    multiline: true     
                    textFormat: TextFormat.Html
                    textStyle.textAlign: TextAlign.Center
                    textStyle.fontWeight: FontWeight.W900
                    textStyle.color: Color.create("#ff004c84")
                }
            
            }}
        
        actions: [
            ActionItem {
                title: qsTr("Round Robin") + Retranslate.onLocaleOrLanguageChanged
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "images/icon_single.png"
                
                onTriggered: {
                    // A second Page is created and pushed when this action is triggered.
                    navigationPane.push(singlePageDefinition.createObject());
                }
            },
            ActionItem {
                title: qsTr("Timed Round") + Retranslate.onLocaleOrLanguageChanged
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "images/icon_timer.png"
                
                onTriggered: {
                    // A second Page is created and pushed when this action is triggered.
                    navigationPane.push(singleTimePageDefinition.createObject());
                }
            }
        
        ]
    }
    
    onPopTransitionEnded: {
        // Destroy the popped Page once the back transition has ended.
        page.destroy();
    }
    
    onCreationCompleted: {
        Application.thumbnail.connect(onThumbnailed);
        Application.fullscreen.connect(onFullScreen);
    
    }
    
    function onThumbnailed() {
        // Perform an action once the app is thumbnailed
        console.log("active framed");
        activeFrame.update();
    }
    
    function onFullScreen() {
        // Perform an action once the app is fullscreen
        console.log("full screen");
    
    }
}
