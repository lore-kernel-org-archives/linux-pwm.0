From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCHv3 1/3] pwm: make the PWM_POLARITY flag in DTB optional
Date: Wed, 9 Apr 2014 08:12:09 +0200
Message-ID: <20140409061209.GF27055@pengutronix.de>
References: <1395235375-12925-1-git-send-email-LW@KARO-electronics.de>
 <1395996540-10999-1-git-send-email-LW@KARO-electronics.de>
 <1395996540-10999-2-git-send-email-LW@KARO-electronics.de>
 <20140402055350.GX17250@pengutronix.de>
 <20140407113652.GE26985@ulmo>
 <20140408070259.68923987@ipc1.ka-ro>
 <CAAYSxhpqe1BVDigMKQ18qEpYNyHGFQ6n5cXWdnUO7HZKSCwzWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38493 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbaDIGMY (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Apr 2014 02:12:24 -0400
Content-Disposition: inline
In-Reply-To: <CAAYSxhpqe1BVDigMKQ18qEpYNyHGFQ6n5cXWdnUO7HZKSCwzWQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tim Kryger <tim.kryger@linaro.org>
Cc: Lothar =?iso-8859-15?Q?Wa=DFmann?= <LW@karo-electronics.de>, Thierry Reding <thierry.reding@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>

On Tue, Apr 08, 2014 at 01:43:22PM -0700, Tim Kryger wrote:
> On Mon, Apr 7, 2014 at 10:02 PM, Lothar Wa=DFmann <LW@karo-electronic=
s.de> wrote:
> > Thierry Reding wrote:
>=20
> >> No. You cannot emulate polarity inversion in software.
> >>
> > Why not?
> >
> > duty_ns =3D period_ns - duty_ns;
>=20
> Since I made the same mistake, I will pass along the pointer Thierry =
gave me.
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
> Either way, hacking the duty in software certainly would get the
> high/low order wrong.

This only relevant if you have some reference signal the PWM must be
relative to, for example if you combine multiple PWMs for motor control=
=2E
=46or PWMs used for backlight or beepers a signal inversion in software=
 is
perfectly fine. And I also think that it makes sense to put it once int=
o
the framework instead of bothering all consumer drivers with the
inversion.

Sascha

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
