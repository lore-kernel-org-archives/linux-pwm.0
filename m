From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3] backlight: pwm_bl: Fix brightness levels for non-DT
 case.
Date: Mon, 3 Dec 2018 07:07:39 +0000
Message-ID: <20181203070739.GK6009@dell>
References: <20181107085507.26126-1-enric.balletbo@collabora.com>
 <CAFqH_53NiYULqcc+2fCgbHETJoTc7tWD8BNxOFhPm6kFZ=e6_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFqH_53NiYULqcc+2fCgbHETJoTc7tWD8BNxOFhPm6kFZ=e6_g@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-kernel <linux-kernel@vger.kernel.org>, robert.jarzmik@free.fr, Daniel Thompson <daniel.thompson@linaro.org>, kernel@collabora.com, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, stable@vger.kernel.org, u.kleine-koenig@pengutronix.de, Linux PWM List <linux-pwm@vger.kernel.org>, linux-fbdev@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel <dri-devel@lists.freedesktop.org>, Jingoo Han <jingoohan1@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Fri, 30 Nov 2018, Enric Balletbo Serra wrote:

> Hi,
> Missatge de Enric Balletbo i Serra <enric.balletbo@collabora.com> del
> dia dc., 7 de nov. 2018 a les 9:56:
> >
> > Commit '88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED
> > linearly to human eye")' allows the possibility to compute a default
> > brightness table when there isn't the brightness-levels property in the
> > DT. Unfortunately the changes made broke the pwm backlight for the
> > non-DT boards.
> >
> > Usually, the non-DT boards don't pass the brightness levels via platform
> > data, instead, it sets the max_brightness in their platform data and the
> > driver calculates the level without a table. The offending patch assumed
> > that when there is no brightness levels table we should create one, but this
> > is clearly wrong for the non-DT case.
> >
> > After this patch the code handles the DT and the non-DT case taking in
> > consideration also if max_brightness is set or not.
> >
> > Fixes: 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")
> > Cc: <stable@vger.kernel.org>
> > Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> > ---
> >
> > Changes in v3:
> > - Fixed some typos in commit message.
> > - Removed ' in Fixes tag.
> >
> > Changes in v2:
> > - Rebase on top of mainline
> > - Add Tested-by and Acked-by tags.
> >
> >  drivers/video/backlight/pwm_bl.c | 41 +++++++++++++++++++++++++++-----
> >  1 file changed, 35 insertions(+), 6 deletions(-)

[...]

> A gentle ping on this patch.

Don't do that.

If you think that it's been forgotten, send it again as a [RESEND].

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
