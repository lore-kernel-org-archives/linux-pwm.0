From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 2/2] gpio: bcm-kona: use platform_irq_count
Date: Wed, 11 Dec 2019 10:49:54 +0100
Message-ID: <20191211094954.qk44xv3uh33rgz7z@pengutronix.de>
References: <1575451330-11112-1-git-send-email-peng.fan@nxp.com>
 <1575451330-11112-2-git-send-email-peng.fan@nxp.com>
 <20191204100925.sjp6cztozlm5qm6y@pengutronix.de>
 <CAMpxmJWMSnTB6JF8vOCmQzE3swWhbx8uwNEzU=qf49L26QCDPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMpxmJWMSnTB6JF8vOCmQzE3swWhbx8uwNEzU=qf49L26QCDPQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Peng Fan <peng.fan@nxp.com>, "rjui@broadcom.com" <rjui@broadcom.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "sbranden@broadcom.com" <sbranden@broadcom.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh@kernel.org" <robh@kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, dl-linux-imx <linux-imx@nxp.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, Dec 11, 2019 at 10:30:33AM +0100, Bartosz Golaszewski wrote:
> śr., 4 gru 2019 o 11:09 Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> napisał(a):
> >
> > On Wed, Dec 04, 2019 at 09:24:39AM +0000, Peng Fan wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > platform_irq_count() is the more generic way (independent of
> > > device trees) to determine the count of available interrupts. So
> > > use this instead.
> > >
> > > As platform_irq_count() might return an error code (which
> > > of_irq_count doesn't) some additional handling is necessary.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >
> > > V3:
> > >  Use %pe
> >
> > Great. Note that with %pe there is a dependency on commit 57f5677e535b
> > ("printf: add support for printing symbolic error names") which was
> > applied during the current merge window.
> >
> 
> Why would %pe be better in this case? The function returned an int -
> why convert it to a pointer?

The conversion to a pointer is (currently still) needed, because there
is no printk facility (yet) that consumes an int error pointer and
results in the respecting code.

Somewhere on my todo-list is an item to fix that, but we're not there
yet and so the best option is to use %pe.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
