From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 04/14] pwm: meson: change MISC_CLK_SEL_WIDTH to MISC_CLK_SEL_MASK
Date: Tue, 28 May 2019 20:04:45 +0200
Message-ID: <CAFBinCCWYf4TJ8GTL3PrHMRfL3=Ma-QrTAGSyAp5OQc0M-67Jg@mail.gmail.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-5-martin.blumenstingl@googlemail.com>
 <3b61897a-267b-fd6e-181b-a8c7e47918fb@baylibre.com> <CAFBinCDXNy4=6U2gsh6vK6WEtJKAdfDGPMrpPJthbp5Rru1hbg@mail.gmail.com>
 <20190527180047.nfsjfqs22coyqmvp@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527180047.nfsjfqs22coyqmvp@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, May 27, 2019 at 8:00 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Mon, May 27, 2019 at 07:46:43PM +0200, Martin Blumenstingl wrote:
> > Hi Neil,
> >
> > On Mon, May 27, 2019 at 2:26 PM Neil Armstrong <narmstrong@baylibre.com=
> wrote:
> > >
> > > On 25/05/2019 20:11, Martin Blumenstingl wrote:
> > > > MISC_CLK_SEL_WIDTH is only used in one place where it's converted i=
nto
> > > > a bit-mask. Rename and change the macro to be a bit-mask so that
> > > > conversion is not needed anymore. No functional changes intended.
> > > >
> > > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.=
com>
> > > > ---
> > > >  drivers/pwm/pwm-meson.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> > > > index c62a3ac924d0..84b28ba0f903 100644
> > > > --- a/drivers/pwm/pwm-meson.c
> > > > +++ b/drivers/pwm/pwm-meson.c
> > > > @@ -33,7 +33,7 @@
> > > >  #define MISC_A_CLK_DIV_SHIFT 8
> > > >  #define MISC_B_CLK_SEL_SHIFT 6
> > > >  #define MISC_A_CLK_SEL_SHIFT 4
> > > > -#define MISC_CLK_SEL_WIDTH   2
> > > > +#define MISC_CLK_SEL_MASK    0x3
> > >
> > > NIT I would have used GENMASK here
> > that was my initial idea but I decided against it.
> > the variant I came up with was: #define MISC_CLK_SEL_MASK    GENMASK(1,=
 0)
> >
> > however, the actual offset is either 4 or 6 (depending on the PWM chann=
el)
> > and I felt that duplicating the macro would just make it more complicat=
ed
> > so instead I chose to be consistent with MISC_CLK_DIV_MASK
>
> An option would be:
>
>         #define MISC_CLK_SEL_MASK(hwid)         GENMASK(1 + 4 * (hwid), 0=
 + 4 * (hwid))
>
> (Note I didn't check a manual to the 4 above is probably wrong.)
that (or at least something similar) will work
the catch here is: we use it to initialize the mux clock and the
common clock framework expects us to set "shift" and "mask", while
mask starts at bit 0 instead of shift

this is how the current code is being used at the moment:
  channel->mux.shift =3D meson_pwm_per_channel_data[i].clk_sel_shift;
  channel->mux.mask =3D MISC_CLK_SEL_MASK;

so with MISC_CLK_SEL_MASK this would become:
  channel->mux.shift =3D meson_pwm_per_channel_data[i].clk_sel_shift;
  channel->mux.mask =3D MISC_CLK_SEL_MASK(i) >> channel->mux.shift;

or we could dynamically determine the "shift" using ffs or friends

my own brain parses the variant from the patch best
I'm happy to change it though if we can find something "better"


Martin
