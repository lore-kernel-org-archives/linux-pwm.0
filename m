From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] leds/pwm: Don't disable pwm when setting brightness
 to 0
Date: Thu, 12 Feb 2015 10:47:53 +0100
Message-ID: <20150212094753.GB10842@pengutronix.de>
References: <1423734290-19750-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1423734290-19750-3-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423734290-19750-3-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-leds-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-leds@vger.kernel.org
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

On Thu, Feb 12, 2015 at 10:44:50AM +0100, Uwe Kleine-K=F6nig wrote:
> This fixes disabling the LED on i.MX28. The PWM hardware delays using
> the newly set pwm-config until the beginning of a new period. It's ve=
ry
> likely that pwm_disable is called before the current period ends. In
> case the LED was on brightness=3Dmax before the LED stays on because =
in
> the disabled PWM block the period never ends.
>=20
> Also only call pwm_enable only once in the probe call back and the
> matching pwm_disable in .remove(). Moreover the pwm is explicitly
> initialized to off.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
sigh, I just noticed I did my compile test with LEDS_PWM off. This
fails to build, but as this patch (soft) depends on patch 1 anyhow, I
will resend once patch 1 is ok to go in. (I hope to reach this state!)

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
