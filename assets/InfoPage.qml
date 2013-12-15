import bb.cascades 1.0
Page {
    id: mainInfoPage
    ScrollView {

        Container {
            //        Label {
            //            text: qsTr("Help") + Retranslate.onLocaleOrLanguageChanged
            //            horizontalAlignment: HorizontalAlignment.Center
            //            textStyle {
            //                base: SystemDefaults.TextStyles.TitleText
            //            }
            //        }
            layout: StackLayout {

            }

            Label {
                text: "<br>About Party Charades</br><br>Version 1.0.0</br><br>Author:Wayne Hinds</br><br>Date: September 2013</br><br><a href='https://twitter.com/AppQueen1'>@AppQueen1</a></br>"
                multiline: true
                textStyle.textAlign: TextAlign.Center
                horizontalAlignment: HorizontalAlignment.Center
                textFormat: TextFormat.Html
            }

            Label {
                text: "	Privacy Policy
                Do we disclose any information to outside parties? 
                We do not sell, trade, or otherwise transfer to outside parties your personally identifiable information. This does not include trusted third parties who assist us in operating our website, conducting our business, or servicing you, so long as those parties agree to keep this information confidential. We may also release your information when we believe release is appropriate to comply with the law, enforce our site policies, or protect ours or others rights, property, or safety. However, non-personally identifiable visitor information may be provided to other parties for marketing, advertising, or other uses.
                
                Your Consent 
                By using this app, you consent to this app's privacy policy.
                
                Contacting Us 
                If there are any questions regarding this privacy policy you may contact us using the information below. 
                waynelahinds@yahoo.ca"

                multiline: true
                topMargin: 200

            }
        }
    }
}
