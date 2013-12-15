import bb.cascades 1.0

Container {
    layout: DockLayout {
    }
    maxHeight: 360.0
    maxWidth: 300.0
    minHeight: 360.0
    minWidth: 300.0
    preferredHeight: 360.0
    preferredWidth: 300.0
    
    
    Container {
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center        

    ImageView {
        opacity: 0.1
            imageSource: "asset:///images/theater_masks.png"
        }
}
    Container {
        horizontalAlignment: HorizontalAlignment.Center
        verticalAlignment: VerticalAlignment.Center           
        Container {
            
            Label {
                objectName: "gamePaused"
                text: "Play Party Charades"
                multiline: true
                textStyle.fontFamily: "Slate Pro"
                textStyle.fontWeight: FontWeight.Bold
                textStyle.color: Color.create("#ff004c84")
                textStyle.textAlign: TextAlign.Center
            }
        }
        Container {       
            
            Label {
                objectName: "yourScore"
                text: "Start a Game!"
                multiline: true
                textStyle.color: Color.create("#ffea0043")
                textStyle.textAlign: TextAlign.Center
                textStyle.fontWeight: FontWeight.W500
            }
        }
        
    }
}

