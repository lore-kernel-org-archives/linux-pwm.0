From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv8 RFC] pwm: Add Freescale FTM PWM driver support
Date: Mon, 6 Jan 2014 05:25:32 +0000
Message-ID: <0773adbc0c0f4406ab6df6480d4aef51@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1388726661-3391-1-git-send-email-Li.Xiubo@freescale.com>
 <20140103074511.GA10680@core.coreip.homeip.net>
 <f9527d65aa234f40af2830d9fb139bbb@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140103230826.GB13489@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140103230826.GB13489@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "bpringlemeir@nbsps.com" <bpringlemeir@nbsps.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Huan Wang <Huan.Wang@freescale.com>, Jingchang Lu <jingchang.lu@freescale.com>
List-Id: linux-pwm@vger.kernel.org

> > > > +static inline int fsl_pwm_calculate_default_ps(struct fsl_pwm_chip *fpc,
> > > > +					       enum fsl_pwm_clk index)
> > > > +{
> > >
> > > Why do you declare this (and other module-local) function as inline?
> > > It is usually better let compiler decide if given function should be
> > > inlined or not.
> > >
> >
> > Could the compiler know when the given function should be inlined by
> > not declare it?
> 
> Yes.
> 
> > And when will be inlined ?
> 
> When it makes sense to do so from compiler's point of view: i.e. it is
> smallish or with single call site and there are enough registers, etc,
> etc.
>

Well, the inline is not very useful here, I will revise this.


Thanks,

--
Best Regards,
Xiubo
