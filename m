From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 04/14] pwm: meson: change MISC_CLK_SEL_WIDTH to
 MISC_CLK_SEL_MASK
Date: Mon, 27 May 2019 20:00:47 +0200
Message-ID: <20190527180047.nfsjfqs22coyqmvp@pengutronix.de>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
 <20190525181133.4875-5-martin.blumenstingl@googlemail.com>
 <3b61897a-267b-fd6e-181b-a8c7e47918fb@baylibre.com>
 <CAFBinCDXNy4=6U2gsh6vK6WEtJKAdfDGPMrpPJthbp5Rru1hbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFBinCDXNy4=6U2gsh6vK6WEtJKAdfDGPMrpPJthbp5Rru1hbg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Mon, May 27, 2019 at 07:46:43PM +0200, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Mon, May 27, 2019 at 2:26 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >
> > On 25/05/2019 20:11, Martin Blumenstingl wrote:
> > > MISC_CLK_SEL_WIDTH is only used in one place where it's converted into
> > > a bit-mask. Rename and change the macro to be a bit-mask so that
> > > conversion is not needed anymore. No functional changes intended.
> > >
> > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > ---
> > >  drivers/pwm/pwm-meson.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> > > index c62a3ac924d0..84b28ba0f903 100644
> > > --- a/drivers/pwm/pwm-meson.c
> > > +++ b/drivers/pwm/pwm-meson.c
> > > @@ -33,7 +33,7 @@
> > >  #define MISC_A_CLK_DIV_SHIFT 8
> > >  #define MISC_B_CLK_SEL_SHIFT 6
> > >  #define MISC_A_CLK_SEL_SHIFT 4
> > > -#define MISC_CLK_SEL_WIDTH   2
> > > +#define MISC_CLK_SEL_MASK    0x3
> >
> > NIT I would have used GENMASK here
> that was my initial idea but I decided against it.
> the variant I came up with was: #define MISC_CLK_SEL_MASK    GENMASK(1, 0)
> 
> however, the actual offset is either 4 or 6 (depending on the PWM channel)
> and I felt that duplicating the macro would just make it more complicated
> so instead I chose to be consistent with MISC_CLK_DIV_MASK

An option would be:

	#define MISC_CLK_SEL_MASK(hwid)		GENMASK(1 + 4 * (hwid), 0 + 4 * (hwid))

(Note I didn't check a manual to the 4 above is probably wrong.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
