From: Jerome Brunet <jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 0/3] pwm: add pwm AO on meson gx
Date: Thu, 06 Jul 2017 11:02:20 +0200
Message-ID: <1499331740.15362.11.camel@baylibre.com>
References: <20170608122416.1993-1-jbrunet@baylibre.com>
         <20170706065910.GJ16144@ulmo.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170706065910.GJ16144-m5CkvRiFyV9wFLYp8hBm2A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Thu, 2017-07-06 at 08:59 +0200, Thierry Reding wrote:
> On Thu, Jun 08, 2017 at 02:24:13PM +0200, Jerome Brunet wrote:
> > The pwms found in the AO domain of the meson gx family have different
> > clock sources than the ones found in the EE domain. The AO pwms only
> > have 2 connected clock input which are clk81 and the crytal.
> > 
> > This patchset adds the necessary compatible and the clock data for it.
> > 
> > Changes since v1: [0]
> > * Correct clock source order for gxbb pwm ao. Documenation shows xtal as
> >   source #1 while it is actually source #0
> > * Add patch 3 to fix pwm calculation. Issue while testing pwm with clk81
> >   as clock source.
> > 
> > [0]:  https://lkml.kernel.org/r/20170607133013.4766-1-jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
> > 
> > Jerome Brunet (3):
> >   dt-bindings: pwm: meson: add comptabible for gxbb ao pwms
> >   pwm: meson: add compatible for the gxbb ao pwms
> >   pwm: meson: improve pwm calculation precision.
> > 
> >  .../devicetree/bindings/pwm/pwm-meson.txt          |  4 +-
> >  drivers/pwm/pwm-meson.c                            | 47 +++++++++++++++++
> > -----
> >  2 files changed, 41 insertions(+), 10 deletions(-)
> 
> For some reason the Author field keeps getting set to:
> 
> 	jbrunet <jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> 
> It seems like the headers are correct, so maybe this is patchwork
> messing things up?

And it strikes again ... :(
I already had the issue with https://patchwork.kernel.org a few month ago.
I have contacted the kernel.org helpdesk about it and here is the explanation:

"Patchwork treats users and patch submitters slightly differently, so once your
entry is created upon first patch submission, it sticks forever. I've adjusted
your entry manually per your request."

So my very first patch on the ML must have been malformed somehow.

> 
> Anyway, I've applied the series and manually fixed up the Author field.

Thanks a lot for this ! 
Any idea who I may contact to get this "manual adjustment" done on https://patch
work.ozlabs.org/ ?


> 
> Thanks,
> Thierry

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
