From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCHv3 1/3] pwm: make the PWM_POLARITY flag in DTB optional
Date: Wed, 9 Apr 2014 08:04:50 +0200
Message-ID: <20140409080450.4856681c@ipc1.ka-ro>
References: <1395235375-12925-1-git-send-email-LW@KARO-electronics.de>
	<1395996540-10999-1-git-send-email-LW@KARO-electronics.de>
	<1395996540-10999-2-git-send-email-LW@KARO-electronics.de>
	<20140402055350.GX17250@pengutronix.de>
	<20140407113652.GE26985@ulmo>
	<20140408070259.68923987@ipc1.ka-ro>
	<CAAYSxhpL_0FJvuvGODMTZDm7DtK3eBTVYdhf1Ot7PW94gSM8iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAYSxhpL_0FJvuvGODMTZDm7DtK3eBTVYdhf1Ot7PW94gSM8iw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Kryger <tim.kryger@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pwm@vger.kernel.org

Hi,

Tim Kryger wrote:
> On Mon, Apr 7, 2014 at 10:02 PM, Lothar Wa=C3=9Fmann <LW@karo-electro=
nics.de>wrote:
> >
> >
> > Thierry Reding wrote:
> >
> > > No. You cannot emulate polarity inversion in software.
> > >
> > Why not?
> >
> > duty_ns =3D period_ns - duty_ns;
> >
>=20
> Since I made the same mistake, I will pass along the pointer Thierry =
gave
> me.
>=20
> In include/linux/pwm.h the second difference for an inverted signal i=
s
> described.
>=20
> /**
>  * enum pwm_polarity - polarity of a PWM signal
>  * @PWM_POLARITY_NORMAL: a high signal for the duration of the duty-
>  * cycle, followed by a low signal for the remainder of the pulse
>  * period
>  * @PWM_POLARITY_INVERSED: a low signal for the duration of the duty-
>  * cycle, followed by a high signal for the remainder of the pulse
>  * period
>  */
> enum pwm_polarity {
> PWM_POLARITY_NORMAL,
> PWM_POLARITY_INVERSED,
> };
>=20
> Of course, I suspect not all PWM hardware respects this definition of
> inverted output.
>=20
> Either way, hacking the duty in software certainly would get the high=
/low
> order wrong.
>=20
OK. But for a periodic signal this doesn't make any difference. It's
just a matter of where you set your reference point.
Only if you program the PWM to create a single cycle you would see the
difference. I wonder if this is a real life usecase though.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
