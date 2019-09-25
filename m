From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH] pwm: pwm-imx27: Use 'dev' instead of dereferencing it
 repeatedly
Date: Wed, 25 Sep 2019 02:36:16 +0000
Message-ID: <DB3PR0402MB3916A7A0C79C10B82B304BAAF5870@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1569315593-769-1-git-send-email-Anson.Huang@nxp.com>
 <6cfb1595992b46dc884731555e6f0334@AcuMS.aculab.com>
 <DB3PR0402MB3916FFD66797DAC0AB1110D8F5840@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <37b2481ac9094f27bf21325e2770abdb@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <37b2481ac9094f27bf21325e2770abdb@AcuMS.aculab.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: David Laight <David.Laight@ACULAB.COM>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pwm@vger.kernel.org

Hi, David

> Subject: RE: [PATCH] pwm: pwm-imx27: Use 'dev' instead of dereferencing it
> repeatedly
> 
> From: Anson Huang
> > Sent: 24 September 2019 11:03
> > Hi, David
> >
> > > Subject: RE: [PATCH] pwm: pwm-imx27: Use 'dev' instead of
> > > dereferencing it repeatedly
> > >
> > > From: Anson Huang
> > > > Sent: 24 September 2019 10:00
> > > > Add helper variable dev = &pdev->dev to simply the code.
> > > >
> ...
> > > >  static int pwm_imx27_probe(struct platform_device *pdev)  {
> > > > +	struct device *dev = &pdev->dev;
> > > >  	struct pwm_imx27_chip *imx;
> > > >
> > > > -	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
> > > > +	imx = devm_kzalloc(dev, sizeof(*imx), GFP_KERNEL);
> ...
> > > Hopefully the compiler will optimise this back otherwise you've
> > > added another local variable which may cause spilling to stack.
> > > For a setup function it probably doesn't matter, but in general it
> > > might have a small negative performance impact.
> > >
> > > In any case this doesn't shorten any lines enough to remove
> > > line-wrap and using &pdev->dev is really one less variable to
> > > mentally track when reading the code.
> >
> > Do we know which compiler will optimize this? I saw many of the
> > patches doing this to avoid a lot of dereference, I understand it does
> > NOT save lines, but my intention is to avoid dereference which might save
> some instructions.
> >
> > I thought saving instructions is more important. So now there are
> > different opinion about doing this?
> 
> Remember &pdev->dev is just 'pdev + constant'.
> Assuming 'pdev' is held in a callee saved register (which you want it to be)
> then to access
> dev->foo the compiler can remember the constant and use an offset from
> dev->'pdev' instead of
> an extra 'dev' variable.
> On most modern ABI the first function call arguments are passed in registers.
> So an add  instruction (probably lea) can be used to add the constant offset
> at the same time as the value is moved into the argument register.
> 
> However your extra variable could easily get spilled out to the stack.
> So you get an extra memory read rather than (at most) an extra 'add'
> instruction.
> 
> Even if pdev->dev were a pointer, repeatedly reading it from pdev->dev
> could easily generate better code than having an extra variable that would
> mean the value was repeatedly read from the stack.

Thanks for detail education about it, please ignore these patches.

Thanks,
Anson
