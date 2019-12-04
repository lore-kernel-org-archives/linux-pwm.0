From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 1/2] gpio: mvebu: use platform_irq_count
Date: Wed, 4 Dec 2019 17:33:04 +0100
Message-ID: <CAMpxmJUAk5Y3mX_irTjwveaii8W=coaG0w2aWvFXUEXqHxpArQ@mail.gmail.com>
References: <1575433106-16171-1-git-send-email-peng.fan@nxp.com> <20191204072422.vfo3mrrcaav75jv4@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191204072422.vfo3mrrcaav75jv4@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Peng Fan <peng.fan@nxp.com>, "rjui@broadcom.com" <rjui@broadcom.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "sbranden@broadcom.com" <sbranden@broadcom.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh@kernel.org" <robh@kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, dl-linux-imx <linux-imx@nxp.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alice Guo <alice.guo@nxp.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

=C5=9Br., 4 gru 2019 o 08:24 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> On Wed, Dec 04, 2019 at 04:20:41AM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > platform_irq_count() is the more generic way (independent of
> > device trees) to determine the count of available interrupts. So
> > use this instead.
> >
> > As platform_irq_count() might return an error code (which
> > of_irq_count doesn't) some additional handling is necessary.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-and-Commit-Log-Provided-by: Uwe Kleine-K=C3=B6nig <u.kleine-koen=
ig@pengutronix.de>

This is not a valid tag, but I take it as Suggested-by and Reviewed-by. :)

Bart

>
> :-)
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
