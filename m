From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH v2 2/2] pwm: Add support for R-Car PWM Timer
Date: Wed, 20 May 2015 02:36:19 +0000
Message-ID: <SG2PR06MB0919BB8E4B4BD700760CCD30D8C20@SG2PR06MB0919.apcprd06.prod.outlook.com>
References: <1432032159-704-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1432032159-704-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <87d21w3yio.wl%kuninori.morimoto.gx@renesas.com>
 <SG2PR06MB09195F94EAFBAA73AD19F260D8C20@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <20150520020656.GA31103@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150520020656.GA31103@verge.net.au>
Content-Language: ja-JP
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hi Simon-san,

> Sent: Wednesday, May 20, 2015 11:07 AM
> 
> On Wed, May 20, 2015 at 01:24:32AM +0000, Yoshihiro Shimoda wrote:
> > Hi Morimoto-san,
> >
> > > Sent: Wednesday, May 20, 2015 9:06 AM
> > >
> > > Hi Shimoda-san
> > >
> > > I guess previous Geert's opinion about compatible is...
> > >
> > > > +Required Properties:
> > > > +- compatible: should be one of the following.
> > > > + - "renesas,pwm-r8a7778": for R-Car M1A
> > > > + - "renesas,pwm-r8a7779": for R-Car H1
> > > > + - "renesas,pwm-r8a7790": for R-Car H2
> > > > + - "renesas,pwm-r8a7791": for R-Car M2-W
> > > > + - "renesas,pwm-r8a7794": for R-Car E2
> > > (snip)
> > > > +static const struct of_device_id rcar_pwm_of_table[] = {
> > > > +	{ .compatible = "renesas,pwm-r8a7778", },
> > > > +	{ .compatible = "renesas,pwm-r8a7779", },
> > > > +	{ .compatible = "renesas,pwm-r8a7790", },
> > > > +	{ .compatible = "renesas,pwm-r8a7791", },
> > > > +	{ .compatible = "renesas,pwm-r8a7794", },
> > > > +	{ },
> > > > +};
> > >
> > > - compatible: should be one of the following.
> > >  - "renesas,pwm-rcar": for R-Car  <=
> > >  ... /* we need gen1 / gen2 here ? */
> > >  - "renesas,pwm-r8a7778": for R-Car M1A
> > >  - "renesas,pwm-r8a7779": for R-Car H1
> > >  - "renesas,pwm-r8a7790": for R-Car H2
> > >  - "renesas,pwm-r8a7791": for R-Car M2-W
> > >  - "renesas,pwm-r8a7794": for R-Car E2
> > >
> > > static const struct of_device_id rcar_pwm_of_table[] = {
> > > 	{ .compatible = "renesas,pwm-rcar", }, <=
> > > 	{ },
> >
> > Thank you for your comment.
> > I understood it. If such a document and code, there is similar with the sh-sci driver.
> > So, I will fix this patch set.
> 
> Does the documentation (e.g. datasheet) indicate that the PWM blocks are
> the same for at least all of the R-Car SoCs that we know about?

The R-Car Gen2 documentation indicates that the PWM block are the same as R-Car [HME]2.

However, Gen2 documentation doesn't indicate whether the PWM block are the same as R-Car H1 and M1A.
(but, I compared documentation of R-Car H1 and M1A, and then I assumed these are the same as Gen2.)

Best regards,
Yoshihiro Shimoda

