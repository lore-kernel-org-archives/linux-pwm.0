From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
Date: Wed, 1 Jul 2020 00:27:31 +0300
Message-ID: <CAHp75VcxQ-qK+RYmfULDx3cHQW9W8__-Gf8EFw7Hgqsz0oPkjA@mail.gmail.com>
References: <20200503105453.23658-1-miquel.raynal@bootlin.com>
 <20200629160844.6ecf79c1@xps13> <20200629195044.uvgma53cajiko3gf@pengutronix.de>
 <20200630085828.1aebdf99@xps13> <CAMpxmJUHy+5ynmsU6FhX=MJR6XbwoNr65NGqzuAd0Bm-JS1kWw@mail.gmail.com>
 <20200630124500.m765t276atb3wqgy@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20200630124500.m765t276atb3wqgy@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio <linux-gpio@vger.kernel.org>, linux-pwm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, Jun 30, 2020 at 3:45 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Jun 30, 2020 at 11:13:31AM +0200, Bartosz Golaszewski wrote:
> > I can't find anything in any of the previous threads. What was the
> > reason to not go the MFD way here?
>
> MFD doesn't work because the different "modes" are not orthogonal. So
> this is not a single device that provides several functions at the same
> time that can be used in parallel.

Did I get this correctly that it's either *all* pins are GPIO or *all* are =
PWM?

Otherwise, it fits from my point of view.

--=20
With Best Regards,
Andy Shevchenko
