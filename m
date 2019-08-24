From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5 08/13] dt-bindings: pwm: update bindings for MT7628 SoC
Date: Sat, 24 Aug 2019 02:36:58 +0200
Message-ID: <20190824003658.66hisfvhkbkc3pub@pengutronix.de>
References: <1566457123-20791-1-git-send-email-sam.shih@mediatek.com>
 <1566457123-20791-9-git-send-email-sam.shih@mediatek.com>
 <1566461540.16302.4.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1566461540.16302.4.camel@mtksdaap41>
Sender: linux-kernel-owner@vger.kernel.org
To: Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc: Sam Shih <sam.shih@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, Aug 22, 2019 at 04:12:20PM +0800, Yingjoe Chen wrote:
> On Thu, 2019-08-22 at 14:58 +0800, Sam Shih wrote:
> > This updates bindings for MT7628 pwm controller.
> > 
> > Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > index ea95b490a913..93980e3da261 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > @@ -21,6 +21,10 @@ Required properties:
> >     See pinctrl/pinctrl-bindings.txt for details of the property values.
> >   - num-pwms: the number of PWM channels.
> > +
> > + Optional properties:
> > + - clock-frequency: fix clock frequency, this is only used in MT7628 SoC
> > +                    for period calculation. This SoC has no complex clock tree.
> 
> I'm sorry if this has been discussed before. 
> 
> Would it be simpler if you just provide a fixed-clock as clock in device
> tree? This way you don't need this optional properties and don't need to
> special handle it in driver code. 
> 
> After all, the hw is still connected to a simple clock tree.

This is what I just wrote in reply to patch 3 (which implements handling
the clock-frequency property) even before reading your feedback. So I
fully agree.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
