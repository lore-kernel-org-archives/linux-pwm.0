From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
Date: Sun, 3 May 2020 21:41:26 +0200
Message-ID: <20200503194126.wlwuide5q2oxzlwt@pengutronix.de>
References: <20200503105453.23658-1-miquel.raynal@bootlin.com>
 <CAHp75Vcg9kdgr=AXxwmXO-rmL5z9nq=zJvCww8wG7i1B3BQNYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbgECTle (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 3 May 2020 15:41:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B55EC061A0E
        for <linux-pwm@vger.kernel.org>; Sun,  3 May 2020 12:41:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHp75Vcg9kdgr=AXxwmXO-rmL5z9nq=zJvCww8wG7i1B3BQNYg@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-pwm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hello Andy, hello Miquel,

On Sun, May 03, 2020 at 10:20:23PM +0300, Andy Shevchenko wrote:
> On Sun, May 3, 2020 at 1:54 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > The MAX7313 chip is fully compatible with the PCA9535 on its basic
> > functions but can also manage the intensity on each of its ports with
> > PWM. Each output is independent and may be tuned with 16 values (4
> > bits per output). The period is always 32kHz, only the duty-cycle may
> > be changed. One can use any output as GPIO or PWM.
> 
> Besides the messing with parameter types (int vs. bool) it should be
> rebased on top of Bartosz's tree.
> 
> Also, it might be that we can instantiate a kind of device (MFD?) that
> will share same regmap between two and have naturally different
> drivers for GPIO and PWM.
> 
> Side note: I still think this should be a function of the pin when
> driver will be converted to pin control. Now this change delays the
> conversion and better approach. But as I said before, if GPIO
> maintainers consider this good enough to go like this, I won't object.
> 
> Some background. It's known that some pin control devices may have PWM
> function (limited, like blinking led or so, or full) and it would be
> nice to have a pin mux option which enables PWM on a requested pin. Or
> PWM tries to enable proper pin muxing (this sounds even better in
> order of sharing same API from pin control, like "pin is available for
> GPIO").

There is one thing I see as a pre-condition to the abstraction of
pin-controller + GPIO + PWM: If I configure the PWM with certain
parameters while the pin is still configured as GPIO there must be no
visible effect on the pin. The setting must then be active when the pin
is changed to PWM mode. (And vice versa: The GPIO setting must not
influence the PWM output ...) I didn't check the hardware manual (or the
patch), but if this needs caching of pwm and gpio parameters I would
take that as a strong hint that the abstraction is wrong.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
