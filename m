Return-Path: <B47053@freescale.com>
From: Xiubo Li-B47053 <B47053@freescale.com>
Subject: RE: [PATCHv3 1/4] pwm: Add Freescale FTM PWM driver support
Date: Tue, 10 Sep 2013 08:12:07 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8281470E@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1378454907-22728-1-git-send-email-Li.Xiubo@freescale.com>
 <1378454907-22728-2-git-send-email-Li.Xiubo@freescale.com>
 <20130910065146.GA30088@pengutronix.de>
In-Reply-To: <20130910065146.GA30088@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: B47053@freescale.com
List-ID: <linux-pwm.vger.kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Guo Shawn-R65073 <r65073@freescale.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Lu Jingchang-B35083 <B35083@freescale.com>

> Subject: Re: [PATCHv3 1/4] pwm: Add Freescale FTM PWM driver support
>=20
> On Fri, Sep 06, 2013 at 04:08:24PM +0800, Xiubo Li wrote:
> > The FTM PWM device can be found on Vybrid VF610 Tower and Layerscape
> LS-1 SoCs.
> >
> > +
> > +static int fsl_pwm_probe(struct platform_device *pdev) {
> > +	int ret =3D 0;
> > +	struct fsl_pwm_chip *fpc;
> > +	struct resource *res;
> > +
> > +	fpc =3D devm_kzalloc(&pdev->dev, sizeof(*fpc), GFP_KERNEL);
>=20
> You don't have to output a message when kzalloc fails, but still you
> should check for the result and return an error if necessary.
>=20
Okey, I will.

--
Xiubo
