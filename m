From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/5] pwm: tegra: Add DT node compatible for Tegra186
Date: Fri, 24 Jun 2016 11:10:15 -0500
Message-ID: <20160624161015.GA13727@rob-hp-laptop>
References: <1466596043-27262-1-git-send-email-ldewangan@nvidia.com>
 <1466596043-27262-5-git-send-email-ldewangan@nvidia.com>
 <20160622124614.GG26943@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160622124614.GG26943-EkSeR96xj6Pcmrwk2tT4+A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Jun 22, 2016 at 02:46:14PM +0200, Thierry Reding wrote:
> On Wed, Jun 22, 2016 at 05:17:22PM +0530, Laxman Dewangan wrote:
> > Tegra186 has 8 different PWM controller and each controller has only
> > one output. Earlier generation SoCs have the 4 PWM output per controller.
> > 
> > Add DT node compatible for Tegra186.
> > 
> > Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> > index c52f03b..2851b2d 100644
> > --- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> > +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
> > @@ -1,10 +1,12 @@
> >  Tegra SoC PWFM controller
> >  
> >  Required properties:
> > -- compatible: For Tegra20, must contain "nvidia,tegra20-pwm".  For Tegra30,
> > -  must contain "nvidia,tegra30-pwm".  Otherwise, must contain
> > -  "nvidia,<chip>-pwm", plus one of the above, where <chip> is tegra114,
> > -  tegra124, tegra132, or tegra210.
> > +- compatible: For Tegra20, must contain "nvidia,tegra20-pwm".
> > +	      For Tegra30, must contain "nvidia,tegra30-pwm".
> > +	      For Tegra114, Tegra124, Tegra132, Tegra210 must contain
> > +	      "nvidia,<chip>-pwm", plus one of the above, where <chip> is
> > +	      tegra114, tegra124, tegra132, or tegra210.
> > +	      For Tegra186, must contain "nvidia,tegra186-pwm".
> 
> Rob, I recall discussing this with you a couple of weeks ago, but fail
> to remember the outcome and can't find a link to the discussion either.
> Wasn't there a new standard way of documenting this kind of compatible
> string list?

We did? This is fine for me. However, "plus one of the above" is not 
clear. That means either is valid? If all are "the same" I would expect 
that only nvidia,tegra20-pwm is the fallback. I'm guessing this is 
docuemnting what happened in practice though. Probably should update the 
doc and dts files to reflect desired practice rather than what may be in 
the wild.

> Or did you say it didn't matter much until we moved to a YAML-based
> description?

Yes, that sounds like something I would have said.

Rob
