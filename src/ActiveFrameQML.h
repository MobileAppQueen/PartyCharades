/*
 * ActiveFrame.h
 *
 *  Created on: Apr 2, 2013
 *      Author: wbarichak
 */

#ifndef ACTIVEFRAMEQML_H_
#define ACTIVEFRAMEQML_H_

#include <QObject>
#include <bb/cascades/Label>
#include <bb/cascades/SceneCover>

using namespace ::bb::cascades;

class ActiveFrameQML: public SceneCover {
    Q_OBJECT

public:
    ActiveFrameQML(QObject *parent=0);

public slots:
Q_INVOKABLE void update();
Q_INVOKABLE void updateSingleTimer(bool wasStarted,bool wasEnded, QString scoreTxt, QString timeLeft);
Q_INVOKABLE void updateSingle(QString scoreText);
Q_INVOKABLE void updateTeam(QString scoreTextA, QString scoreTextB) ;



private:
    bb::cascades::Label *yourScore;
    bb::cascades::Label *gamePaused;
};

#endif /* ACTIVEFRAMEQML_H_ */
