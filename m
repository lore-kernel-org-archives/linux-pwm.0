From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] gpio: pca953x: Add Maxim MAX7313 PWM support
Date: Tue, 15 Oct 2019 16:30:55 +0200
Message-ID: <20191015163055.0d8f44e5@xps13>
References: <20191014124803.13661-1-miquel.raynal@bootlin.com>
        <CAHp75Vc4vnNVKc+Q_TY8DpwV4rLZYGm2MvGBC7r67XjmtNoskQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vc4vnNVKc+Q_TY8DpwV4rLZYGm2MvGBC7r67XjmtNoskQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: linux-pwm@vger.kernel.org

Hi Andy,

Thanks for the feedback.

Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Mon, 14 Oct 2019
20:59:01 +0300:

> On Mon, Oct 14, 2019 at 4:09 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > The MAX7313 chip is fully compatible with the PCA9535 on its basic
> > functions but can also manage the intensity on each of its ports with
> > PWM. Each output is independent and may be tuned with 16 values (4
> > bits per output). The period is always 32kHz, only the duty-cycle may
> > be changed. One can use any output as GPIO or PWM.  
> 
> Can we rather not contaminate driver with this?
> 
> Just register a separate PWM driver and export its functionality to
> GPIO, or other way around (in the latter case we actually have PCA8685
> which provides a GPIO fgunctionality).
> 

I understand your concern but I am not sure to understand which
solution you have in mind. In the former case, could you explain a bit
more what you are thinking about? Would linking the PWM support with
the GPIO driver (code would be located in another .c file) work for
you? Or maybe you would prefer an MFD on top of the GPIO driver?

As for the later case, I am not willing to re-implement GPIO support in
an alternate driver for an already supported chip, it is too much work
for the time I can spend on it.


Thanks,
Miquèl
