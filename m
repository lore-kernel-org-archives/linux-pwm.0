From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 2/3] pwm: renesas-tpu: Fix late Runtime PM enablement
Date: Mon, 16 Mar 2020 18:11:46 +0200
Message-ID: <20200316161146.GQ4732@pendragon.ideasonboard.com>
References: <20200316103216.29383-1-geert+renesas@glider.be>
 <20200316103216.29383-3-geert+renesas@glider.be>
 <20200316160108.qylpoglfhhqvqqwt@pengutronix.de>
 <CAMuHMdXP=QpOTpr8Ave0jvJ_KPPK5_R=_2F5JDNR7zvQk3W5PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXP=QpOTpr8Ave0jvJ_KPPK5_R=_2F5JDNR7zvQk3W5PQ@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <thierry.reding@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi Geert,

On Mon, Mar 16, 2020 at 05:06:12PM +0100, Geert Uytterhoeven wrote:
> On Mon, Mar 16, 2020 at 5:01 PM Uwe Kleine-König wrote:
> > On Mon, Mar 16, 2020 at 11:32:15AM +0100, Geert Uytterhoeven wrote:
> > > Runtime PM should be enabled before calling pwmchip_add(), as PWM users
> > > can appear immediately after the PWM chip has been added.
> > > Likewise, Runtime PM should always be disabled after the removal of the
> > > PWM chip, even if the latter failed.
> > >
> > > Fixes: 99b82abb0a35b073 ("pwm: Add Renesas TPU PWM driver")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > >  drivers/pwm/pwm-renesas-tpu.c | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
> > > index 4a855a21b782dea3..8032acc84161a9dd 100644
> > > --- a/drivers/pwm/pwm-renesas-tpu.c
> > > +++ b/drivers/pwm/pwm-renesas-tpu.c
> > > @@ -415,16 +415,17 @@ static int tpu_probe(struct platform_device *pdev)
> > >       tpu->chip.base = -1;
> > >       tpu->chip.npwm = TPU_CHANNEL_MAX;
> > >
> > > +     pm_runtime_enable(&pdev->dev);
> > > +
> > >       ret = pwmchip_add(&tpu->chip);
> > >       if (ret < 0) {
> > >               dev_err(&pdev->dev, "failed to register PWM chip\n");
> > > +             pm_runtime_disable(&pdev->dev);
> > >               return ret;
> > >       }
> > >
> > >       dev_info(&pdev->dev, "TPU PWM %d registered\n", tpu->pdev->id);
> > >
> > > -     pm_runtime_enable(&pdev->dev);
> > > -
> > >       return 0;
> > >  }
> > >
> > > @@ -434,12 +435,10 @@ static int tpu_remove(struct platform_device *pdev)
> > >       int ret;
> > >
> > >       ret = pwmchip_remove(&tpu->chip);
> > > -     if (ret)
> > > -             return ret;
> > >
> > >       pm_runtime_disable(&pdev->dev);
> > >
> > > -     return 0;
> > > +     return ret;
> > >  }
> >
> > Maybe I was a bit quick with my reply to the previous patch. I wonder if
> > it is right to call pm_runtime_disable if pwmchip_remove failed?
> 
> While the pwmchip may still exist, the hardware is unmapped and no
> longer accessible.

Is it the case on module unload, doesn't a .remove() failure prevent the
module from being unloaded, and keeps the device associated with the
driver ? I haven't actually checked myself.

-- 
Regards,

Laurent Pinchart
