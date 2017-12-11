From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3] pwm: imx: Let PWM be active during suspend
Date: Mon, 11 Dec 2017 10:16:25 +0100
Message-ID: <20171211091625.GA10671@ulmo>
References: <1511220443-26629-1-git-send-email-festevam@gmail.com>
 <20171205084701.GC7386@ulmo>
 <CAOMZO5DsWN_N5ygkCmNK_Dktp7UANdkSXi+iLacXnVHQ9j53AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:37053 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbdLKJQa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Dec 2017 04:16:30 -0500
Received: by mail-qt0-f170.google.com with SMTP id f2so36743768qtj.4
        for <linux-pwm@vger.kernel.org>; Mon, 11 Dec 2017 01:16:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5DsWN_N5ygkCmNK_Dktp7UANdkSXi+iLacXnVHQ9j53AA@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, Russell King <linux@arm.linux.org.uk>, Fabio Estevam <fabio.estevam@nxp.com>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 04:56:00PM -0200, Fabio Estevam wrote:
> Hi Thierry,
>=20
> On Tue, Dec 5, 2017 at 6:47 AM, Thierry Reding <thierry.reding@gmail.com>=
 wrote:
>=20
> > It looks like this would also keep other PWMs enabled in suspend. If for
> > example you hooked up a fan to this PWM this change would make it so
> > that the fan would remain on during suspend. That doesn't sound
> > desirable to me.
>=20
> It is expected that the PWM fan driver would disable the fan upon
> entering into suspend.
>=20
> The old vendor driver also sets the STOPEN bit unconditionally:
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm=
/plat-mxc/pwm.c?h=3Dimx_2.6.35_11.09.01#n97
>=20
> >
> > On v2, I see this reply from you:
> >
> >         Please note that on imx6qdl-cuboxi the pwm is active low.
>=20
> What I meant to say is that a logic level 0 turns on the LED.

That's the same thing.

> > I also see that imx6q-cubox-i uses the "fsl,imx27-pwm" compatible
> > version of this controller and that supports polarity inversion. I think
> > the correct thing to do here is to mark the PWM as inverted (according
> > to the DTS file it is actually the pwmleds node that has an active-low
> > property). If you invert the PWM you could add extra code to the PWM
> > driver to deal with this properly and set STOPEN only for inverted PWM
> > signals.
>=20
> Polarity is correct:
>=20
> echo 0 > brightness --> turns off the LED
> echo 248 > brightness ---> turns on the LED with the maximum brightness
>=20
> It is only the behaviour during suspend which is not correct (LCD turns o=
n).

This does indicate all the more that you're trying to invert the
polarity in the user driver. If you look at the driver code it will
simply invert the duty cycle for active-low LEDs. That matches the
symptoms that you describe: when you set zero brightness you will
in fact get full duty cycle and hence the LED turns off. However,
this does no longer work if the PWM signal is truly inverted, since
the "off" state of the PWM signal will actually be "on".

> Tried your suggestion of changing the polarity and it does not work
> and breaks the usage during normal mode (non low power).

How does it break? Note that you have to change the polarity of the PWM
signal (in the pwms property) and then remove the "active-low" property
=66rom the leds device tree node to avoid double inversion.

Thierry

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlouTOYACgkQ3SOs138+
s6EMIA/+KZKqQCDLwfRSQB/wUppJeHGixrGJMnC3mvaLEE086veASHnNbuytL8/H
BC06xEn11Pe+xZqtusuDVOJxeXNO03bBPQ6ivAzOBbdJwZzTh8zuIWUVISj0B+Fi
Sk6kDhclBZS5BNrl1XLzh0oY1SBDpjI8nXNKI7+amtJNhxRXPgDAACzJCz9yf4ha
BbuqtNOTGlfjBOn9Mlf5BCcOettbfIHHVa7b5DajMLwL/YY7sVayAwVkaVVq1TPB
8CtwjGnF/il19vQP5od55bKBTP6IVr1fSsi0TO0NwP5/wE39kt5IkjrrzVEKCC8c
hzUOhZX8e3eP93qRqhW4vXTPzA8Qf18HELYEt6C6FB4Lfp4b/DV0YFuOmGYXHnAz
XB5kcJ64fU5Ai3KfQ1fXn6mdCjqjlzF6MdCFLADgM2HGry7FA1UnFD+C23H3JuRu
xJk9joqkCDnN40dXWTaVf8jacQjgarGRpHlbRv4Z/tQ8+wMvkY+pjjqUMIQW7U/6
gTLRJlXfbBdSIQs6X+OQ5WFWJitun54mXT8eg3EVjxAljSkKvbxQPr7OblekREzc
YWve+/kxCN2fVaVOQNvA0H5DWSV091DK+6+dwHlft4OJEAhIAohFY/cSEYYZVo5R
EfF4LAUnWJrPRwCtNnzvxeYBzy/jDr+WQkueITutiA/e0NbhEj0=
=OGjM
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
