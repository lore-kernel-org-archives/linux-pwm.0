From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
Date: Mon, 29 Jun 2020 19:50:41 +0300
Message-ID: <CAHp75Vehv_Cp1AhMPhk8ktyp-uHSkgweqnhhSq_7w2Kf9y=7XQ@mail.gmail.com>
References: <20200503105453.23658-1-miquel.raynal@bootlin.com> <20200629160844.6ecf79c1@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200629160844.6ecf79c1@xps13>
Sender: linux-kernel-owner@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-pwm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Mon, Jun 29, 2020 at 5:08 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> Miquel Raynal <miquel.raynal@bootlin.com> wrote on Sun,  3 May 2020
> 12:54:53 +0200:
>
> > The MAX7313 chip is fully compatible with the PCA9535 on its basic
> > functions but can also manage the intensity on each of its ports with
> > PWM. Each output is independent and may be tuned with 16 values (4
> > bits per output). The period is always 32kHz, only the duty-cycle may
> > be changed. One can use any output as GPIO or PWM.

> Can I have a status on this patch please?
>
> If it was forgotten, I would be good to have it queued now, otherwise,
> may I know the reason?

TWIMC, just my 2 cents about this patch.
I don't like it in this form. On the constructive side I can propose
at least two ways to solve:
a) introduce a PWM as a pin mode; move pca953x to pin control; use
this mode with PWM driver being separated from the pin control;
b) introduce an MFD that provides two parts for this GPIO & PWM.

Personally I would go with a) as I know at least one more pin
controller which will get an advantage of this (and it's definitely
not an MFD).

If GPIO / pin control maintainers consider this okay, I will rest my
case, but see above...

-- 
With Best Regards,
Andy Shevchenko
