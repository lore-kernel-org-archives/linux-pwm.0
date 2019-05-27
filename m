From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 04/14] pwm: meson: change MISC_CLK_SEL_WIDTH to MISC_CLK_SEL_MASK
Date: Mon, 27 May 2019 19:46:43 +0200
Message-ID: <CAFBinCDXNy4=6U2gsh6vK6WEtJKAdfDGPMrpPJthbp5Rru1hbg@mail.gmail.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-5-martin.blumenstingl@googlemail.com> <3b61897a-267b-fd6e-181b-a8c7e47918fb@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3b61897a-267b-fd6e-181b-a8c7e47918fb@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Neil,

On Mon, May 27, 2019 at 2:26 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 25/05/2019 20:11, Martin Blumenstingl wrote:
> > MISC_CLK_SEL_WIDTH is only used in one place where it's converted into
> > a bit-mask. Rename and change the macro to be a bit-mask so that
> > conversion is not needed anymore. No functional changes intended.
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  drivers/pwm/pwm-meson.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> > index c62a3ac924d0..84b28ba0f903 100644
> > --- a/drivers/pwm/pwm-meson.c
> > +++ b/drivers/pwm/pwm-meson.c
> > @@ -33,7 +33,7 @@
> >  #define MISC_A_CLK_DIV_SHIFT 8
> >  #define MISC_B_CLK_SEL_SHIFT 6
> >  #define MISC_A_CLK_SEL_SHIFT 4
> > -#define MISC_CLK_SEL_WIDTH   2
> > +#define MISC_CLK_SEL_MASK    0x3
>
> NIT I would have used GENMASK here
that was my initial idea but I decided against it.
the variant I came up with was: #define MISC_CLK_SEL_MASK    GENMASK(1, 0)

however, the actual offset is either 4 or 6 (depending on the PWM channel)
and I felt that duplicating the macro would just make it more complicated
so instead I chose to be consistent with MISC_CLK_DIV_MASK

Let me know if you would like me to change it (then I prefer to update
MISC_CLK_DIV_MASK as well).


Martin
