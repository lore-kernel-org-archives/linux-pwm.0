From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] gpio: pca953x: Add Maxim MAX7313 PWM support
Date: Tue, 5 Nov 2019 11:08:39 +0200
Message-ID: <CAHp75Ve6_8dXJgF6c2OdZDeV=icyRondvMKwTxhom-RXDACfUA@mail.gmail.com>
References: <20191014124803.13661-1-miquel.raynal@bootlin.com>
 <CAHp75Vc4vnNVKc+Q_TY8DpwV4rLZYGm2MvGBC7r67XjmtNoskQ@mail.gmail.com>
 <20191015163055.0d8f44e5@xps13> <CAHp75VemkA7kap0O7=iACX4cD5_r6QXaLF6nS8R94ErStK0DwA@mail.gmail.com>
 <20191104161103.64995b8a@xps13> <CAMpxmJVjyUXSNFEiTxMC1bdzXTex74DqeiHPqLBPdnb2_LYRnQ@mail.gmail.com>
 <20191104203346.epdbzflnynh2gf3z@pengutronix.de> <CAHp75VdULzZ6NXP7fp=6KQFAHOSvoJ-_WTqfcmhQJbrLUw3M4Q@mail.gmail.com>
 <20191105100157.2b6eb22b@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191105100157.2b6eb22b@xps13>
Sender: linux-kernel-owner@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

On Tue, Nov 5, 2019 at 11:02 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote on Tue, 5 Nov 2019
> 09:06:37 +0200:
> > On Mon, Nov 4, 2019 at 10:33 PM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:

> > For me it sounds more likely that PWM is a *pin function* of a pin
> > controller and actually this GPIO driver should be a pin controller
> > with corresponding function(s).
> >
>
> Ok, thanks for the input, I will address Thierry's comments and
> re-submit as a single file (same shape as in v1).

Perhaps I have to be more clear. What I meant is that pin control
should support PWM pin function and PCA953x be converted to a pin
control + GPIO + PWM.
Above definitely is not what you did and it's not for immediate submission.

I really would like to hear if it makes sense.

--=20
With Best Regards,
Andy Shevchenko
