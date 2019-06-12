From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 04/14] pwm: meson: change MISC_CLK_SEL_WIDTH to MISC_CLK_SEL_MASK
Date: Wed, 12 Jun 2019 21:47:07 +0200
Message-ID: <CAFBinCA1SVXVPJdLQr4S99qEoowqXsNqP5tr64xn46xjaKLqeA@mail.gmail.com>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
 <20190608180626.30589-5-martin.blumenstingl@googlemail.com> <20190611163318.tfb5c4jbekjybj76@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611163318.tfb5c4jbekjybj76@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

On Tue, Jun 11, 2019 at 6:33 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
[...]
> > @@ -463,7 +463,7 @@ static int meson_pwm_init_channels(struct meson_pwm=
 *meson,
> >
> >               channel->mux.reg =3D meson->base + REG_MISC_AB;
> >               channel->mux.shift =3D mux_reg_shifts[i];
> > -             channel->mux.mask =3D BIT(MISC_CLK_SEL_WIDTH) - 1;
> > +             channel->mux.mask =3D MISC_CLK_SEL_MASK;
> >               channel->mux.flags =3D 0;
> >               channel->mux.lock =3D &meson->lock;
> >               channel->mux.table =3D NULL;
>
> IMHO clk_mux is ugly here. It could easily just take
>
>         .mask =3D 3 << mux_reg_shifts[i],
in most cases that would be even nicer to read because it could be expresse=
d as:
  .mask =3D GENMASK(5, 4)

so I like your idea in general
though I think it should not block this patch

[...]
> Apart from that, I wonder if the pwm-meson driver should better use
> clk_register_mux instead of open coding it. (Though there doesn't seem
> to exists a devm_ variant of it.)
I tried to use clk_register_mux in the past. it works but it's not as
nice to read as the open-coded variant because it takes 10 parameters.
I find it easier to read 13 separate lines compared to reading a
function call with 10 parameters


Martin
