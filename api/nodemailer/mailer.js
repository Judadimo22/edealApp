
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
    <div style="width: 100%; background-color: #e3e3e3">
      <div style="padding: 20px 10px 20px 10px">
        <div
          style="
            background-color: rgb(203, 173, 3);
            padding: 10px 0px 10px 0px;
            width: 100%;
            text-align: center;
          "
        ></div>
      </div>
      <div
        style="
          background-color: #e3e3e3;
          margin-top: 0px;
          padding: 20px 0px 5px 0px;
          text-align: center;
        "
      >
        <h2>Welcome to Edeal</h2>
        <p>
        Please connfirm your account with the code
        </p>
          </div>
        </div>
          <p style="font-size: 20px; padding: 0px 20px 0px 20px">Soporte</p>
            @ 2023 Edeal, todos los derechos reservados.
          </p>
        </div>
      </div>
      <div></div>
    </div>
    <body></body>
  </html>`;

  let msj = {
    from: 'Edeal" <diazmorenodavid16@gmail.com>',
    to: email,
    subject: 'Verification code'+ code ,
    text: "Verify Your account",
    html: html,
  };

  const data = await transporter.sendMail(msj);
};

module.exports = { eMail };