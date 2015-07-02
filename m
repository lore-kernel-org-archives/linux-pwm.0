From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC PATCH 16/15] pwm: add informations about polarity, duty
 cycle and period to debugfs
Date: Thu, 2 Jul 2015 15:01:41 +0200
Message-ID: <20150702150141.5018a791@bbrezillon>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
	<3365087.n2eEES60JK@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:38980 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751051AbbGBNBp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Thu, 2 Jul 2015 09:01:45 -0400
In-Reply-To: <3365087.n2eEES60JK@diego>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>, linux-fbdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bryan Wu <cooloney@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Doug Anderson <dianders@google.com>, Mark Brown <broonie@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Jingoo Han <jingoohan1@gmail.com>, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org

On Wed, 01 Jul 2015 23:50:46 +0200
Heiko St=C3=BCbner <heiko@sntech.de> wrote:

> The pwm-states make it possible to also output the polarity, duty cyc=
le
> and period information in the debugfs pwm summary-outout.
> This makes it easier to gather overview information about pwms withou=
t
> needing to walk through the sysfs attributes of every pwm.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> might be nice to have too ;-)

Yes.

>=20
>  drivers/pwm/core.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 6dafd8e..79037a2 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -951,9 +951,18 @@ static void pwm_dbg_show(struct pwm_chip *chip, =
struct seq_file *s)
>  		if (test_bit(PWMF_REQUESTED, &pwm->flags))
>  			seq_puts(s, " requested");
> =20
> -		if (pwm_is_enabled(pwm))
> +		if (pwm_is_enabled(pwm)) {
>  			seq_puts(s, " enabled");
> =20
> +			seq_printf(s, " period:%uns",
> +				   pwm_get_period(pwm));
> +			seq_printf(s, " duty:%uns",
> +				   pwm_get_duty_cycle(pwm));
> +			seq_printf(s, " polarity:%s",
> +				   pwm_get_polarity(pwm) ? "inverse"
> +							 : "normal");

I would print those values even if the PWM is not enabled.



--=20
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
