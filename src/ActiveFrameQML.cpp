#include "ActiveFrameQML.h"

#include <bb/cascades/SceneCover>
#include <bb/cascades/Container>
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>

using namespace bb::cascades;

ActiveFrameQML::ActiveFrameQML(QObject *parent)
: SceneCover(parent)
{
	QmlDocument *qml = QmlDocument::create("asset:///AppCover.qml").parent(parent);
	Container *mMainContainer = qml->createRootObject<Container>();
	setContent(mMainContainer);

	yourScore = mMainContainer->findChild<Label*>("yourScore");
	gamePaused = mMainContainer->findChild<Label*>("gamePaused");

	yourScore->setParent(mMainContainer);
	gamePaused->setParent(mMainContainer);


}

void ActiveFrameQML::update() {
	gamePaused->setText("Play Party Charades");
	yourScore->setText("Start a Game!");
}

void ActiveFrameQML::updateSingle(QString scoreText) {
	gamePaused->setText("Playing a game!");
	yourScore->setText("Your score is "+scoreText);
}

void ActiveFrameQML::updateTeam(QString scoreTextA, QString scoreTextB) {
	gamePaused->setText("Playing a game!");
	yourScore->setText("Team A score is "+scoreTextA+ " Team B score is " +scoreTextB);
}



void ActiveFrameQML::updateSingleTimer(bool wasStarted,bool wasEnded, QString scoreTxt, QString timeLeft) {
	//if a game hasnt started
	if (wasStarted==false && timeLeft!="Done"){
		gamePaused->setText("Start A Game!");
		yourScore->setText("");
	}

	else{
		if (wasEnded==true){
			gamePaused->setText("Game Finished");
			yourScore->setText("Your score was "+ scoreTxt);
		}else{
			gamePaused->setText("Game Paused with "+ timeLeft +" secs left");
			yourScore->setText("Your score is "+ scoreTxt);
		}
	}
}

