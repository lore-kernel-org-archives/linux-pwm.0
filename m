From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Again about leds-pwm and pwm-mxs
Date: Wed, 26 Nov 2014 18:12:42 +0100
Message-ID: <20141126171242.GO4431@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47834 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbaKZRMq (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Nov 2014 12:12:46 -0500
Content-Disposition: inline
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de

Hello,

two years ago I addressed the issue that on i.MX28 a led connected to a
pwm-mxs device doesn't go off when brightness is set to 0. I tried agai=
n
later to find an acceptable solution.
(Links to respective threads:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/282593/focus=3D282=
596)
http://thread.gmane.org/gmane.linux.kernel/1381289
)

The technical side is well understood: The problem is that leds-pwm doe=
s
the following:

	pwm_config(led_dat->pwm, new_duty, led_dat->period);

	if (new_duty =3D=3D 0)
		pwm_disable(led_dat->pwm);
	else
		pwm_enable(led_dat->pwm);

On i.MX28 reconfiguring the duty cycle only takes effect after the
current period is over. That means that if the previous configuration
was duty=3Dperiod (i.e. "on") the likely outcome of the above sequence
with new_duty=3D0 is that setting the duty cycle to 0 is scheduled but =
the
current period never ends because the clock is stopped. So the led keep=
s
being on.

Now we need a settlement in which way this should be fixed.
There are several possibilities, roughly in order of my preference:
 a) Declare the pin state after pwm_disable as undefined
    In this case the leds-pwm driver must not call pwm_disable when
    expecting a certain brightness (here: off).
    A nice follow-up is then to patch the drivers that work the way the
    leds-pwm author expected to call their equivalent of pwm_disable
    themselves on new_duty=3D0.
 b) Let pwm_config return at once, implement the waiting in a new call
    pwm_sync() that either busy-loops or sleeps until the configuration
    is=20
 c) Make the call to pwm_config for pwm-mxs block until the new period
    started.
 d) Make the call to pwm_config for pwm-mxs sleep until the new period
    started.
    (Not sure this works nicely because IIRC there is no irq available
    that triggers accordingly.)
 e) In pwm_disable detect that there is a reconfiguration pending and
    block accordingly.
 f) Extend the PWM-API to differentiate the two variants of pwm_config
    E.g. make pwm_config sleep/busy-looping until the requested config =
is
    active plus a new function pwm_config_schedule.

Back then Sascha and Matt also prefered a). The obvious downside of a)
is that most people expect pwm_disable implying a constant 0. The
obvious advantage of a) is that it's the simplest alternative and also
works best when there are board specific inverters involved or the pwm
supports built-in inversion.

b) looks quite natural to me. It could implemented simply as:

	void pwm_sync(..)
	{
		if (driver->sync)
			driver->sync(...)
	}

and so nothing has to be done for drivers that apply a reconfiguration
instantly.

=46or all alternatives from b) to f) the result of calling pwm_disable
should be specified to yield a 0 output (maybe only iff the configured
duty is 0?). I don't know many pwm hardware cores but this might be
unnatural for some of them?

I consider f) only a theoretical alternative because it makes life
harder for both pwm-driver writers and consumers.

It would be nice to be able to close this case finally after two years.
How can we determine which alternative to pick? Thierry?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
