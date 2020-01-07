From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4] gpio: pca953x: Add Maxim MAX7313 PWM support
Date: Tue, 7 Jan 2020 13:31:04 +0100
Message-ID: <CACRpkdYsE8e4LfYkiaYyqdcPsgg6r4pqzHKwqUBveoLou_hSnw@mail.gmail.com>
References: <20191129191023.2209-1-miquel.raynal@bootlin.com> <CAHp75VeJNZWz_Cv=dozAwt74OBu8TgyYe5bNU3sHreRMdqxR8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeJNZWz_Cv=dozAwt74OBu8TgyYe5bNU3sHreRMdqxR8A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, Dec 16, 2019 at 10:51 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Nov 29, 2019 at 9:13 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> > The MAX7313 chip is fully compatible with the PCA9535 on its basic
> > functions but can also manage the intensity on each of its ports with
> > PWM. Each output is independent and may be tuned with 16 values (4
> > bits per output). The period is always 32kHz, only the duty-cycle may
> > be changed. One can use any output as GPIO or PWM.
>
> Thanks for an update!
>
> Still I think it's wrong approach. What should be done is:
>  - adding a pin configuration type of PWM (when, for example, argument
> defines duty cycle and period)
>  - conversion to pin control of this driver
>  - enabling pin configuration PWM for it.
>
> For now it looks like a custom way of doing it.
> If GPIO maintainers are okay with it, I'll not object, just want to
> have than something like TODO updated for the matter.

Yeah well that is a possible way, it pretty much lies with the PWM
maintainer, I have one guiding stanza "rough consensus and running
code". Making big upfront code conversions just to get a small piece
of hardware going is just too much from me as subsystem maintainer,
a dual sub-system driver is perfectly fine in my opinion.

That said contributors are encouraged to extend scope and be
ambitious and set precedents for others to follow by going the extra
mile.

(That sounds like corporate management!)

But that must be voluntary work outside the scope of just hardware
enablement.

Yours,
Linus Walleij
