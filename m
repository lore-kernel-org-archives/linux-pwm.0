Return-Path: <devicetree-owner@vger.kernel.org>
From: Jingoo Han <jg1.han@samsung.com>
References: <1379869196-19377-1-git-send-email-mikedunn@newsguy.com>
 <5244065A.8010408@ti.com> <20130926115108.GA1680@ulmo>
 <524423B6.4070609@ti.com>
In-reply-to: <524423B6.4070609@ti.com>
Subject: Re: [PATCH v2] pwm-backlight: allow for non-increasing brightness
 levels
Date: Fri, 27 Sep 2013 12:28:21 +0900
Message-id: <017a01cebb31$9df90f60$d9eb2e20$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: devicetree-owner@vger.kernel.org
List-ID: <linux-pwm.vger.kernel.org>
To: 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, 'Thierry Reding' <thierry.reding@gmail.com>
Cc: 'Mike Dunn' <mikedunn@newsguy.com>, 'Richard Purdie' <rpurdie@rpsys.net>, 'Jean-Christophe Plagniol-Villard' <plagnioj@jcrosoft.com>, 'Grant Likely' <grant.likely@linaro.org>, 'Rob Herring' <rob.herring@calxeda.com>, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 'Robert Jarzmik' <robert.jarzmik@free.fr>, 'Marek Vasut' <marex@denx.de>, 'Laurent Pinchart' <laurent.pinchart+renesas@ideasonboard.com>, 'Jingoo Han' <jg1.han@samsung.com>

On Thursday, September 26, 2013 9:08 PM, Tomi Valkeinen wrote:
> On 26/09/13 14:51, Thierry Reding wrote:
> > On Thu, Sep 26, 2013 at 01:03:06PM +0300, Tomi Valkeinen wrote:
> > [...]
> >> But if you and Thierry think this version is good, I'll take it.
> >
> > That sounds like you want to take it through the fbdev tree. Jingoo is
> > listed (along with Richard, but he hasn't been responsive to email for
> > years) as maintainer for the backlight subsystem. Furthermore back at
> 
> Ah, so they are. I just thought it falls under fbdev, as it's under
> drivers/video/ =).
> 
> I don't have any particular "want" to take it through fbdev tree. But I
> can take it.
> 
> > the time when I began working on the PWM subsystem, the backlight sub-
> > system was pretty much orphaned, and pwm-backlight was by far the
> > biggest user of the PWM subsystem. I adopted the driver at the time
> > because it needed to be updated for PWM subsystem changes.
> >
> > What's the plan going forward? Given the coupling between the PWM
> > subsystem and the pwm-backlight driver it might be useful to keep
> > maintaining it as part of the PWM subsystem. On the other hand, there's
> > some coupling between the driver and the backlight subsystem too.
> 
> And backlight is coupled with fbdev... Which is something I don't like.

+cc Laurent Pinchart,

Yes, right. 
The backlight should be de-coupled with fbdev.
I remember that Laurent Pinchart was doing this patch.

Laurent Pinchart,
Would you let us know your plan about this? :-)

> 
> > I have a couple of patches queued up for 3.13 that rework parts of the
> > driver, so it'd be good to know how you guys want to handle this.
> 
> Well. I'm happy if somebody wants to maintain the backlight side. In
> fact, I'd be happy if somebody would start restructuring it totally,
> it's rather messy. The link with fbdev should be removed, and some
> backlight drivers are actually panel drivers. However, perhaps Common
> Display Framework is required until it can be fully cleaned.

I think that some backlight drivers can be moved to 'Common Display Framework',
after 'Common Display Framework' is merged.
But, I am not sure, when it will be completed.

Best regards,
Jingoo Han

> 
> So... For the time being, I'm fine with merging pwm-backlight via any
> tree that works best. I'm presuming here that backlight framework and
> fbdev (for the parts that are relevant for backlight) are not really
> being changed, so there shouldn't be conflicts.
> 
>  Tomi
> 

