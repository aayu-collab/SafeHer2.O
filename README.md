# SafeHer 🚺

## 📌 Problem Statement
In emergency situations, women often do not have the time to unlock their phones, open an app, and manually send an alert. There is a critical need for an accessible solution that provides an instant, hands-free way to reach out for help, even with weak or zero internet access. **SafeHer** is designed to empower women with swift, reliable emergency features like voice-activated SOS and offline SMS alerts to bridge this gap.

## 🚀 Features
- **Voice SOS 🎤**: Triggers an emergency alert completely hands-free by simply speaking a specific keyword (like *"help"*).
- **Offline Alert (SMS) 📩**: Automatically sends SMS alerts containing live GPS coordinates to trusted contacts via GSM/Twilio, ensuring safety even in critical situations.
- **Live Location Tracking 🌍**: Instantly captures the user's highest-accuracy GPS location when in danger.
- **Emergency Contacts 📱**: User-friendly interface to manage up to multiple trusted family members or friends.

## 📱 How to Use the App
1. **Create an Account:** Open the app and **Signup** using your Name, Email, and Phone number.
2. **Add Emergency Contacts:** Go to the *Emergency Contacts* section (Phone Icon) and add the phone numbers of your trusted family or friends.
3. **Manual SOS:** On the Home Page, tap the large red **SOS** button. It will count down for 3 seconds (giving you a chance to cancel) before grabbing your live GPS coordinates and texting your contacts via Twilio.
4. **Voice SOS:** Tap the **Mic** icon at the bottom. The app will start listening in the background. Say the word **"help"**, and the app will instantly trigger the SOS alert entirely hands-free!

## 💻 Tech Stack
- **Frontend**: Flutter (Cross-platform UI)
- **Backend**: Node.js & Express (Robust APIs)
- **Database**: MongoDB (Secure cloud storage for users/contacts)
- **Communications**: GSM / Twilio API (For direct offline SMS notifications)

## 🛠️ How to Run the Project Locally

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
- [Node.js](https://nodejs.org/) installed.
- A free [MongoDB Atlas](https://www.mongodb.com/) cluster URL.
- A free Twilio Account for SMS API keys.

### 1. Clone the Repository
Open your terminal and clone the repository to your local machine:
```bash
git clone https://github.com/aayu-collab/SafeHer2.O.git
cd SafeHer
```

### 2. Setup the Backend (Node.js)
1. Open a terminal and navigate to the backend directory:
   ```bash
   cd backend
   ```
2. Install the required Node dependencies:
   ```bash
   npm install
   ```
3. Create a `.env` file in the `backend` folder and add your credentials:
   ```env
   MONGO_URI=your_mongodb_connection_string
   JWT_SECRET=your_jwt_secret_key
   PORT=5000
   TWILIO_SID=your_twilio_account_sid
   TWILIO_AUTH_TOKEN=your_twilio_auth_token
   TWILIO_PHONE=your_twilio_phone_number
   ```
4. Start the backend server:
   ```bash
   node server.js
   ```

### 2. Setup the Frontend (Flutter)
1. Open a new terminal and navigate to the Flutter project folder:
   ```bash
   cd "frontend/safeher project/my_app"
   ```
2. Download all the required Flutter packages:
   ```bash
   flutter pub get
   ```
3. Run the app on an Emulator or Google Chrome:
   ```bash
   flutter run
   ```
![image alt]()
![image alt]()
![image alt]()
![image alt]()
![image alt]()
## 🛡️ License
This project is open-source and intended to contribute to community safety.
