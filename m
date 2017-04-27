From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 6/8] arm64: dts: r8a7795: salvator-x: Add panel backlight support
Date: Thu, 27 Apr 2017 17:43:35 +0300
Message-ID: <5380113.rA7rrcbnKf@avalon>
References: <1493303863-23719-1-git-send-email-ulrich.hecht+renesas@gmail.com> <1493303863-23719-7-git-send-email-ulrich.hecht+renesas@gmail.com> <2942315.eI4rjftHNO@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <2942315.eI4rjftHNO@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: geert@glider.be, horms@verge.net.au, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
List-Id: linux-pwm@vger.kernel.org

On Thursday 27 Apr 2017 17:42:53 Laurent Pinchart wrote:
> On Thursday 27 Apr 2017 16:37:41 Ulrich Hecht wrote:
> > From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > The panel backlight is controlled through a GPIO and a PWM channel.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Please ignore this, I meant to reply to the M3-W patch.

> 
> > ---
> > 
> >  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 22 +++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> > b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts index
> > bf4674e..8558b27
> > 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> > +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> > @@ -280,6 +280,16 @@
> > 
> >  			};
> >  		
> >  		};
> >  	
> >  	};
> > 
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
> > 
> >  };
> >  
> >  &du {
> > 
> > @@ -366,6 +376,11 @@
> > 
> >  		function = "du";
> >  	
> >  	};
> > 
> > +	pwm1_pins: pwm {
> > +		groups = "pwm1_a";
> > +		function = "pwm1";
> > +	};
> > +
> > 
> >  	sdhi0_pins: sd0 {
> >  	
> >  		groups = "sdhi0_data4", "sdhi0_ctrl";
> >  		function = "sdhi0";
> > 
> > @@ -441,6 +456,13 @@
> > 
> >  	};
> >  
> >  };
> > 
> > +&pwm1 {
> > +	pinctrl-0 = <&pwm1_pins>;
> > +	pinctrl-names = "default";
> > +
> > +	status = "okay";
> > +};
> > +
> > 
> >  &scif1 {
> >  
> >  	pinctrl-0 = <&scif1_pins>;
> >  	pinctrl-names = "default";

-- 
Regards,

Laurent Pinchart
