Return-Path: <B47053@freescale.com>
From: Xiubo Li-B47053 <B47053@freescale.com>
Subject: RE: [PATCHv3 1/4] pwm: Add Freescale FTM PWM driver support
Date: Tue, 10 Sep 2013 02:35:34 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828135D9@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1378454907-22728-1-git-send-email-Li.Xiubo@freescale.com>
 <1378454907-22728-2-git-send-email-Li.Xiubo@freescale.com>
 <20130909122008.GC22197@ulmo> <20130909150346.GV30088@pengutronix.de>
In-Reply-To: <20130909150346.GV30088@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: B47053@freescale.com
List-ID: <linux-pwm.vger.kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>
Cc: Guo Shawn-R65073 <r65073@freescale.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rob@landley.net" <rob@landley.net>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Lu Jingchang-B35083 <B35083@freescale.com>

> Subject: Re: [PATCHv3 1/4] pwm: Add Freescale FTM PWM driver support
>=20
> On Mon, Sep 09, 2013 at 02:20:09PM +0200, Thierry Reding wrote:
> > On Fri, Sep 06, 2013 at 04:08:24PM +0800, Xiubo Li wrote:
> > > The FTM PWM device can be found on Vybrid VF610 Tower and Layerscape
> LS-1 SoCs.
> > >
> > > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > > Signed-off-by: Jingchang Lu <b35083@freescale.com>
> > > ---
> > >  drivers/pwm/Kconfig       |  10 +
> > >  drivers/pwm/Makefile      |   1 +
> > >  drivers/pwm/pwm-fsl-ftm.c | 505
> > > ++++++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 516 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-fsl-ftm.c
> >
> > This looks pretty good to me. I noticed that you didn't Cc Sascha who
> > commented on this a lot. Can you please resend with him Cc'ed to make
> > sure he sees this version of the series?
>=20
> I'm already aware of this, no need to resend. I'll have a look over it
> tomorrow.
>=20

I'm very sorry, next time I will.


Thanks very much.

--
Best Regards,
Xiubo
