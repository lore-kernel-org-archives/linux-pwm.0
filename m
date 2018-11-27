From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 1/6] Documentation: ARM: sunxi: pwm: add Allwinner
 sun8i.
Date: Tue, 27 Nov 2018 08:04:18 +0100
Message-ID: <20181127070418.khdi4wslyv4lmngv@pengutronix.de>
References: <20181125161859.GA5277@arx-s1>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181125161859.GA5277@arx-s1>
Sender: linux-kernel-owner@vger.kernel.org
To: Hao Zhang <hao5781286@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org, mturquette@baylibre.com, sboyd@kernel.org, thierry.reding@gmail.com, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-pwm@vger.kernel.org

Hello,

On Mon, Nov 26, 2018 at 12:18:59AM +0800, Hao Zhang wrote:
> This patch adds Allwinner sun8i pwm binding document.
> 
> Signed-off-by: Hao Zhang <hao5781286@gmail.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sun8i.txt          | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> new file mode 100644
> index 0000000..7531d85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> @@ -0,0 +1,24 @@
> +Allwinner sun8i R40/V40/T3 SoC PWM controller
> +
> +Required properties:
> +  - compatible: Should be one of:
> +    - "allwinner,sun8i-r40-pwm"
> +  - reg: Physical base address and length of the controller's registers
> +  - interrupts: Should contain interrupt.
> +  - clocks: From common clock binding, handle to the parent clock.
> +  - clock-names: Must contain the clock names described just above.
> +  - pwm-channels: PWM channels of the controller.
> +  - #pwm-cells: Should be 3. See pwm.txt in this directory for a description of
> +    the cells format.

I wonder why "interrupts" is needed here. I guess this is only needed
for waveform capture? Is this only "optional"? The driver doesn't use
it.

Apart from this interrupts property this is all pretty standard and I
wonder if we could merge several documents into one.

For example Documentation/devicetree/bindings/pwm/pwm-st.txt looks
identically apart from "pwm-channels" being called "st,pwm-num-chan"
there. (It even has an interrupts property. Should the st driver move to
"pwm-channels", too?)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
