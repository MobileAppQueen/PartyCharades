#include "applicationui.hpp"
#include "ActiveFrameQML.h"
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>
#include <bb/system/SystemDialog>
#include "timer.hpp"
using namespace bb::cascades;
using namespace bb::system;

ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
										QObject(app) {
	// prepare the localization
	m_pTranslator = new QTranslator(this);
	m_pLocaleHandler = new LocaleHandler(this);
	if (!QObject::connect(m_pLocaleHandler, SIGNAL(systemLanguageChanged()),
			this, SLOT(onSystemLanguageChanged()))) {
		// This is an abnormal situation! Something went wrong!
		// Add own code to recover here
		qWarning() << "Recovering from a failed connect()";
	}
	// initial load
	onSystemLanguageChanged();

	// Create scene document from main.qml asset, the parent is set
	// to ensure the document gets destroyed properly at shut down.
	QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
	//new code so can use BBM code
	qml->setContextProperty("_app", this);

	//to use active frame
	ActiveFrameQML *activeFrame = new ActiveFrameQML();
	Application::instance()->setCover(activeFrame);
	qml->setContextProperty("activeFrame", activeFrame);

	// Create root object for the UI
	AbstractPane *root = qml->createRootObject<AbstractPane>();
	// Set created root object as the application scene
	app->setScene(root);

	// Register the Timer class in QML as part of version 1.0 of the
	// CustomTimer library
	qmlRegisterType<Timer>("CustomTimer", 1, 0, "Timer");

	// All code below here allows the app to invite users via BBM to download the app
	m_context = new bb::platform::bbm::Context(
			//UUID was generated at random for this sample
			//BE SURE TO USE YOUR OWN UNIQUE UUID. You can gerneate one here: http://www.guidgenerator.com/
			QUuid("1bf5ab4d-a4d2-4b85-95df-073541e3b22a"));
	if (m_context->registrationState()
			!= bb::platform::bbm::RegistrationState::Allowed) {
		connect(m_context,
				SIGNAL(registrationStateUpdated (bb::platform::bbm::RegistrationState::Type)),
				this,
				SLOT(registrationStateUpdated (bb::platform::bbm::RegistrationState::Type)));
		m_context->requestRegisterApplication();
	} else {
		qDebug() << "bbm allowed from appui";
	}
}

void ApplicationUI::onSystemLanguageChanged() {
	QCoreApplication::instance()->removeTranslator(m_pTranslator);
	// Initiate, load and install the application translation files.
	QString locale_string = QLocale().name();
	QString file_name = QString("PartyCharades_%1").arg(locale_string);
	if (m_pTranslator->load(file_name, "app/native/qm")) {
		QCoreApplication::instance()->installTranslator(m_pTranslator);
	}
}

void ApplicationUI::inviteUserToDownloadViaBBM() {
	if (m_context->registrationState()
			== bb::platform::bbm::RegistrationState::Allowed) {
		m_messageService->sendDownloadInvitation();
	} else {
		SystemDialog *bbmDialog = new SystemDialog("OK");
		bbmDialog->setTitle("BBM Connection Error");
		bbmDialog->setBody(
				"BBM is not currently connected. Please setup / sign-in to BBM to remove this message.");
		connect(bbmDialog, SIGNAL(finished(bb::system::SystemUiResult::Type)),
				this, SLOT(dialogFinished(bb::system::SystemUiResult::Type)));
		bbmDialog->show();
		return;
	}
}
void ApplicationUI::updatePersonalMessage(const QString &message) {
	if (m_context->registrationState()
			== bb::platform::bbm::RegistrationState::Allowed) {
		m_userProfile->requestUpdatePersonalMessage(message);
	} else {
		SystemDialog *bbmDialog = new SystemDialog("OK");
		bbmDialog->setTitle("BBM Connection Error");
		bbmDialog->setBody(
				"BBM is not currently connected. Please setup / sign-in to BBM to remove this message.");
		connect(bbmDialog, SIGNAL(finished(bb::system::SystemUiResult::Type)),
				this, SLOT(dialogFinished(bb::system::SystemUiResult::Type)));
		bbmDialog->show();
		return;
	}
}
void ApplicationUI::registrationStateUpdated(
		bb::platform::bbm::RegistrationState::Type state) {
	if (state == bb::platform::bbm::RegistrationState::Allowed) {
		m_messageService = new bb::platform::bbm::MessageService(m_context,
				this);
		m_userProfile = new bb::platform::bbm::UserProfile(m_context, this);
	} else if (state == bb::platform::bbm::RegistrationState::Unregistered) {
		m_context->requestRegisterApplication();
	}
}

// Show an alert dialog.
void ApplicationUI::alert(const QString &message) {
	qDebug() << "alert: " << message;
	SystemDialog *dialog; // SystemDialog uses the BB10 native dialog.
	dialog = new SystemDialog(tr("OK"), 0); // New dialog with on 'Ok' button, no 'Cancel' button
	dialog->setTitle(tr("Alert")); // set a title for the message
	dialog->setBody(message); // set the message itself
	dialog->setDismissAutomatically(true); // Hides the dialog when a button is pressed.

	// Setup slot to mark the dialog for deletion in the next event loop after the dialog has been accepted.
	bool ok = connect(dialog,
			SIGNAL(finished(bb::system::SystemUiResult::Type)), dialog,
			SLOT(deleteLater()));
	Q_ASSERT(ok);
	Q_UNUSED(ok);
	dialog->show();
}
/*
QStringList ApplicationUI::readWords()
{
	QFile fileofwords("app/native/assets/mediumwords.txt");
	QString randErr = "Random error";
	QStringList randErrList=(QStringList()<<randErr);
	QStringList elements;


	if (fileofwords.exists()) {
		if (fileofwords.open(QIODevice::ReadOnly | QIODevice::Text)) {
			QTextStream textStream(&fileofwords);
			while (!textStream.atEnd()) {
				QString line = textStream.readLine();
				elements.append(line);
				qDebug() << line;
			}
			fileofwords.close();
			return elements;
		}
	} else {
		qDebug() << "File doesn't exist";
		QString errorOut = "File doesn't exist";
		QStringList outErrList=(QStringList()<<errorOut);
		return outErrList;
	}
	return randErrList;

	//	while (!sequence.atEnd()) {
	//	     QByteArray line = sequence.readLine();
	//	     signedNo[i] = line[i];
	//	     i++;
	//	 }
	//	 string monsters[20];
	//	    ifstream inData;
	//	    inData.open("names.txt");
	//	    for (int i=0;i<20;i++){
	//	        inData >> monsters[i];
	//	        cout << monsters[i] << endl;
	//	    }inData.close();
	//
	//}
}
*/

QString ApplicationUI::readWords()
{
	QFile fileofwords("app/native/assets/mediumwords.txt");
	QString randErr = "Random error";


	if (fileofwords.exists()) {
		if (fileofwords.open(QIODevice::ReadOnly | QIODevice::Text)) {
			QTextStream textStream(&fileofwords);
			QString textOut = textStream.readAll();
				qDebug() << textOut;
			fileofwords.close();

			return textOut;
		}
	} else {
		qDebug() << "File doesn't exist";
		QString errorOut = "File doesn't exist";
		return errorOut;
	}
	return randErr;
}

