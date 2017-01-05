From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v4 02/11] pwm: imx: remove ipg clock and enable per
 clock when required
Date: Thu, 5 Jan 2017 09:27:03 +0100
Message-ID: <20170105092703.41101426@bbrezillon>
References: <1483573014-13185-1-git-send-email-lukma@denx.de>
        <1483573014-13185-3-git-send-email-lukma@denx.de>
        <20170105081429.32909fe1@bbrezillon>
        <20170105082609.0bd2e884@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170105082609.0bd2e884@jawa>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Stefan Agner <stefan@agner.ch>, linux-pwm@vger.kernel.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>, linux-kernel@vger.kernel.org, Lothar Wassmann <LW@karo-electronics.de>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

On Thu, 5 Jan 2017 08:26:09 +0100
Lukasz Majewski <lukma@denx.de> wrote:

> Hi Boris,
> 
> > On Thu,  5 Jan 2017 00:36:45 +0100
> > Lukasz Majewski <lukma@denx.de> wrote:
> >   
> > > From: Boris Brezillon <boris.brezillon@free-electrons.com>  
> > 
> > Can you keep Sascha as the author of this patch?  
> 
> But the patch differs from the original one - and that change was sent
> by you - so I assume that you made the modifications.
> 
> Apparently there are two authors and we only have one "Author"
> field :-) so I took the patch as it was sent by you.

Well, when the changes are substantial it can be justified, but here
the changes are trivial (2 lines changed), and I don't think it calls
for an authorship change (unless Sascha doesn't want to take the
responsibility for those 2 lines).

> 
> Is the rest of the series correct?

I'll have a look.

> 
> Best regards,
> Łukasz Majewski
> 
> >   
> > > 
> > > The use of the ipg clock was introduced with commit 7b27c160c681
> > > ("pwm: i.MX: fix clock lookup").
> > > In the commit message it was claimed that the ipg clock is enabled
> > > for register accesses. This is true for the ->config() callback,
> > > but not for the ->set_enable() callback. Given that the ipg clock
> > > is not consistently enabled for all register accesses we can assume
> > > that either it is not required at all or that the current code does
> > > not work. Remove the ipg clock code for now so that it's no longer
> > > in the way of refactoring the driver.
> > > 
> > > In the other hand, the imx7 IP requires the peripheral clock to be
> > > enabled before accessing its registers. Since ->config() can be
> > > called when the PWM is disabled (in which case, the peripheral
> > > clock is also disabled), we need to surround the imx->config() with
> > > clk_prepare_enable(per_clk)/clk_disable_unprepare(per_clk) calls.
> > > 
> > > Note that the imx7 IP was working fine so far because the ipg clock
> > > was actually pointing to the peripheral clock, which guaranteed
> > > peripheral clock activation even when ->config() was called when
> > > the PWM was disabled.
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > > ---
> > > Changes in v4:
> > > - Enable per clk before calling imx->config()
> > > 
> > > Changes in v3:
> > > - New patch
> > > ---
> > >  drivers/pwm/pwm-imx.c | 12 ++----------
> > >  1 file changed, 2 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> > > index d600fd5..b1d1e50 100644
> > > --- a/drivers/pwm/pwm-imx.c
> > > +++ b/drivers/pwm/pwm-imx.c
> > > @@ -49,7 +49,6 @@
> > >  
> > >  struct imx_chip {
> > >  	struct clk	*clk_per;
> > > -	struct clk	*clk_ipg;
> > >  
> > >  	void __iomem	*mmio_base;
> > >  
> > > @@ -206,13 +205,13 @@ static int imx_pwm_config(struct pwm_chip
> > > *chip, struct imx_chip *imx = to_imx_chip(chip);
> > >  	int ret;
> > >  
> > > -	ret = clk_prepare_enable(imx->clk_ipg);
> > > +	ret = clk_prepare_enable(imx->clk_per);
> > >  	if (ret)
> > >  		return ret;
> > >  
> > >  	ret = imx->config(chip, pwm, duty_ns, period_ns);
> > >  
> > > -	clk_disable_unprepare(imx->clk_ipg);
> > > +	clk_disable_unprepare(imx->clk_per);
> > >  
> > >  	return ret;
> > >  }
> > > @@ -293,13 +292,6 @@ static int imx_pwm_probe(struct
> > > platform_device *pdev) return PTR_ERR(imx->clk_per);
> > >  	}
> > >  
> > > -	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
> > > -	if (IS_ERR(imx->clk_ipg)) {
> > > -		dev_err(&pdev->dev, "getting ipg clock failed with
> > > %ld\n",
> > > -				PTR_ERR(imx->clk_ipg));
> > > -		return PTR_ERR(imx->clk_ipg);
> > > -	}
> > > -
> > >  	imx->chip.ops = &imx_pwm_ops;
> > >  	imx->chip.dev = &pdev->dev;
> > >  	imx->chip.base = -1;  
> >   
> 
> 
> 
> 
> Best regards,
> 
> Lukasz Majewski
> 
> --
> 
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
