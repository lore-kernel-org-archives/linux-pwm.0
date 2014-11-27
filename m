From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: Again about leds-pwm and pwm-mxs
Date: Thu, 27 Nov 2014 09:50:04 +0100
Message-ID: <20141127085004.GO30369@pengutronix.de>
References: <20141126171242.GO4431@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38228 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200AbaK0IuI (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Nov 2014 03:50:08 -0500
Content-Disposition: inline
In-Reply-To: <20141126171242.GO4431@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de

On Wed, Nov 26, 2014 at 06:12:42PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> two years ago I addressed the issue that on i.MX28 a led connected to=
 a
> pwm-mxs device doesn't go off when brightness is set to 0. I tried ag=
ain
> later to find an acceptable solution.
> (Links to respective threads:
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/282593/focus=3D2=
82596)
> http://thread.gmane.org/gmane.linux.kernel/1381289
> )
>=20
> The technical side is well understood: The problem is that leds-pwm d=
oes
> the following:
>=20
> 	pwm_config(led_dat->pwm, new_duty, led_dat->period);
>=20
> 	if (new_duty =3D=3D 0)
> 		pwm_disable(led_dat->pwm);
> 	else
> 		pwm_enable(led_dat->pwm);
>=20
> On i.MX28 reconfiguring the duty cycle only takes effect after the
> current period is over. That means that if the previous configuration
> was duty=3Dperiod (i.e. "on") the likely outcome of the above sequenc=
e
> with new_duty=3D0 is that setting the duty cycle to 0 is scheduled bu=
t the
> current period never ends because the clock is stopped. So the led ke=
eps
> being on.
>=20
> Now we need a settlement in which way this should be fixed.
> There are several possibilities, roughly in order of my preference:
>  a) Declare the pin state after pwm_disable as undefined
>     In this case the leds-pwm driver must not call pwm_disable when
>     expecting a certain brightness (here: off).
>     A nice follow-up is then to patch the drivers that work the way t=
he
>     leds-pwm author expected to call their equivalent of pwm_disable
>     themselves on new_duty=3D0.
>  b) Let pwm_config return at once, implement the waiting in a new cal=
l
>     pwm_sync() that either busy-loops or sleeps until the configurati=
on
>     is=20
>  c) Make the call to pwm_config for pwm-mxs block until the new perio=
d
>     started.
>  d) Make the call to pwm_config for pwm-mxs sleep until the new perio=
d
>     started.
>     (Not sure this works nicely because IIRC there is no irq availabl=
e
>     that triggers accordingly.)
>  e) In pwm_disable detect that there is a reconfiguration pending and
>     block accordingly.
>  f) Extend the PWM-API to differentiate the two variants of pwm_confi=
g
>     E.g. make pwm_config sleep/busy-looping until the requested confi=
g is
>     active plus a new function pwm_config_schedule.
>=20
> Back then Sascha and Matt also prefered a). The obvious downside of a=
)
> is that most people expect pwm_disable implying a constant 0. The
> obvious advantage of a) is that it's the simplest alternative and als=
o
> works best when there are board specific inverters involved or the pw=
m
> supports built-in inversion.

I'm still in favor for a). IMO it's the only sane way to solve problems
with inverted PWMs. A PWM in disabled state has an undefined output on
some hardwares and we don't even axactly know which value a disabled
PWM should have. Using a duty cycle of 0% or 100% makes the desired
output very clear.

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
