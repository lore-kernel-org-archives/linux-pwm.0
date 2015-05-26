From: Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/2] pwm: add Mediatek display PWM driver support
Date: Tue, 26 May 2015 16:29:03 +0800
Message-ID: <1432628943.11070.2.camel@mtksdaap41>
References: <1431336382-13167-1-git-send-email-yh.huang@mediatek.com>
 <1431336382-13167-3-git-send-email-yh.huang@mediatek.com>
 <CAGS+omBX1fMBHa-4GLTjQUq5VPR2JRvhJRJ4qBX8hvDF9ihbLA@mail.gmail.com>
 <1432196551.15653.2.camel@mtksdaap41>
 <20150526060533.GW6325@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20150526060533.GW6325-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, 2015-05-26 at 08:05 +0200, Sascha Hauer wrote:
> On Thu, May 21, 2015 at 04:22:31PM +0800, YH Huang wrote:
> > On Mon, 2015-05-18 at 11:42 +0800, Daniel Kurtz wrote:
<...>
> > > On Mon, May 11, 2015 at 5:26 PM, YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > > > +
> > > > +static const struct of_device_id mtk_disp_pwm_of_match[] = {
> > > > +       { .compatible = "mediatek,mt6595-disp-pwm" },
> > > 
> > > Does this driver support the PWM in mt8173?
> > > If so, don't you need this, too:
> > > 
> > >   { .compatible = "mediatek,mt8173-disp-pwm" },
> > 
> > Yes, it supports mt8173.
> > I will add it.
> 
> If both yre compatible you don't need to add it since you have a
> "mediatek,mt6595-disp-pwm" in the mt8173 device tree.

Hi Sascha,

We got a similar discussion about this with Mark Brown for spi driver,
please see:

http://lists.infradead.org/pipermail/linux-mediatek/2015-May/000673.html

Joe.C
