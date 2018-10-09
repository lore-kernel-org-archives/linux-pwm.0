From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3] backlight: pwm_bl: switch to using "atomic" PWM API
Date: Mon, 8 Oct 2018 23:04:40 -0700
Message-ID: <20181009060440.GB4324@dell>
References: <20180814165059.13219-1-enric.balletbo@collabora.com>
 <20180910144924.GU28860@dell>
 <2092357.WrANtTvkTV@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2092357.WrANtTvkTV@phil>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pwm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, kernel@collabora.com, cl@rock-chips.com
List-Id: linux-pwm@vger.kernel.org

On Fri, 28 Sep 2018, Heiko Stuebner wrote:

> Hi Lee,
> 
> Am Montag, 10. September 2018, 16:49:24 CEST schrieb Lee Jones:
> > On Tue, 14 Aug 2018, Enric Balletbo i Serra wrote:
> > 
> > > The "atomic" API allows us to configure PWM period and duty_cycle and
> > > enable it in one call.
> > > 
> > > The patch also moves the pwm_init_state just before any use of the
> > > pwm_state struct, this fixes a potential bug where pwm_get_state
> > > can be called before pwm_init_state.
> > > 
> > > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > ---
> > > 
> > > Changes in v3:
> > > - Get rid of duty_cycle variable from pwm_backlight_update_status.
> > > - Get rid of pb->enabled and use only the status.enabled variable.
> > > - Make power_on match power_off.
> > > - Do not share status between ...update_status and ...power_on
> > > 
> > > Changes in v2:
> > > - Do not force the PWM be off in the first call to pwm_apply_state.
> > > - Delayed applying the state until we know what the period is.
> > > - Removed pb->period as after the conversion is not needed.
> > > 
> > >  drivers/video/backlight/pwm_bl.c | 81 +++++++++++++++++---------------
> > >  1 file changed, 42 insertions(+), 39 deletions(-)
> > 
> > Applied, thanks.
> 
> did this miss some push or so, because looking at [0], I don't see
> any new patches for a while now?

Yes.  It has been applied locally for a while though, so don't worry.

> [0] https://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git/

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
