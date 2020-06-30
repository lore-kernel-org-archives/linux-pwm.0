From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [RFC PATCH 00/10] Netronix embedded controller driver for Kobo
 and Tolino ebook readers
Date: Tue, 30 Jun 2020 08:40:51 +0200
Message-ID: <20200630084051.66feadea@aktux>
References: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730190AbgF3Gl1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Jun 2020 02:41:27 -0400
In-Reply-To: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Sam Ravnborg <sam@ravnborg.org>, Linus Walleij <linus.walleij@linaro.org>, Heiko Stuebner <heiko.stuebner@theobroma-systems.com>, Stephan Gerhold <stephan@gerhold.net>, Lubomir Rintel <lkundrak@v3.sk>, Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.t>

Hi,

On Sun, 21 Jun 2020 00:39:04 +0200
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

> Hi,
>=20
> This patchset adds basic support for the embedded controller found on
> older ebook reader boards designed by/with the ODM Netronix Inc.[1] and
> sold by Kobo or Tolino, for example the Kobo Aura and the Tolino Shine.
> These drivers are based on the vendor kernel sources, but in order to
> all information in a single place, I documented the register interface
> of the EC on GitHub[4].
>=20
> A few things still needs to be ironed out, hence the RFC tag:
>  - The reboot/reset handler in patch 3/10 calls into I2C code, which may
>    sleep, but reboot handlers are apparently not allowed to sleep.
>  - I'm not sure I got the YAML DT bindings right. I have also included
>    the plain text DT bindings for reference.
>=20
>=20
got a chance to test it on a Tolino Shine 2 HD.
It uses the RTC from the RC5T619 but backlight seems to go via MSP430
EC.

I got this.

[    1.453603] ntxec 0-0043: Netronix embedded controller version f110 dete=
cted.
[   10.723638] ntxec-rtc 21a0000.i2c:embedded-controller@43:rtc: registered=
 as rtc0
[   10.775276] ntxec-pwm: probe of 21a0000.i2c:embedded-controller@43:pwm f=
ailed with error -5
[   10.850597] ntxec-rtc 21a0000.i2c:embedded-controller@43:rtc: hctosys: u=
nable to read the hardware clock

version number matchess with what the vendor kernel reports. Maybe we
should document which version is running on which devices?

&i2c1 {
        pinctrl-names =3D "default","sleep";
        pinctrl-0 =3D <&pinctrl_i2c1>;
        pinctrl-1 =3D <&pinctrl_i2c1_sleep>;
        status =3D "okay";

        embedded-controller@43 {
//              pinctrl-names =3D "default";
//              pinctrl-0 =3D <&pinctrl_ec>;
                compatible =3D "netronix,ntxec";
                reg =3D <0x43>;
                interrupts-extended =3D <&gpio5 11 IRQ_TYPE_EDGE_FALLING>;
                interrupt-controller;
                #interrupt-cells =3D <1>;

                ec_pwm: pwm {
                        compatible =3D "netronix,ntxec-pwm";
                        #pwm-cells =3D <2>;
                };

                rtc {
                        compatible =3D "netronix,ntxec-rtc";
                };
        };
};

Regards,
Andreas
