From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCHv3 0/3] ftm-pwm: Convert to direct regmap API usage
Date: Mon, 18 Aug 2014 08:55:40 +0000
Message-ID: <3aee225156664fdbaa3642a8a94e7427@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1408332755-35102-1-git-send-email-Li.Xiubo@freescale.com>
 <20140818083134.GB31171@ulmo>
 <d8843f498fa64ea9b45fc04e9bb5589d@BY2PR0301MB0613.namprd03.prod.outlook.com>
 <20140818084911.GD31171@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140818084911.GD31171@ulmo>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "rdunlap@infradead.org" <rdunlap@infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

> -----Original Message-----
> From: Thierry Reding [mailto:thierry.reding@gmail.com]
> Sent: Monday, August 18, 2014 4:49 PM
> To: Xiubo Li-B47053
> Cc: linux-pwm@vger.kernel.org; robh+dt@kernel.org; pawel.moll@arm.com;
> rdunlap@infradead.org; devicetree@vger.kernel.org; linux-doc@vger.kernel.org
> Subject: Re: [PATCHv3 0/3] ftm-pwm: Convert to direct regmap API usage
> 
> On Mon, Aug 18, 2014 at 08:43:56AM +0000, Li.Xiubo@freescale.com wrote:
> > > -----Original Message-----
> > > From: Thierry Reding [mailto:thierry.reding@gmail.com]
> > > Sent: Monday, August 18, 2014 4:32 PM
> > > To: Xiubo Li-B47053
> > > Cc: linux-pwm@vger.kernel.org; robh+dt@kernel.org; pawel.moll@arm.com;
> > > rdunlap@infradead.org; devicetree@vger.kernel.org; linux-
> doc@vger.kernel.org
> > > Subject: Re: [PATCHv3 0/3] ftm-pwm: Convert to direct regmap API usage
> > >
> > > On Mon, Aug 18, 2014 at 11:32:32AM +0800, Xiubo Li wrote:
> > > >
> > > > This is depended on the following patches, which has been applied by
> > > > Mark into his Regmap-Tree:
> > > > https://lkml.org/lkml/2014/7/15/6
> > > > https://lkml.org/lkml/2014/7/15/5
> > > > https://lkml.org/lkml/2014/7/15/7
> > >
> > > This doesn't seem to have any build dependencies on the above patches.
> >
> > Yes, you are right.
> >
> >
> > > So with only this applied to the PWM tree at worst the registers will be
> > > accessed in the wrong endianess and the PWM won't work as expected. Does
> > > that matter?
> >
> > No, I think it's okay, we'll only test our drivers in the Linus's stable
> branch.
> >
> >
> >
> > > Or should I request a stable branch from Mark to pull into
> > > the PWM tree so that this doesn't happen?
> > >
> > > In linux-next things should be fine since both branches will be merged.
> > > I guess there could still be an issue depending on the order in which
> > > Linus merges the trees for 3.18, in which case there could be a brief
> > > period where Linus' tree runtime-breaks on platforms requiring this. But
> > > I'm not sure if that's really an issue.
> > >
> >
> > The depended patches has been merged into the Linux-next tree just now
> already
> > today.
> >
> > And then could we guarantee that these ftm-pwm patches to be in order after
> the
> > depended ones ?
> 
> I could merge Mark's regmap tree into the PWM tree to guarantee that.
> I'm just wondering if it's worth the trouble since there's no compile-
> time dependency so the issue will only show up when running a kernel
> built directly from the PWM tree (or some tree that has the PWM tree
> merged but not regmap). And even then it will only happen if there's a
> device tree for a device that requires special endianess handling.
> 
> But it's really your call. If you think it's safer to merge them in the
> correct order then I'll ask Mark for a stable regmap branch that I can
> pull.
> 

I think it okay, since the LS1 platform driver patches are still in process,
and only in LS1 SoC will depend this.

You can just merge this to PWM tree if everything is okay.

Thanks,

BRs
Xiubo



> Thierry
