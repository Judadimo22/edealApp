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
        body {
          margin: 0;
          padding: 0;
          font-family: "Roboto", sans-serif;
        }
        .container {
          background-color: #f5f5f5;
          padding: 20px;
          max-width: 600px;
          margin: 0 auto;
        }
        .header {
          background-color: #e8e112;
          text-align: center;
          padding: 20px;
        }
        .title {
          font-size: 30px;
          color: #ffffff;
          margin: 0;
        }
        .content {
          background-color: #ffffff;
          padding: 20px;
          text-align: center;
        }
        .text {
          color: #524898;
          font-size: 16px;
          margin: 0;
          padding: 10px 0;
        }
        .code {
          color: #524898;
          font-size: 20px;
          font-weight: bold;
          margin: 10px 0;
        }
      </style>
    </head>
    <body>
      <div class="container">
        <div class="header">
          <h1 class="title">Bienvenido a Edeal</h1>
        </div>
        <div class="content">
          <p class="text">Hola ${email},</p>
          <p class="text">Por favor, confirma tu cuenta:</p>
          <h2 class="code">Código de confirmación: ${code}</h2>
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

