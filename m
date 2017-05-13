From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 4/8] arm64: dts: r8a7796: salvator-x: Add panel backlight support
Date: Sat, 13 May 2017 21:56:12 +0300
Message-ID: <1843896.Iy7IFdxQto@avalon>
References: <1493303863-23719-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1493303863-23719-5-git-send-email-ulrich.hecht+renesas@gmail.com> <1600524.FrhoU262MZ@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1600524.FrhoU262MZ@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: horms@verge.net.au
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, geert@glider.be, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com
List-Id: linux-pwm@vger.kernel.org

Hi Simon,

I'm afraid you added nodes in the wrong places when applying the patch to 
salvator-x.dtsi :-( Please see below.

On Thursday 27 Apr 2017 17:43:56 Laurent Pinchart wrote:
> Hi Ulrich,
> 
> Thank you for the patch.
> 
> On Thursday 27 Apr 2017 16:37:39 Ulrich Hecht wrote:
> > The panel backlight is controlled through a GPIO and a PWM channel.
> > 
> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> > ---
> > 
> >  arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 22 ++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> > b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts index
> > 14d9e51..abda84c
> > 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> > +++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> > @@ -133,6 +133,11 @@
> >  		function = "i2c2";
> >  	};
> > 
> > +	pwm1_pins: pwm {
> > +		groups = "pwm1_a";
> > +		function = "pwm1";
> > +	};
> > +

This is alphabetically ordered here and isn't anymore in your devel branch.

> >  	sdhi0_pins: sd0 {
> >  		groups = "sdhi0_data4", "sdhi0_ctrl";
> >  		function = "sdhi0";
> > @@ -183,6 +188,16 @@
> >  		interrupt-parent = <&gpio2>;
> >  		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> >  	};
> > +
> > +	backlight: backlight {
> > +		compatible = "pwm-backlight";
> > +		pwms = <&pwm1 0 50000>;
> > +
> > +		brightness-levels = <256 128 64 16 8 4 0>;
> > +		default-brightness-level = <6>;
> > +
> > +		enable-gpios = <&gpio6 7 GPIO_ACTIVE_HIGH>;
> > +	};

The backlight node needs to be added as a child of the root node, while you've 
added it to the DU node in your devel branch.

> >  };
> >  
> >  &extal_clk {
> > @@ -235,6 +250,13 @@
> >  	status = "okay";
> >  };
> > 
> > +&pwm1 {
> > +	pinctrl-0 = <&pwm1_pins>;
> > +	pinctrl-names = "default";
> > +
> > +	status = "okay";
> > +};
> > +

This is alphabetically ordered here and isn't anymore in your devel branch.

Can you rebase your devel branch to fix this ?

> >  &scif1 {
> >  	pinctrl-0 = <&scif1_pins>;
> >  	pinctrl-names = "default";

-- 
Regards,

Laurent Pinchart
