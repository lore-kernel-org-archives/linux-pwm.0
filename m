From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5] gpio: pca953x: Add Maxim MAX7313 PWM support
Date: Mon, 20 Jan 2020 20:31:18 +0100
Message-ID: <20200120193118.3vzwy5uxnsy2w4sv@pengutronix.de>
References: <20200107133130.1338-1-miquel.raynal@bootlin.com>
 <20200120121329.GC206171@ulmo>
 <20200120134137.54dc307e@xps13>
 <20200120141944.GD206171@ulmo>
 <20200120144457.eznywc423ehw6kuc@pengutronix.de>
 <20200120163822.232b1410@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:32769 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgATTbX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 14:31:23 -0500
Content-Disposition: inline
In-Reply-To: <20200120163822.232b1410@xps13>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org

Hi Miquèl,

On Mon, Jan 20, 2020 at 04:38:22PM +0100, Miquel Raynal wrote:
> One dumb question that I still have is: besides any backward
> compatibility aspects, do we really care about the period/frequency of
> the PWM? Why do we enforce a period and an active duration, while
> we could limit ourselves to a ratio and let the driver use the most
> suitable frequency if the hardware supports it?

There are situations where just fixing the ratio would (nearly) be good
enough. For example if you drive an LED just requesting a ratio might
look fine at first glance. But 

	.period = 5000 ms, .duty_cycle = 2500 ms

has quite a different effect than

	.period = 500 ns, .duty_cycle = 250 ns

while both are valid if you requested 50%.

Having said that I think the lowlevel API (i.e. what a device driver has
to implement) is sane, as it allows to implement all possible requests,
even if there might be a consumer that cares more about the absolute
value of duty-cycle than the duty-cycle/period ratio; and it matches
what most hardware models implement. There is usually a register to
specify the period and one to specify the duty-cycle.

And on top of that (at least once there is pwm_round_state()) you can
implement all sort of helper functions that implement for example "best
effort 50% with a period < 2ms".

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
