
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
          font-size: 60px !important;
        }
        h2 {
          font-size: 45px !important;
        }
        h3 {
          font-size: 35px !important;
        }
        h4 {
          font-size: 25px !important;
        }
        h5 {
          font-size: 15px !important;
        }
        p,
        a {
          font-size: 15px !important;
        }
      </style>
    </head>
    <div style="width: 100%; background-color: #E8E112">
      <div style="padding: 20px 10px 20px 10px">
        <div
          style="
            background-color: #524898;
            padding: 10px 0px 10px 0px;
            width: 100%;
            text-align: center;
          "
        ></div>
      </div>
      <div
        style="
          background-color: #524898;
          margin-top: 0px;
          padding: 20px 0px 5px 0px;
          text-align: center;
        "
      >
        <h2>Bienvenido a Edeal</h2>
        <p>Hola ${email} por favor confirma tu cuenta el código de confirmación es ${code}</p>
          </div>
        </div>
        </div>
      </div>
      <div></div>
    </div>
    <body></body>
  </html>`;


  let msj = {
    from: 'Edeal" <diazmorenodavid16@gmail.com>',
    to: email,
    subject: 'Código de verificación:' + code ,
    text: "Verify Your account",
    html: html,
  };

  const data = await transporter.sendMail(msj);
};

module.exports = { eMail };