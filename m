From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3] pwm: imx: Let PWM be active during suspend
Date: Mon, 11 Dec 2017 13:09:55 +0100
Message-ID: <20171211120955.GJ10671@ulmo>
References: <1511220443-26629-1-git-send-email-festevam@gmail.com>
 <20171205084701.GC7386@ulmo>
 <CAOMZO5DsWN_N5ygkCmNK_Dktp7UANdkSXi+iLacXnVHQ9j53AA@mail.gmail.com>
 <20171211091625.GA10671@ulmo>
 <20171211093559.GS10595@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FCKy2vjPBX+S/5dE"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:38083 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbdLKMJ7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Dec 2017 07:09:59 -0500
Received: by mail-qt0-f172.google.com with SMTP id d4so37756674qtj.5
        for <linux-pwm@vger.kernel.org>; Mon, 11 Dec 2017 04:09:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171211093559.GS10595@n2100.armlinux.org.uk>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Fabio Estevam <festevam@gmail.com>, linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar Wassmann <LW@KARO-electronics.de>


--FCKy2vjPBX+S/5dE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2017 at 09:36:00AM +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 11, 2017 at 10:16:25AM +0100, Thierry Reding wrote:
> > On Tue, Dec 05, 2017 at 04:56:00PM -0200, Fabio Estevam wrote:
> > > Hi Thierry,
> > >=20
> > > On Tue, Dec 5, 2017 at 6:47 AM, Thierry Reding <thierry.reding@gmail.=
com> wrote:
> > >=20
> > > > It looks like this would also keep other PWMs enabled in suspend. I=
f for
> > > > example you hooked up a fan to this PWM this change would make it so
> > > > that the fan would remain on during suspend. That doesn't sound
> > > > desirable to me.
> > >=20
> > > It is expected that the PWM fan driver would disable the fan upon
> > > entering into suspend.
> > >=20
> > > The old vendor driver also sets the STOPEN bit unconditionally:
> > > http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch=
/arm/plat-mxc/pwm.c?h=3Dimx_2.6.35_11.09.01#n97
> > >=20
> > > >
> > > > On v2, I see this reply from you:
> > > >
> > > >         Please note that on imx6qdl-cuboxi the pwm is active low.
> > >=20
> > > What I meant to say is that a logic level 0 turns on the LED.
> >=20
> > That's the same thing.
> >=20
> > > > I also see that imx6q-cubox-i uses the "fsl,imx27-pwm" compatible
> > > > version of this controller and that supports polarity inversion. I =
think
> > > > the correct thing to do here is to mark the PWM as inverted (accord=
ing
> > > > to the DTS file it is actually the pwmleds node that has an active-=
low
> > > > property). If you invert the PWM you could add extra code to the PWM
> > > > driver to deal with this properly and set STOPEN only for inverted =
PWM
> > > > signals.
> > >=20
> > > Polarity is correct:
> > >=20
> > > echo 0 > brightness --> turns off the LED
> > > echo 248 > brightness ---> turns on the LED with the maximum brightne=
ss
> > >=20
> > > It is only the behaviour during suspend which is not correct (LCD tur=
ns on).
> >=20
> > This does indicate all the more that you're trying to invert the
> > polarity in the user driver. If you look at the driver code it will
> > simply invert the duty cycle for active-low LEDs. That matches the
> > symptoms that you describe: when you set zero brightness you will
> > in fact get full duty cycle and hence the LED turns off. However,
> > this does no longer work if the PWM signal is truly inverted, since
> > the "off" state of the PWM signal will actually be "on".
>=20
> There was discussion back in 2014 about this.  The problem is the
> iMX6 PWM implementation is rather fscked.
>=20
> The pwm specification in DT has support for inverting the PWM output:
>=20
> "Optionally, the pwm-specifier can encode a number of flags (defined in
> <dt-bindings/pwm/pwm.h>) in a third cell:
> - PWM_POLARITY_INVERTED: invert the PWM signal polarity"
>=20
> The problem, though, is that the imx6 PWM driver never took advantage
> of that, and set #pwm-cells to 2.  So, for imx6, the PWM specification
> is a phandle and a specifier, without the flags.
>=20
> Adding the flags is not trivial (as was discussed back then) as DT
> has no knowledge apart from the #*-cells property about how many
> entries there are - the < > is just for our eyeballs and is mostly
> otherwise meaningless.
>=20
> Had this not been the case, then adding support for PWM_POLARITY_INVERTED
> in pwm-imx6 would have been trivial, and probably the correct
> solution, but alas, the discussion back then pointed to the current
> solution being the best given the already broken implementation.

We ended up merging a solution for this earlier this year that everybody
was confident would allow us to do this in a backwards-compatible way:

	commit 42883cbc086b3f7aca9f1754f2d570af922825fc
	Author: Lothar Wassmann <LW@KARO-electronics.de>
	Date:   Sun Jan 29 22:54:13 2017 +0100

	    pwm: Make the PWM_POLARITY flag in DTB optional
	   =20
	    Change the PWM chip driver registration so that a chip driver that
	    supports polarity inversion can still be used with DTBs that don't
	    provide the polarity flag as part of the specifier.
	   =20
	    This is done to provide polarity inversion support for the pwm-imx
	    driver without having to modify all existing DTS files.
	   =20
	    Signed-off-by: Lothar Wassmann <LW@KARO-electronics.de>
	    Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
	    Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
	    Signed-off-by: Lukasz Majewski <l.majewski@majess.pl>
	    Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
	    Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

I think this should allow pwm-imx to fully take advantage of the
polarity inversion feature. Although the DT would have to be changed and
all PWM specifiers updated at the same time as the #pwm-cells property.

Adding Lothar for visibility since he's obviously been using this.

Thierry

--FCKy2vjPBX+S/5dE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAloudZEACgkQ3SOs138+
s6FLZw//Vc3kimtjKy1NNnUDdHhfyAN0apZZgOGlSFPi/1EZGUhBV1hE5Uy/dRNj
WQMU0iYdfpzWqJIpRLGmlCBLnMgSt55q2DbzS3uwVWrnQAR/bik1oB1U3HdqO/aL
wPTyuqcM0GgXVuCyLl8wImtkKHEwwKvW+VZWA8k/uag9/EgsYEPXaX2qEwxD1Lr9
0GwIpssL5D8KKzNfFQT5K96T0my1AspZZT+WBsDp1DeEHgmRsnQsF3sdti2Z7/XK
NGMvoM/wCQNmbyTPiJvoLA/ne8uo/eYAFadT4lkOWzCycFhrpwQjhRWZCwta3ALr
i4G0sLrnN51leYqunFZc22xhzuhgFx/doJxi4m/vUlbOmLMfEe1ezKx1upNCDRuE
Fbt2upo1BsDJPTw0nrT4mwYve7v9XhPiPxMtocl91/9WJOc5jcdPRTBYIIx5bYDG
P2Lvw8mcxDQjLjPdy8hplqrEXBhpDrYc7GiM6FUuMHy8NhIf4obmvDswtkhp3I/h
1GIan1I3Sl7oSQAVbo5YC1WgRqfE1bNqoEfuik7ub2o2ulCBGJ3/pNDehhKNpQhE
E+VvtKwhgmkb7n8Ex5AebOjhlvLXP4wsV2faNO6ypjPemuBVRDSpqCSQb7oYq2LN
8nGrXgGwhyZVlsq8mVJ5KEhqOI1MHlTFu7nHwvgxUiinzX3ERNo=
=waRC
-----END PGP SIGNATURE-----

--FCKy2vjPBX+S/5dE--
