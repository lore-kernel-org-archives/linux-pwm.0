From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
Date: Tue, 30 Jun 2020 11:13:31 +0200
Message-ID: <CAMpxmJUHy+5ynmsU6FhX=MJR6XbwoNr65NGqzuAd0Bm-JS1kWw@mail.gmail.com>
References: <20200503105453.23658-1-miquel.raynal@bootlin.com>
 <20200629160844.6ecf79c1@xps13> <20200629195044.uvgma53cajiko3gf@pengutronix.de>
 <20200630085828.1aebdf99@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20200630085828.1aebdf99@xps13>
Sender: linux-gpio-owner@vger.kernel.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio <linux-gpio@vger.kernel.org>, linux-pwm@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, Jun 30, 2020 at 8:58 AM Miquel Raynal <miquel.raynal@bootlin.com> w=
rote:
>
> Hi Uwe,
>
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote on Mon, 29 J=
un
> 2020 21:50:44 +0200:
>
> > On Mon, Jun 29, 2020 at 04:08:44PM +0200, Miquel Raynal wrote:
> > > Hello Uwe, Thierry,
> > >
> > > Miquel Raynal <miquel.raynal@bootlin.com> wrote on Sun,  3 May 2020
> > > 12:54:53 +0200:
> > >
> > > > The MAX7313 chip is fully compatible with the PCA9535 on its basic
> > > > functions but can also manage the intensity on each of its ports wi=
th
> > > > PWM. Each output is independent and may be tuned with 16 values (4
> > > > bits per output). The period is always 32kHz, only the duty-cycle m=
ay
> > > > be changed. One can use any output as GPIO or PWM.
> > > >
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > >
> > > Can I have a status on this patch please?
> > >
> > > If it was forgotten, I would be good to have it queued now, otherwise=
,
> > > may I know the reason?
> >
> > You could reply to my feedback ... If you could say there: "What you
> > want isn't possible" I'd count this as a strong indication to not ask t=
o
> > implement Andy's suggestion. (Even if this would be possible, I'm not
> > sure this is a good idea, but still ...)
>
> Sorry for the misunderstanding, but I already replied twice to Andy
> about this. Once in October, again in November, then I gave a shot to
> the idea of splitting the drivers (GPIO vs. PWM) in January. So I
> thought you were sharing your thoughts out loud but was not expecting
> any specific feedback on it.
>
> So, no, even if the idea might make sense, it is not doable in a
> reasonable amount of time. I am not saying it is impossible, but someone
> has to think about it deeper and propose a core structure to handle it
> in a generic and clean way so that other drivers sharing the same
> properties can rely on it. I am not qualified enough to do it the proper
> way in a reasonable time frame.
>
> Thanks,
> Miqu=C3=A8l

Hi Miqu=C3=A8l,

I can't find anything in any of the previous threads. What was the
reason to not go the MFD way here?

Bartosz
