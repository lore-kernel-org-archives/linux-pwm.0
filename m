From: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [RESEND PATCH v5 2/5] dt-bindings: pwm-backlight: add PWM delay
 proprieties.
Date: Mon, 19 Feb 2018 10:56:04 +0100
Message-ID: <4692672.MjQUXlf6O3@phil>
References: <20180216174034.15936-1-enric.balletbo@collabora.com>
 <20180216174034.15936-2-enric.balletbo@collabora.com>
 <20180219092247.estv4d2v6cbopx6z@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20180219092247.estv4d2v6cbopx6z@dell>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jacek Anaszewski <jacek.anaszewski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, kernel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

Hi Lee,

Am Montag, 19. Februar 2018, 10:22:47 CET schrieb Lee Jones:
> On Fri, 16 Feb 2018, Enric Balletbo i Serra wrote:
> 
> > Hardware needs a delay between setting an initial (non-zero) PWM and
> > enabling the backlight using GPIO. The post-pwm-on-delay-ms specifies
> > this delay in milli seconds. Hardware also needs a delay between disabing
> > the backlight using GPIO and setting PWM value to 0. The pwm-off-delay-ms
> > is this delay in milli seconds.
> > 
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> > Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> > ---
> > Based on the original Huang Lin <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org> work.
> > 
> > Changes since v4:
> >  - Rebase on top of mainline.
> > Changes since v3:
> >  - Replace us for ms.
> >  - Add Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> > Changes since v2:
> >  - Use separate properties (Rob Herring)
> > Changes since v1:
> >  - As suggested by Daniel Thompson
> >    - Do not assume power-on delay and power-off delay will be the same
> > 
> >  Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> Looks like this still needs an Ack.
> 
> Also, you didn't supply a 0th (cover-letter) patch, so I have no idea
> of patch history or your future intentions.
> 
> Are there build-time dependencies between them or can each patch be
> merged via their respective trees without the fear of merge/build
> failure?

When looking at the patches, there do not seem to be any build-time
dependencies between the patch 1-3 (backlight) and 4+5 devicetree,
so after Rob hopefully has time to look at the binding change, I'd suspect
you take the code changes and I'll take the dts changes.


Heiko
