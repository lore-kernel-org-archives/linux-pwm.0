From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 4/8] arm64: dts: r8a7796: salvator-x: Add panel
 backlight support
Date: Mon, 15 May 2017 08:59:25 +0200
Message-ID: <20170515065925.GH16545@verge.net.au>
References: <1493303863-23719-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1843896.Iy7IFdxQto@avalon>
 <20170515054810.GC16545@verge.net.au>
 <1725785.Sq2YCP3naq@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1725785.Sq2YCP3naq@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, geert@glider.be, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com
List-Id: linux-pwm@vger.kernel.org

On Mon, May 15, 2017 at 09:50:39AM +0300, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Monday 15 May 2017 07:48:11 Simon Horman wrote:
> > On Sat, May 13, 2017 at 09:56:12PM +0300, Laurent Pinchart wrote:
> > > Hi Simon,
> > > 
> > > I'm afraid you added nodes in the wrong places when applying the patch to
> > > salvator-x.dtsi :-( Please see below.
> > > 
> > > On Thursday 27 Apr 2017 17:43:56 Laurent Pinchart wrote:
> > >> Hi Ulrich,
> > >> 
> > >> Thank you for the patch.
> > >> 
> > >> On Thursday 27 Apr 2017 16:37:39 Ulrich Hecht wrote:
> > >>> The panel backlight is controlled through a GPIO and a PWM channel.
> > >>> 
> > >>> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > >> 
> > >> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > >> 
> > >>> ---
> > >>> 
> > >>>  arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 22 +++++++++++++
> > >>>  1 file changed, 22 insertions(+)
> > >>> 
> > >>> diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> > >>> b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts index
> > >>> 14d9e51..abda84c
> > >>> 100644
> > >>> --- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> > >>> +++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
> > >>> @@ -133,6 +133,11 @@
> > >>>  		function = "i2c2";
> > >>>  	};
> > >>> 
> > >>> +	pwm1_pins: pwm {
> > >>> +		groups = "pwm1_a";
> > >>> +		function = "pwm1";
> > >>> +	};
> > >>> +
> > > 
> > > This is alphabetically ordered here and isn't anymore in your devel
> > > branch.
> > 
> > Thanks, I  will move it from between scif_clk_pins and sdhi0_pins to
> > between i2c2_pins and scif1_pins.
> > 
> > >>>  	sdhi0_pins: sd0 {
> > >>>  		groups = "sdhi0_data4", "sdhi0_ctrl";
> > >>>  		function = "sdhi0";
> > >>> @@ -183,6 +188,16 @@
> > >>>  		interrupt-parent = <&gpio2>;
> > >>>  		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
> > >>>  	};
> > >>> +
> > >>> +	backlight: backlight {
> > >>> +		compatible = "pwm-backlight";
> > >>> +		pwms = <&pwm1 0 50000>;
> > >>> +
> > >>> +		brightness-levels = <256 128 64 16 8 4 0>;
> > >>> +		default-brightness-level = <6>;
> > >>> +
> > >>> +		enable-gpios = <&gpio6 7 GPIO_ACTIVE_HIGH>;
> > >>> +	};
> > > 
> > > The backlight node needs to be added as a child of the root node, while
> > > you've added it to the DU node in your devel branch.
> > 
> > Thanks. I have moved it to between audio_clkout and reg_1p8v in
> > the root node.
> > 
> > >>>  };
> > >>>  
> > >>>  &extal_clk {
> > >>> @@ -235,6 +250,13 @@
> > >>>  	status = "okay";
> > >>>  };
> > >>> 
> > >>> +&pwm1 {
> > >>> +	pinctrl-0 = <&pwm1_pins>;
> > >>> +	pinctrl-names = "default";
> > >>> +
> > >>> +	status = "okay";
> > >>> +};
> > >>> +
> > > 
> > > This is alphabetically ordered here and isn't anymore in your devel
> > > branch.
> > 
> > Thanks, I have moved it from between rcar_sound and scif1 to
> > between pfc and rcar_sound.
> > 
> > > Can you rebase your devel branch to fix this ?
> > 
> > Sure. I have the following in my local tree which I plan to push
> > a later today.
> 
> That looks good to me, thank you !

Thanks for checking.
