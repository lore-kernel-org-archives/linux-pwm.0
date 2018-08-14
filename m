From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC PATCH 0/7] add at91sam9 LCDC DRM driver
Date: Tue, 14 Aug 2018 18:43:43 +0200
Message-ID: <20180814164343.GA13848@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
 <f1f2a2d7-ae27-87af-8041-93d3f8fe07cc@microchip.com>
 <20180813181808.GA2357@ravnborg.org>
 <20180813220454.GA28913@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180813220454.GA28913@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pwm@vger.kernel.org, Joshua Henderson <joshua.henderson@microchip.com>, dri-devel@lists.freedesktop.org, Boris Brezillon <boris.brezillon@bootlin.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Rob.

> I don't know that 2 registers for a backlight PWM constitute an MFD. A 
> single node can be both an LCD controller and a PWM.

Current suggestion from v1 patchset looks like this:
	lcdc0: lcdc@700000 {
		compatible = "atmel,at91sam9263-lcdc-mfd";
		reg = <0x700000 0x1000>;
		interrupts = <26 IRQ_TYPE_LEVEL_HIGH 3>;
		clocks = <&lcd_clk>, <&lcd_clk>;
		clock-names = "lcdc_clk", "hclk";

		lcdc-display-controller {
			compatible = "atmel,lcdc-display-controller";
			lcd-supply = <&lcdc_reg>;

			port@0 {
			};
		};

		lcdc_pwm: lcdc-pwm {
			compatible = "atmel,lcdc-pwm";
			#pwm-cells = <3>;
		};

	};

        backlight: backlight {
                compatible = "pwm-backlight";
                pwms = <&lcdc_pwm 0 50000 0>;
        };


We could have described the full binding in one file, rather than in
three files like it is done in v1. But the structure was done so it matched
what was done for hlcdc.


If I understand the proposal from you correct an example binding would
look like this:

       lcdc0: lcdc@700000 {
                compatible = "atmel,at91sam9263-lcdc";
                reg = <0x700000 0x1000>;
                interrupts = <26 IRQ_TYPE_LEVEL_HIGH 3>;
                clocks = <&lcd_clk>, <&lcd_clk>;
                clock-names = "lcdc_clk", "hclk";

                lcd-supply = <&lcdc_reg>;

                port@0 {
                };

                #pwm-cells = <3>;
        };

        backlight: backlight {
                compatible = "pwm-backlight";
                pwms = <&lcd0 0 50000 0>;
        };


This is doable, but IMO it is less obvious that the LCDC IP core implements
two different features - a PWM and a LCD controller.
Right now the preference is to stay with the v1 approach:
- It is a mirror of what we do today for hlcdc, so no suprises
- It shows in a nice way that the LCDC IP core implments both an LCD controller and a PWM
- The pwm functionality is not hiddin inside the lcdc stuff, and it is thus
  simpler to add good pin-ctrl handles with nice names that matches the usage.
  (I could always add more pin-ctrl, but it is common to refer to a single pin-ctrl.


One DT related Q:
The LCD Controller supports BGR565, but as this is less common some HW implmentations
exchange R and B, expessed in the old binding as wiring-mode like this:

	atmel,lcd-wiring-mode: lcd wiring mode "RGB" or "BRG"

How can we express this wiring-mode in a generic way, both in DT and in code?
Is it something that in DRM belongs to the panel, the encoder, the connector, or?
And can any of the exisitng flags be used?

Thanks in advance,

	Sam
