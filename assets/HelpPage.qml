import bb.cascades 1.0
Page {
    id: mainHelpPage
    // Custom signal for notifying that this page needs to be closed

    titleBar: TitleBar {
      title: "Help"    
    }
    Container {

        
        TextArea {
            text: "<b>Rules for the Game of Charades<br /></b><br />\r\nCharades is a game of pantomimes: you have to 'act out' a phrase without speaking, while the other members of your team try to guess what the phrase is. The objective is for your team to guess the phrase as quickly as possible.<br /><br />\r\n<b>Equipment<br /></b>\r\nNothing but this app and some friends<br />\r\n<br />\r\n<b>Preparation<br /></b>\r\nDivide the players into two teams, preferably of equal size. Agree on how many rounds to play. Review the gestures and hand signals and invent any others you deem appropriate.<br />\r\n\r\n<b>To Play (Team)<br /></b>\r\nEach round of the game proceeds as follows:<br />\r\nA player from Team A will start the game. After he/she has had a short time to review the word, team A then has three minutes to guess the phrase. If they figure it out, someone on Team B has to press the thumbs up , else press thumbs down. The new score will be reflected.<br />\r\nAt the same time it will display a new word for Team B, they pass the phone to Team A to keep score. This continues to happen until both teams reach the agreed up number of rounds. The team with the highest score wins. <br />\r\n\r\n<b>Gestures</b><br />\r\nTo act out a phrase, one usually starts by indicating what category the phrase is in, and how many words are in the phrase. From then on, the usual procedure is to act out the words one at a time (although not necessarily in the order that they appear in the phrase). In some cases, however, it may make more sense to try to act out the 'entire concept' of the phrase at once.<br />\r\nTo Indicate Categories:\r\n<ul>\r\n<li>Book title: Unfold your hands as if they were a book.</li>\r\n<li>Movie title: Pretend to crank an old-fashioned movie camera.</li>\r\n<li>Play title: Pretend to pull the rope that opens a theater curtain.</li>\r\n<li>Song title: Pretend to sing.</li>\r\n<li>TV show: Draw a rectangle to outline the TV screen.</li>\r\n<li>Quote or Phrase: Make quotation marks in the air with your fingers.</li></ul><br /><br />\r\n<b>To Indicate Other Things:</b>\r\n<li>Number of words in the title: Hold up the number of fingers.</li>\r\n<li>Which word you're working on: Hold up the number of fingers again.</li>\r\n<li>Number of syllables in the word: Lay the number of fingers on your arm.</li>\r\n<li>Which syllable you're working on: Lay the number of fingers on your arm again.</li>\r\n<li>Length of word: Make a 'little' or 'big' sign as if you were measuring a fish.</li>\r\n<li>'The entire concept:' sweep your arms through the air.</li>\r\n<li>'On the nose' (i.e., someone has made a correct guess): point at your nose with one hand, while pointing at the person with your other hand.</li>\r\n<li>'Sounds like': Cup one hand behind an ear.</li>\r\n<li>'Longer version of :' Pretend to stretch a piece of elastic.</li>\r\n<li>'Shorter version of:' Do a 'karate chop' with your hand</li>\r\n<li>'Plural': link your little fingers.'</li>\r\n<li>'Past tense': wave your hand over your shoulder toward your back.</li>\r\n<li>A letter of the alphabet: move your hand in a chopping motion toward your arm (near the top of your forearm if the letter is near the beginning of the alphabet, and near the bottom of your arm if the letter is near the end of the alphabet).</li>\r\n"
            backgroundVisible: false
            editable: false
            textFormat: TextFormat.Html
            inputMode: TextAreaInputMode.Text
        }
    }
}
