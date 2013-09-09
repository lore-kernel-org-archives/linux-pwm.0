Return-Path: <sha@pengutronix.de>
Date: Mon, 9 Sep 2013 17:03:46 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCHv3 1/4] pwm: Add Freescale FTM PWM driver support
Message-ID: <20130909150346.GV30088@pengutronix.de>
References: <1378454907-22728-1-git-send-email-Li.Xiubo@freescale.com>
 <1378454907-22728-2-git-send-email-Li.Xiubo@freescale.com>
 <20130909122008.GC22197@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130909122008.GC22197@ulmo>
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Xiubo Li <Li.Xiubo@freescale.com>, r65073@freescale.com, grant.likely@linaro.org, linux@arm.linux.org.uk, rob@landley.net, ian.campbell@citrix.com, swarren@wwwdotorg.org, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jingchang Lu <b35083@freescale.com>

On Mon, Sep 09, 2013 at 02:20:09PM +0200, Thierry Reding wrote:
> On Fri, Sep 06, 2013 at 04:08:24PM +0800, Xiubo Li wrote:
> > The FTM PWM device can be found on Vybrid VF610 Tower and Layerscape LS-1 SoCs.
> > 
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > Signed-off-by: Jingchang Lu <b35083@freescale.com>
> > ---
> >  drivers/pwm/Kconfig       |  10 +
> >  drivers/pwm/Makefile      |   1 +
> >  drivers/pwm/pwm-fsl-ftm.c | 505 ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 516 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-fsl-ftm.c
> 
> This looks pretty good to me. I noticed that you didn't Cc Sascha who
> commented on this a lot. Can you please resend with him Cc'ed to make
> sure he sees this version of the series?

I'm already aware of this, no need to resend. I'll have a look over it
tomorrow.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
