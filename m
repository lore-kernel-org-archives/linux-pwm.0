From: "Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCHv3 2/3] pwm: ftm-pwm: Convert to direct regmap API usage.
Date: Mon, 18 Aug 2014 08:45:18 +0000
Message-ID: <222d33a6b1e04e92ba81c28dfcf76394@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1408332755-35102-1-git-send-email-Li.Xiubo@freescale.com>
 <1408332755-35102-3-git-send-email-Li.Xiubo@freescale.com>
 <20140818083648.GC31171@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140818083648.GC31171@ulmo>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

> -----Original Message-----
> From: Thierry Reding [mailto:thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: Monday, August 18, 2014 4:37 PM
> To: Xiubo Li-B47053
> Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; pawel.moll-5wv7dgnIgG8@public.gmane.org;
> rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCHv3 2/3] pwm: ftm-pwm: Convert to direct regmap API usage.
> 
> On Mon, Aug 18, 2014 at 11:32:34AM +0800, Xiubo Li wrote:
> [...]
> > diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
> [...]
> > +static struct regmap_config fsl_pwm_regmap_config = {
> 
> This can be static const, but since it's the only comment I can fix that
> up myself when applying.
> 

That's good, thanks very much.

BRs
Xiubo



> Thierry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
