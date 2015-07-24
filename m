From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: pwm: add MediaTek display PWM bindings
Date: Fri, 24 Jul 2015 14:56:47 +0200
Message-ID: <10346793.XDV1BVipfn@ubix>
References: <1437380237-28961-1-git-send-email-yh.huang@mediatek.com> <8769951.Y5Edyg2WDJ@ubix> <CAGS+omAzhfCAoGArK8XUMhNFuqiErPcvGh0q=+Se1dHeBnJyUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGS+omAzhfCAoGArK8XUMhNFuqiErPcvGh0q=+Se1dHeBnJyUg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "open list:OPEN FIRMWARE AND..." <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Yingjoe Chen <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Friday, July 24, 2015 05:00:13 PM Daniel Kurtz wrote:
> On Fri, Jul 24, 2015 at 4:40 PM, Matthias Brugger
> 
> <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On Monday, July 20, 2015 04:17:15 PM YH Huang wrote:
> >> Document the device-tree binding of MediatTek display PWM.
> >> The PWM has one channel to control the backlight brightness for display.
> >> It supports MT8173 and MT6595.
> >> 
> >> Signed-off-by: YH Huang <yh.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> >> ---
> >> 
> >>  .../devicetree/bindings/pwm/pwm-mtk-disp.txt       | 42
> >> 
> >> ++++++++++++++++++++++ 1 file changed, 42 insertions(+)
> >> 
> >>  create mode 100644
> >>  Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> >> 
> >> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> >> b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt new file mode
> >> 100644
> >> index 0000000..f8f59ba
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
> >> @@ -0,0 +1,42 @@
> >> +MediaTek display PWM controller
> >> +
> >> +Required properties:
> >> + - compatible: should be "mediatek,<name>-disp-pwm":
> >> +   - "mediatek,mt8173-disp-pwm": found on mt8173 SoC.
> >> +   - "mediatek,mt6595-disp-pwm": found on mt6595 SoC.
> > 
> > I had another look on the mt6589 datasheet and for me it doesn't look like
> > as if this drivers is compatible to mt6589.
> 
> Matthias - the compatible is "mt6595", not mt6589 :-).
> Which datasheet did you check?
> 

In further versions the driver stated it support mt6589, so I didn' realize 
that it is mt6595 now. Logically I checked mt6589 datasheet... :(

Sorry for the noise!
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
