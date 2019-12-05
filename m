From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 1/2] gpio: mvebu: use platform_irq_count
Date: Thu, 5 Dec 2019 10:22:53 +0100
Message-ID: <CAMpxmJU-WK1aXK3M_q12E_u8+wwEimuonmjFa7Hm3Z6Dp7DP_g@mail.gmail.com>
References: <1575433106-16171-1-git-send-email-peng.fan@nxp.com>
 <20191204072422.vfo3mrrcaav75jv4@pengutronix.de> <CAMpxmJUAk5Y3mX_irTjwveaii8W=coaG0w2aWvFXUEXqHxpArQ@mail.gmail.com>
 <20191204184754.5oj2xoem2v3544rx@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191204184754.5oj2xoem2v3544rx@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Peng Fan <peng.fan@nxp.com>, "rjui@broadcom.com" <rjui@broadcom.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "sbranden@broadcom.com" <sbranden@broadcom.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh@kernel.org" <robh@kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, dl-linux-imx <linux-imx@nxp.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alice Guo <alice.guo@nxp.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

=C5=9Br., 4 gru 2019 o 19:47 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> On Wed, Dec 04, 2019 at 05:33:04PM +0100, Bartosz Golaszewski wrote:
> > =C5=9Br., 4 gru 2019 o 08:24 Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
> > >
> > > On Wed, Dec 04, 2019 at 04:20:41AM +0000, Peng Fan wrote:
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
> > > Reviewed-and-Commit-Log-Provided-by: Uwe Kleine-K=C3=B6nig <u.kleine-=
koenig@pengutronix.de>
> >
> > This is not a valid tag, but I take it as Suggested-by and Reviewed-by.=
 :)
>
> If you care about the validity of such tags, I suggest you take a look
> at the output of
>
>         $ git rev-list v4.0..v5.4 | while read rev; do git cat-file commi=
t $rev; done | sed -n 's/ *\(.*-by\):.*/\1/p' | sort | uniq -c | sort -n
>
> (which finds all tags used between 4.0 and 5.4 with its usage count).
>
> A few of the tags (admittedly with low usage count :-) included there are=
:
>
>   Badly-reviewed-by
>   Bonus-points-awarded-by
>   Compile-tested and Reviewed-by
>   Enthusiastically-Acked-by
>   Mea-culpa-by
>   \o/-by
>   Brown-paper-bag-by
>
> Best regards
> Uwe

I am well aware of this and there has been a discussion on LKML some
time ago (I can no longer find it though) about introducing stricter
rules for tags. I don't remember the outcome either though.

Bart
