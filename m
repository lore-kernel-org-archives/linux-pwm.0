From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v4] gpio: pca953x: Add Maxim MAX7313 PWM support
Date: Mon, 6 Jan 2020 22:11:35 +0100
Message-ID: <20200106221135.1da27439@xps13>
References: <20191129191023.2209-1-miquel.raynal@bootlin.com>
        <CAHp75VeJNZWz_Cv=dozAwt74OBu8TgyYe5bNU3sHreRMdqxR8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeJNZWz_Cv=dozAwt74OBu8TgyYe5bNU3sHreRMdqxR8A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: linux-pwm@vger.kernel.org

Hi Andy,

> > +/*
> > + * Max7313 PWM specific methods
> > + *
> > + * Limitations:
> > + * - Does not support a disabled state
> > + * - Period fixed to 31.25ms
> > + * - Only supports normal polarity
> > + * - Some glitches cannot be prevented
> > + */  
> 
> Can we have below in a separate file and attach it to the gpio-pca953x
> code iff CONFIG_PWM != n?

I tried to do it but there are too many functions from the PCA
driver that would be called in the PWM annex. This leads to hiding
generic parts of the driver which have nothing to do with the PWM in a
header file, which I don't think is wise. I prefer not to do it.

Thanks for your understanding,
Miquèl
