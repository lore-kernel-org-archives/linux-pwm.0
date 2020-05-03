From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
Date: Sun, 3 May 2020 22:20:23 +0300
Message-ID: <CAHp75Vcg9kdgr=AXxwmXO-rmL5z9nq=zJvCww8wG7i1B3BQNYg@mail.gmail.com>
References: <20200503105453.23658-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgECTUh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 3 May 2020 15:20:37 -0400
In-Reply-To: <20200503105453.23658-1-miquel.raynal@bootlin.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-pwm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, May 3, 2020 at 1:54 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> The MAX7313 chip is fully compatible with the PCA9535 on its basic
> functions but can also manage the intensity on each of its ports with
> PWM. Each output is independent and may be tuned with 16 values (4
> bits per output). The period is always 32kHz, only the duty-cycle may
> be changed. One can use any output as GPIO or PWM.

Besides the messing with parameter types (int vs. bool) it should be
rebased on top of Bartosz's tree.

Also, it might be that we can instantiate a kind of device (MFD?) that
will share same regmap between two and have naturally different
drivers for GPIO and PWM.

Side note: I still think this should be a function of the pin when
driver will be converted to pin control. Now this change delays the
conversion and better approach. But as I said before, if GPIO
maintainers consider this good enough to go like this, I won't object.

Some background. It's known that some pin control devices may have PWM
function (limited, like blinking led or so, or full) and it would be
nice to have a pin mux option which enables PWM on a requested pin. Or
PWM tries to enable proper pin muxing (this sounds even better in
order of sharing same API from pin control, like "pin is available for
GPIO").

-- 
With Best Regards,
Andy Shevchenko
