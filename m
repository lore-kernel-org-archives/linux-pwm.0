From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3 2/2] gpio: bcm-kona: use platform_irq_count
Date: Wed, 11 Dec 2019 11:03:13 +0100
Message-ID: <CAMpxmJVSe9crFabywAdeEWWRYmCW9cE2tRcKBb7eyfKuPV9RXw@mail.gmail.com>
References: <1575451330-11112-1-git-send-email-peng.fan@nxp.com>
 <1575451330-11112-2-git-send-email-peng.fan@nxp.com> <20191204100925.sjp6cztozlm5qm6y@pengutronix.de>
 <CAMpxmJWMSnTB6JF8vOCmQzE3swWhbx8uwNEzU=qf49L26QCDPQ@mail.gmail.com> <20191211094954.qk44xv3uh33rgz7z@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191211094954.qk44xv3uh33rgz7z@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Peng Fan <peng.fan@nxp.com>, "rjui@broadcom.com" <rjui@broadcom.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "sbranden@broadcom.com" <sbranden@broadcom.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh@kernel.org" <robh@kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, dl-linux-imx <linux-imx@nxp.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

=C5=9Br., 11 gru 2019 o 10:49 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> On Wed, Dec 11, 2019 at 10:30:33AM +0100, Bartosz Golaszewski wrote:
> > =C5=9Br., 4 gru 2019 o 11:09 Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
> > >
> > > On Wed, Dec 04, 2019 at 09:24:39AM +0000, Peng Fan wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > platform_irq_count() is the more generic way (independent of
> > > > device trees) to determine the count of available interrupts. So
> > > > use this instead.
> > > >
> > > > As platform_irq_count() might return an error code (which
> > > > of_irq_count doesn't) some additional handling is necessary.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >
> > > > V3:
> > > >  Use %pe
> > >
> > > Great. Note that with %pe there is a dependency on commit 57f5677e535=
b
> > > ("printf: add support for printing symbolic error names") which was
> > > applied during the current merge window.
> > >
> >
> > Why would %pe be better in this case? The function returned an int -
> > why convert it to a pointer?
>
> The conversion to a pointer is (currently still) needed, because there
> is no printk facility (yet) that consumes an int error pointer and
> results in the respecting code.
>
> Somewhere on my todo-list is an item to fix that, but we're not there
> yet and so the best option is to use %pe.
>

Fair enough, I wasn't aware of this new format modifier.

Both applied.

Bartosz
