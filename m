From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC PATCH 05/15] pwm: introduce default period and polarity
 concepts
Date: Thu, 2 Jul 2015 08:44:45 +0200
Message-ID: <20150702064445.GC11824@pengutronix.de>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-6-git-send-email-boris.brezillon@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54920 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbbGBGp0 (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Jul 2015 02:45:26 -0400
Content-Disposition: inline
In-Reply-To: <1435738921-25027-6-git-send-email-boris.brezillon@free-electrons.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, linux-fbdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bryan Wu <cooloney@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Doug Anderson <dianders@google.com>, Mark Brown <broonie@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, linux-arm-kernel@lists.infradead.org, Jingoo Han <jingoohan1@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org

On Wed, Jul 01, 2015 at 10:21:51AM +0200, Boris Brezillon wrote:
> When requested by a user, the PWM is assigned a default period and po=
larity
> extracted from the DT, the platform data or statically set by the dri=
ver.
> Those default values are currently stored in the period and polarity
> fields of the pwm_device struct, but they will be stored somewhere el=
se
> once we have introduced the architecture allowing for hardware state
> retrieval.
>=20
> The pwm_set_default_polarity and pwm_set_default_period should only b=
e
> used by PWM drivers or the PWM core infrastructure to specify the
> default period and polarity values.
Would it make sense to put the prototypes of
pwm_set_default_p{olarity,eriod} into (say) drivers/pwm/pwm-private.h
then?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
