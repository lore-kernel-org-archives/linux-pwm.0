From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [RFC PATCH 00/10] Netronix embedded controller driver for Kobo
 and Tolino ebook readers
Date: Mon, 6 Jul 2020 21:28:48 +0200
Message-ID: <20200706212848.7e19886b@aktux>
References: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
        <20200630084051.66feadea@aktux>
        <20200630071523.GA2983@latitude>
        <20200630221447.3e03ae28@aktux>
        <20200704205808.GD2578@latitude>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGFT3X (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Jul 2020 15:29:23 -0400
In-Reply-To: <20200704205808.GD2578@latitude>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Sam Ravnborg <sam@ravnborg.org>, Linus Walleij <linus.walleij@linaro.org>, Heiko Stuebner <heiko.stuebner@theobroma-systems.com>, Stephan Gerhold <stephan@gerhold.net>, Lubomir Rintel <lkundrak@v3.sk>, Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.t>

On Sat, 4 Jul 2020 22:58:08 +0200
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:

> On Tue, Jun 30, 2020 at 10:14:47PM +0200, Andreas Kemnade wrote:
> > On Tue, 30 Jun 2020 09:15:23 +0200
> > Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:
> >  =20
> > > On Tue, Jun 30, 2020 at 08:40:51AM +0200, Andreas Kemnade wrote:
> > > [...] =20
> > > > got a chance to test it on a Tolino Shine 2 HD.
> > > > It uses the RTC from the RC5T619 but backlight seems to go via MSP4=
30
> > > > EC.
> > > >=20
> > > > I got this.
> > > >=20
> > > > [    1.453603] ntxec 0-0043: Netronix embedded controller version f=
110 detected.
> > > > [   10.723638] ntxec-rtc 21a0000.i2c:embedded-controller@43:rtc: re=
gistered as rtc0
> > > > [   10.775276] ntxec-pwm: probe of 21a0000.i2c:embedded-controller@=
43:pwm failed with error -5   =20
> > >=20
> > > Hmm, -EIO from the PWM driver.
> > >  =20
> > turing debugging on: =20
>=20
> (edited for compactness:)
> > [  330.332971] i2c i2c-0: write slave address: addr=3D0x86   ACK receiv=
ed
> > [  330.334420] i2c i2c-0: write byte: B0=3D0xA3              ACK receiv=
ed
> > [  330.334790] i2c i2c-0: write byte: B1=3D0x0               No ACK =20
>=20
> > [  330.352339] i2c i2c-0: write slave address: addr=3D0x86   ACK receiv=
ed
> > [  330.362208] i2c i2c-0: write byte: B0=3D0xA1              ACK receiv=
ed
> > [  330.362479] i2c i2c-0: write byte: B1=3D0xFF              No ACK =20
>=20
> > [  330.363112] i2c i2c-0: write slave address: addr=3D0x86   ACK receiv=
ed
> > [  330.363362] i2c i2c-0: write byte: B0=3D0xA2              ACK receiv=
ed
> > [  330.363608] i2c i2c-0: write byte: B1=3D0xFF              No ACK =20
>=20
> Hmm, it doesn't ack the writes to 0xA3, 0xA1 and 0xA2, which should
> disable the PWM output and then disable the auto-off timer (according to
> the vendor kernel).
>=20
> And you said in your other mail that you can actually toggle the light
> with writes to 0xA3, so I suspect a bug in the EC firmware here (which
> may have gone unnoticed because the vendor kernel doesn't check if the
> i2c transfers succeed). :/
>=20
That is a also my theory.

> IMHO we should get this driver merged first, and perhaps add a quirk to
> deal with the missing ACKs later (unless a better solution is found).
>=20
Yes, that can be done separately (after the Tolino Shine 2 HD dtb is
in, I am polishing it right now).

Regards,
Andreas
