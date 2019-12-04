From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/2] gpio: mvebu: use platform_irq_count
Date: Wed, 4 Dec 2019 19:47:54 +0100
Message-ID: <20191204184754.5oj2xoem2v3544rx@pengutronix.de>
References: <1575433106-16171-1-git-send-email-peng.fan@nxp.com>
 <20191204072422.vfo3mrrcaav75jv4@pengutronix.de>
 <CAMpxmJUAk5Y3mX_irTjwveaii8W=coaG0w2aWvFXUEXqHxpArQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMpxmJUAk5Y3mX_irTjwveaii8W=coaG0w2aWvFXUEXqHxpArQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Peng Fan <peng.fan@nxp.com>, "rjui@broadcom.com" <rjui@broadcom.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "sbranden@broadcom.com" <sbranden@broadcom.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh@kernel.org" <robh@kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, dl-linux-imx <linux-imx@nxp.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alice Guo <alice.guo@nxp.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

On Wed, Dec 04, 2019 at 05:33:04PM +0100, Bartosz Golaszewski wrote:
> śr., 4 gru 2019 o 08:24 Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> napisał(a):
> >
> > On Wed, Dec 04, 2019 at 04:20:41AM +0000, Peng Fan wrote:
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
> > Reviewed-and-Commit-Log-Provided-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> This is not a valid tag, but I take it as Suggested-by and Reviewed-by. :)

If you care about the validity of such tags, I suggest you take a look
at the output of

	$ git rev-list v4.0..v5.4 | while read rev; do git cat-file commit $rev; done | sed -n 's/ *\(.*-by\):.*/\1/p' | sort | uniq -c | sort -n

(which finds all tags used between 4.0 and 5.4 with its usage count).

A few of the tags (admittedly with low usage count :-) included there are:

  Badly-reviewed-by
  Bonus-points-awarded-by
  Compile-tested and Reviewed-by
  Enthusiastically-Acked-by
  Mea-culpa-by
  \o/-by
  Brown-paper-bag-by

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
