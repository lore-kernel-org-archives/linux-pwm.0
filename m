From: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [RESEND PATCH] pwm-backlight: fix the panel power sequence
Date: Fri, 16 Oct 2015 16:50:37 +0800
Message-ID: <1444985437.18373.3.camel@mtksdaap41>
References: <1444959454-1516-1-git-send-email-yh.huang@mediatek.com>
 <20151016083616.GA7858@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20151016083616.GA7858-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Fri, 2015-10-16 at 10:36 +0200, Sascha Hauer wrote:
> On Fri, Oct 16, 2015 at 09:37:34AM +0800, YH Huang wrote:
> > In order to match the panel power sequence, disable the enable_gpio
> > in the probe function. Also, reorder the code in the power_on and
> > power_off function to match the timing.
> > @@ -241,8 +242,7 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> >  	pb->dev = &pdev->dev;
> >  	pb->enabled = false;
> >  
> > -	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
> > -						  GPIOD_OUT_HIGH);
> > +	pb->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable");
> 
> Please actually test your patches. This change here won't compile.
> 
> Sascha
> 

I will send patch v2 to fix it.

YH Huang
