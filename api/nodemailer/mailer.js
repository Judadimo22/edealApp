const nodemailer = require("nodemailer");

let transporter = nodemailer.createTransport({
  host: "smtp.gmail.com",
  port: 465,
  secure: true,
  auth: {
    user: 'diazmorenodavid16@gmail.com',
    pass: 'pokfnpvqntcxujcr',
  },
});

transporter.verify().then(() => {
  console.log("Listo para enviar");
});

const eMail = async (email, code) => {
  let html = `<!DOCTYPE html>
  <html lang="en">
    <head>
      <meta charset="UTF-8" />
      <meta http-equiv="X-UA-Compatible" content="IE=edge" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <style>
        p,
        a,
        h1,
        h2,
        h3,
        h4,
        h5 {
          font-family: "Roboto", sans-serif !important;
        }
        h1 {
          font-size: 30px !important;
        }
        h2 {
          font-size: 25px !important;
        }
        h3 {
          font-size: 20px !important;
        }
        h4 {
          font-size: 15px !important;
        }
        h5 {
          font-size: 12px !important;
        }
        p,
        a {
          font-size: 12px !important;
        }
      </style>
    </head>
    <body>
      <div style="width: 100%; background-color: #E8E112; padding: 20px;">
        <div style="padding: 20px;">
          <div style="background-color: #E8E112; padding: 10px 0px; width: 100%; text-align: center;"></div>
        </div>
        <div style="background-color: #524898; margin-top: 0px; padding: 30px 0px 15px 0px; text-align: center;">
          <h2 style="color: white;">Bienvenido a Edeal</h2>
          <p style="color: white;">Hola ${email},</p>
          <p style="color: white;">Por favor, confirma tu cuenta:</p>
          <h3 style="color: white; font-weight: bold; margin: 10px 0;">Código de confirmación: ${code}</h3>
        </div>
      </div>
    </body>
  </html>`;

  let msj = {
    from: 'Edeal" <diazmorenodavid16@gmail.com>',
    to: email,
    subject: 'Código de verificación: ' + code,
    text: "Verify Your Account",
    html: html,
  };

  const data = await transporter.sendMail(msj);
};

module.exports = { eMail };
